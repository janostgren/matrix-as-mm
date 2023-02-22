import AppService from './matrix/AppService';
import { run } from './db-test/index';
import { DataSource, DataSourceOptions } from 'typeorm';
import { Client, ClientWebsocket } from './mattermost/Client';
import * as logLevel from 'loglevel';
import * as mxClient from './matrix/MatrixClient';

import {
    Config,
    Mapping,
    setConfig,
    config,
    RELOADABLE_CONFIG,
} from './Config';
import { isDeepStrictEqual } from 'util';
import {
    notifySystemd,
    allSettled,
    loadYaml,
    getPackageInfo,
} from './utils/Functions';
import { User } from './entities/User';
import { Post } from './entities/Post';
import * as log4js from 'log4js';
import {
    MattermostMessage,
    Registration,
    MatrixMessage,
    MatrixEvent,
} from './Interfaces';
import MatrixUserStore from './matrix/MatrixUserStore';
import {
    getMatrixClient,
    loginAppService,
    registerAppService,
} from './matrix/Utils';
import MattermostUserStore from './mattermost/MattermostUserStore';
import { joinMattermostChannel } from './mattermost/Utils';
import Channel from './Channel';
import EventQueue from './utils/EventQueue';
import log, { getLogger } from './Logging';
import { EventEmitter } from 'events';
import { MattermostMainHandlers } from './mattermost/MattermostHandler';

export default class Main extends EventEmitter {
    private ws: ClientWebsocket = undefined as any;
    private readonly appService: AppService;
    public readonly registration: Registration;
    public dataSource: DataSource = undefined as any;

    private matrixQueue: EventQueue<MatrixEvent> = undefined as any;
    private mattermostQueue: EventQueue<MattermostMessage> = undefined as any;
    private myLogger: log4js.Logger;

    public botClient: mxClient.MatrixClient;

    public initialized: boolean;
    public killed: boolean;

    public readonly client: Client;

    public readonly channelsByMatrix: Map<string, Channel>;
    public readonly channelsByMattermost: Map<string, Channel>;
    public readonly channelsByTeam: Map<string, Channel[]>;

    // Channels include successfully bridge channels.
    // Mappings are ones that are specified in the config file
    public readonly mappingsByMatrix: Map<string, Mapping>;
    public readonly mappingsByMattermost: Map<string, Mapping>;

    public readonly matrixUserStore: MatrixUserStore;
    public readonly mattermostUserStore: MattermostUserStore;

    constructor(
        config: Config,
        registrationPath: string,
        private readonly exitOnFail: boolean = true,
        private readonly traceApi: boolean = false,
    ) {
        super();
        setConfig(config);
        const logConfigFile = `${__dirname}/../config/log4js.json`;
        log4js.configure(logConfigFile);

        this.myLogger = getLogger('Main');
        logLevel.setLevel(config.logging);

        this.registration = loadYaml(registrationPath);

        this.appService = new AppService(this);

        this.botClient = getMatrixClient(
            this.registration,
            `@${config.matrix_bot.username}:${config.homeserver.server_name}`,
            this.traceApi,
        );

        this.initialized = false;

        this.client = new Client(
            config.mattermost_url,
            config.mattermost_bot_userid,
            config.mattermost_bot_access_token,
        );
        //this.ws = this.client.websocket();

        this.channelsByMatrix = new Map();
        this.channelsByMattermost = new Map();
        this.channelsByTeam = new Map();

        this.mappingsByMatrix = new Map();
        this.mappingsByMattermost = new Map();

        this.mattermostUserStore = new MattermostUserStore(this);
        this.matrixUserStore = new MatrixUserStore(this);

        this.killed = false;

        for (const map of config.mappings) {
            if (this.mappingsByMattermost.has(map.mattermost)) {
                this.myLogger.error(
                    `Mattermost channel ${map.mattermost} already bridged. Skipping bridge ${map.mattermost} <-> ${map.matrix}`,
                );
                if (config.forbid_bridge_failure) {
                    void this.killBridge(1);
                    return;
                }
                continue;
            }
            if (this.mappingsByMatrix.has(map.matrix)) {
                this.myLogger.error(
                    `Matrix channel ${map.matrix} already bridged. Skipping bridge ${map.mattermost} <-> ${map.matrix}`,
                );
                if (config.forbid_bridge_failure) {
                    void this.killBridge(1);
                    return;
                }
                continue;
            }

            const channel = new Channel(this, map.matrix, map.mattermost);
            this.channelsByMattermost.set(map.mattermost, channel);
            this.channelsByMatrix.set(map.matrix, channel);

            this.mappingsByMattermost.set(map.mattermost, map);
            this.mappingsByMatrix.set(map.matrix, map);
        }
    }

    public async init(): Promise<void> {
        log.time.info('Bridge initialized');
        const packInfo = getPackageInfo();

        this.myLogger.debug(
            '%s(%s) started with %s',
            packInfo.name,
            packInfo.version,
            process.argv,
        );
        this.ws = this.client.websocket();

        await this.setupDataSource();

        await registerAppService(
            this.botClient,
            config().matrix_bot.username,
            this.myLogger,
        );
        /*
        let info =await loginAppService(
            this.botClient,
            config().matrix_bot.username
        );        
        this.myLogger.info("Login as app service: %s",info)
        this.botClient.setAccessToken(info.access_token)
        */

        try {
            await this.updateBotProfile();
        } catch (e) {
            this.myLogger.warn(`Error when updating bot profile\n${e.stack}`);
        }

        this.ws.on('error', e => {
            this.myLogger.error(
                `Error when initializing websocket connection.\n${e.stack}`,
            );
        });

        this.ws.on('close', async e => {
            this.myLogger.error(
                'Mattermost websocket closed. Shutting down bridge. Code=%d',
                e,
            );
            await this.killBridge(1);
        });

        this.mattermostQueue = new EventQueue({
            emitter: this.ws,
            event: 'message',
            description: 'mattermost',
            callback: this.onMattermostMessage.bind(this),
            filter: async m => {
                const userid = m.data.user_id ?? m.data.user?.id;
                return (
                    userid &&
                    (this.skipMattermostUser(userid) ||
                        !(await this.isMattermostUser(userid)))
                );
            },
            parent: this,
        });
        this.matrixQueue = new EventQueue({
            emitter: this.appService,
            event: 'event',
            description: 'matrix',
            callback: this.onMatrixEvent.bind(this),
            filter: async e => this.isRemoteUser(e.sender),
            parent: this,
        });

        const appservice = this.appService.listen(
            config().appservice.port,
            config().appservice.bind || config().appservice.hostname,
        );

        let rooms = await this.botClient.getJoinedRooms();

        const onChannelError = async (e: Error, channel: Channel) => {
            this.myLogger.error(
                `Error when syncing ${channel.matrixRoom} with ${channel.mattermostChannel}\n error=${e}`,
            );
            if (config().forbid_bridge_failure) {
                await this.killBridge(1);
            }
            this.channelsByMattermost.delete(channel.mattermostChannel);
            this.channelsByMatrix.delete(channel.matrixRoom);
        };

        // joinMattermostChannel on actual users queries the status of the
        // corresponding matrix room. Thus, we must make sure our bot has
        // already joined.

        await Promise.all(
            Array.from(this.channelsByMattermost, async ([, channel]) => {
                try {
                    let foundRoom = rooms.joined_rooms.find(room => {
                        return room === channel.matrixRoom;
                    });
                    if (!foundRoom) {
                        await this.botClient.joinRoom(channel.matrixRoom);
                    }
                    await joinMattermostChannel(
                        channel,
                        User.create({
                            mattermost_userid: this.client.userid,
                        }),
                    );
                } catch (e) {
                    await onChannelError(e, channel);
                }
            }),
        );

        await Promise.all(
            Array.from(this.channelsByMattermost, async ([, channel]) => {
                try {
                    await channel.syncChannel();
                    const team = await channel.getTeam();
                    const channels = this.channelsByTeam.get(team);
                    if (channels === undefined) {
                        this.channelsByTeam.set(team, [channel]);
                    } else {
                        channels.push(channel);
                    }
                } catch (e) {
                    await onChannelError(e, channel);
                }
            }),
        );

        try {
            await this.leaveUnbridgedChannels();
        } catch (e) {
            this.myLogger.error(
                `Error when leaving unbridged channels\n${e.stack}`,
            );
            if (config().forbid_bridge_failure) {
                await this.killBridge(1);
            }
        }

        if (this.channelsByMattermost.size === 0) {
            this.myLogger.info(
                'No channels bridged successfully. Shutting down bridge.',
            );
            // If we exit before notifying systemd, it is considered a failure
            await notifySystemd();
            await this.killBridge(0);
            return;
        }

        await appservice;
        await this.ws.open();

        log.timeEnd.info('Bridge initialized');

        void notifySystemd();
        this.initialized = true;
        this.emit('initialize');
    }

    private async leaveUnbridgedChannels(): Promise<void> {
        await Promise.all([
            this.leaveUnbridgedMattermostChannels(),
            this.leaveUnbridgedMatrixRooms(),
        ]);
    }

    private async setupDataSource(): Promise<void> {
        const db: any = Object.assign({}, config().database);
        db['entities'] = [User, Post];
        db['synchronize'] = false;
        if (this.traceApi) {
            db['logging'] = ['query', 'error'];
            db.logger = 'advanced-console';
        }

        let dataSource: DataSource = new DataSource(db);

        try {
            this.dataSource = await dataSource.initialize();
            this.myLogger.info(
                'Data source to %s at %s database=%s ',
                db.type,
                db.host,

                db.database,
            );
            //return this.dataSource;
        } catch (error) {
            this.myLogger.fatal(
                'Failed to setup data source to meta database=%s. Error=%s ',
                db.database,
                error.message,
            );
            this.killBridge(1);
        }
    }

    private async leaveUnbridgedMatrixRooms(): Promise<void> {
        const resp = await this.botClient.getJoinedRooms();
        const rooms = resp.joined_rooms;

        await Promise.all(
            rooms.map(async room => {
                if (this.mappingsByMatrix.has(room)) {
                    return;
                }

                const members: string[] = [];
                let resp = await this.botClient.getRoomMembers(room);
                if (resp) {
                    for (let member of resp.chunk) {
                        members.push(member.sender);
                    }
                }
                await Promise.all(
                    members.map(async userid => {
                        if (this.isRemoteUser(userid)) {
                            await getMatrixClient(
                                this.registration,
                                userid,
                            ).leave(room);
                        }
                    }),
                );
                await this.botClient.leave(room);
            }),
        );
    }

    private async leaveUnbridgedMattermostChannels(): Promise<void> {
        const mattermostTeams = await this.client.get(
            `/users/${this.client.userid}/teams`,
        );

        const leaveMattermost = async (type: string, id: string) => {
            const members = await this.client.get(
                `/${type}s/${id}/members?page=0&per_page=10000`,
            );
            await Promise.all(
                members.map(async member => {
                    const user = await this.matrixUserStore.getByMattermost(
                        member.user_id,
                    );
                    if (user !== null) {
                        await user.client.delete(
                            `/${type}s/${id}/members/${member.user_id}`,
                        );
                    }
                }),
            );
            await this.client.delete(
                `/${type}s/${id}/members/${this.client.userid}`,
            );
        };

        await Promise.all(
            mattermostTeams.map(async team => {
                const teamId = team.id;
                const channels = await this.client.get(
                    `/users/${this.client.userid}/teams/${teamId}/channels`,
                );

                if (!channels.some(c => this.mappingsByMattermost.has(c.id))) {
                    await leaveMattermost('team', teamId);
                    return;
                }

                await Promise.all(
                    channels.map(async channel => {
                        if (this.mappingsByMattermost.has(channel.id)) {
                            return;
                        }
                        if (channel.name === 'town-square') {
                            // cannot leave town square
                            return;
                        }
                        await leaveMattermost('channel', channel.id);
                    }),
                );
            }),
        );
    }

    public async killBridge(exitCode: number): Promise<void> {
        const killed = this.killed;
        this.killed = true;

        this.emit('kill');
        if (killed) {
            return;
        }
        try {
            if (this.botClient.isSessionValid()) {
                await this.botClient.logout();
            }
            this.myLogger.info('MatrixClient logged out. Session invalidated.');
        } catch (ignore) {}

        // Destroy DataSource
        if (this.dataSource && this.dataSource.isInitialized) {
            await this.dataSource.destroy();
        }

        // Otherwise, closing the websocket connection will initiate
        // the shutdown sequence again.
        if (this.ws && this.ws.initialized()) {
            this.ws.removeAllListeners('close');
            await this.ws.close();
        }
        if (this.initialized) {
            const results = await allSettled([
                this.appService.close(),
                this.matrixQueue.kill(),
                this.mattermostQueue.kill(),
            ]);

            for (const result of results) {
                if (result.status === 'rejected') {
                    this.myLogger.warn(
                        `Warning when killing bridge: ${result.reason}`,
                    );
                    exitCode = 1;
                }
            }
        }

        if (this.exitOnFail) {
            process.exit(exitCode);
        }
    }

    public async updateConfig(newConfig: Config): Promise<void> {
        // There is no easy way to get the list of all possible config keys.
        // However, the ones that could have changed must be a key in either
        // the new one or the old one.
        const oldConfig = config();
        const keys = new Set([
            ...Object.keys(oldConfig),
            ...Object.keys(newConfig),
        ]);

        for (const key of keys) {
            if (
                !RELOADABLE_CONFIG.has(key) &&
                !isDeepStrictEqual(oldConfig[key], newConfig[key])
            ) {
                throw new Error(`Cannot hot reload config ${key}`);
            }
        }
        //log.setLevel(newConfig.logging);
        setConfig(newConfig, false);
    }

    private async updateBotProfile(): Promise<void> {
        const targetProfile = config().matrix_bot;
        const profile: any = await this.botClient
            .getProfileInfo(this.botClient.getUserId() || '')
            .catch(() => ({ display_name: '' }));
        if (
            targetProfile.display_name &&
            profile.displayname !== targetProfile.display_name
        ) {
            await this.botClient.setUserDisplayName(
                this.botClient.getUserId(),
                targetProfile.display_name,
            );
        }
    }

    private async onMattermostMessage(m: MattermostMessage): Promise<void> {
        this.myLogger.debug(`Mattermost message: ${JSON.stringify(m)}`);
        

        const handler = MattermostMainHandlers[m.event];
        if (handler !== undefined) {
            await handler.bind(this)(m);
        } else if (m.broadcast.channel_id !== '') {
            // We may have been invited to channels that are not bridged;
            const channel = this.channelsByMattermost.get(
                m.broadcast.channel_id,
            );
            if (channel !== undefined) {
                await channel.onMattermostMessage(m);
            } else {
                this.myLogger.debug(
                    `Message for unknown channel_id: ${m.broadcast.channel_id}`,
                );
            }
        } else if (m.broadcast.team_id !== '') {
            const channels = this.channelsByTeam.get(m.broadcast.team_id);
            if (channels === undefined) {
                this.myLogger.debug(
                    `Message for unknown team: ${m.broadcast.team_id}`,
                );
            } else {
                await Promise.all(channels.map(c => c.onMattermostMessage(m)));
            }
        } else {
            this.myLogger.debug(`Unknown event type: ${m.event}`);
        }
    }

    private async onMatrixEvent(event: MatrixEvent): Promise<void> {
        this.myLogger.debug(`Matrix event: ${JSON.stringify(event)}`);
        const channel = this.channelsByMatrix.get(event.room_id || '');
        if (channel !== undefined) {
            await channel.onMatrixEvent(event);
        } else {
            /*
            event.type === 'm.room.member' &&
            event.content.membership === 'invite' &&
            event.state_key &&
            (event.state_key === this.botClient.userId ||
                this.isRemoteUser(event.state_key)) &&
            event.content.is_direct
        ) {
            const client = getMatrixClient(this.registration, event.state_key);
            await client.sendEvent(event.room_id, 'm.room.message', {
                body: 'Private messaging is not supported for this bridged user',
                msgtype: 'm.notice',
            });
            await client.leave(event.room_id);
            */
            let z = 1;
            if (z === 1) {
                this.myLogger.debug(
                    `Message for unknown room: ${event.room_id}`,
                );
            }
        }
    }

    public async isMattermostUser(userid: string): Promise<boolean> {
        return (await this.matrixUserStore.getByMattermost(userid)) === null;
    }

    public isRemoteUser(userid: string): boolean {
        const re = this.registration.namespaces.users[0].regex;
        return new RegExp(re).test(userid);
    }

    public skipMattermostUser(userid: string): boolean {
        const botMattermostUser = this.client.userid;
        const ignoredMattermostUsers = config().ignored_mattermost_users ?? [];
        return (
            userid === botMattermostUser ||
            ignoredMattermostUsers.includes(userid)
        );
    }

    public skipMatrixUser(userid: string): boolean {
        const botMatrixUser = this.botClient.getUserId();
        const ignoredMatrixUsers = config().ignored_matrix_users ?? [];
        return userid === botMatrixUser || ignoredMatrixUsers.includes(userid);
    }
}
