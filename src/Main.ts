import AppService from './matrix/AppService';
import { DataSource, DataSourceOptions } from 'typeorm';
import { Client, ClientWebsocket } from './mattermost/Client';
import * as logLevel from 'loglevel';
import * as mxClient from './matrix/MatrixClient';
import * as util from 'util';

import { Config, setConfig, config, RELOADABLE_CONFIG } from './Config';
import { isDeepStrictEqual } from 'util';
import {
    notifySystemd,
    allSettled,
    loadYaml,
    getPackageInfo,
} from './utils/Functions';
import { User } from './entities/User';
import { Post } from './entities/Post';
import * as dbMapping from './entities/Mapping';
import { MatrixClient } from './matrix/MatrixClient';
import * as log4js from 'log4js';
import {
    MattermostMessage,
    Registration,
    MatrixEvent,
    Mapping,
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
import {
    MattermostMainHandlers,
    MattermostUnbridgedHandlers,
} from './mattermost/MattermostHandler';

interface TeamInfo {
    id: string;
    name: string;
}

export default class Main extends EventEmitter {
    private ws: ClientWebsocket = undefined as any;
    private readonly appService: AppService;
    public readonly registration: Registration;
    public dataSource: DataSource = undefined as any;
    private defaultTeam: TeamInfo = {} as any;

    private matrixQueue: EventQueue<MatrixEvent> = undefined as any;
    private mattermostQueue: EventQueue<MattermostMessage> = undefined as any;
    private myLogger: log4js.Logger;

    public botClient: mxClient.MatrixClient;
    public adminClient: mxClient.MatrixClient;

    public initialized: boolean;
    public killed: boolean;

    public readonly client: Client;

    public readonly channelsByMatrix: Map<string, Channel>;
    public readonly channelsByMattermost: Map<string, Channel>;
    public readonly channelsByTeam: Map<string, Channel[]>;

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
        this.adminClient = new MatrixClient({
            accessToken: config.matrix_admin.access_token,
            userId: config.matrix_admin.username,
            apiTrace: this.traceApi,
            baseUrl: config.homeserver.url,
        });

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
    }

    private async getMyJoinedPublicRooms(client: MatrixClient): Promise<any[]> {
        let publicRooms = await client.getPublicRooms(1000);
        let myRooms = await client.getJoinedRooms();

        let myPublicRooms: any[] = [];
        for (let room of publicRooms.chunk) {
            let foundRoom = myRooms.joined_rooms.filter(
                joined => joined == room.room_id,
            );
            if (foundRoom.length > 0) {
                myPublicRooms.push(room);
            }
        }
        return myPublicRooms;
    }

    public async onChannelCreated(channelId) {
        const botId = config().mattermost_bot_userid;
        try {
            const channel = await this.client.get(`/channels/${channelId}`);
            if (channel.team_id != this.defaultTeam.id) {
                const message = `Only channels in default team ${this.defaultTeam.name} can be mapped to Matrix room`;
                this.myLogger.info(message);
                await this.client.delete(
                    `/channels/${channelId}/members/${botId}`,
                );
                await this.client.post('/posts', {
                    channel_id: channel.id,
                    message: message,
                });

                return false;
            }
            const myPublicRooms: any[] = await this.getMyJoinedPublicRooms(
                this.adminClient,
            );
            return await this.mapMattermostToMatrix(
                channel,
                myPublicRooms,
                true,
            );
        } catch (error) {
            this.myLogger.error(
                'Error in getting channel for mapping %s',
                error.message,
            );
            throw error;
        }
    }

    public doOneMapping(channelId, roomId) {
        const map: Mapping = {
            mattermost: channelId,
            matrix: roomId,
        };
        const ch = new Channel(this, map.matrix, map.mattermost);
        this.channelsByMattermost.set(map.mattermost, ch);
        this.channelsByMatrix.set(map.matrix, ch);
        this.mappingsByMattermost.set(map.mattermost, map);
        this.mappingsByMatrix.set(map.matrix, map);
    }

    private async mapMattermostToMatrix(
        channel,
        myPublicRooms,
        interactive: boolean = false,
    ): Promise<boolean> {
        let found = false;
        const myId = config().mattermost_bot_userid;
        const server_name = config().homeserver.server_name;
        const creatorId = channel.creator_id;
        try {
            if (creatorId !== '' && creatorId !== myId) {
                const userInfo = await this.client.get(`/users/${creatorId}`);
                if (!userInfo.roles.includes('system_admin')) {
                    const message = `Only system administrators can map channels for Matrix integration. Not ok for user ${userInfo.username} with roles ${userInfo.roles}`;
                    this.myLogger.info(message);
                    await this.client.delete(
                        `/channels/${channel.id}/members/${myId}`,
                    );
                    await this.client.post('/posts', {
                        channel_id: channel.id,
                        message: message,
                    });
                    return false;
                }
            }
            for (let room of myPublicRooms) {
                const alias: string = `#${channel.name}:${server_name}`;
                if (
                    channel.display_name === room.name ||
                    alias === room.canonical_alias
                ) {
                    this.doOneMapping(channel.id, room.room_id);
                    found = true;
                    this.myLogger.debug(
                        'Matrix channel %s:%s mapped matrix room %s:%s',
                        channel.display_name,
                        channel.name,
                        room.name,
                        room.canonical_alias,
                    );
                    if (interactive) {
                        const message = `Matrix channel mapped to matrix room ${room.name} with alias ${room.canonical_alias}`;
                        await this.client.post('/posts', {
                            channel_id: channel.id,
                            message: message,
                        });
                    }

                    return true;
                }
            }

            if (found === false) {
                const info = await this.createPublicMatrixRoom(channel);
                await this.botClient.joinRoom(
                    info.room_id,
                    `Mapping of mattermost channel ${channel.name}`,
                );
                if (interactive) {
                    const message = `New matrix room ${info.name} with alias ${info.room_alias_name} mapped to the channel.`;
                    await this.client.post('/posts', {
                        channel_id: channel.id,
                        message: message,
                    });
                }
            }
        } catch (error) {
            this.myLogger.error(
                'Failed to map channel %s to matrix room. Error=%s',
                channel.name,
                error.message,
            );
            return false;
        }
        return true;
    }

    private async createPublicMatrixRoom(
        channel: any,
    ): Promise<mxClient.RoomCreatedInfo> {
        const matrixRoom: mxClient.RoomCreateContent = {
            preset: 'public_chat',
            is_direct: false,
            visibility: 'public',
            name: channel.display_name,
            room_alias_name: channel.name,
            invite: [this.botClient.getUserId()],
        };
        const info = await this.adminClient.createRoom(matrixRoom);

        const map: Mapping = {
            mattermost: channel.id,
            matrix: info.room_id,
        };
        const ch = new Channel(this, map.matrix, map.mattermost);
        this.channelsByMattermost.set(map.mattermost, ch);
        this.channelsByMatrix.set(map.matrix, ch);
        this.mappingsByMattermost.set(map.mattermost, map);
        this.mappingsByMatrix.set(map.matrix, map);
        this.myLogger.debug(
            'New matrix room %s created. Mapped to mattermost channel %s',
            info.room_id,
            channel.name,
        );
        let roomInfo: mxClient.RoomCreatedInfo = {} as any;
        roomInfo = Object.assign(roomInfo, matrixRoom, {
            room_id: info.room_id,
        });
        return roomInfo;
    }

    private async doInitialMapping() {
        const myId = config().mattermost_bot_userid;
        try {
            const myTeams = await this.client.get(`/users/${myId}/teams`);

            const myPublicRooms: any[] = await this.getMyJoinedPublicRooms(
                this.adminClient,
            );

            if (myTeams.length > 0) {
                // We only map channels in the default team now
                const teamId = myTeams[0].id;
                this.defaultTeam = { id: teamId, name: myTeams[0].name };
                const teamChannels = await this.client.get(
                    `/users/${myId}/teams/${teamId}/channels`,
                );

                const publicChannels = teamChannels.filter(channel => {
                    return channel.type === 'O';
                });
                for (let channel of publicChannels) {
                    await this.mapMattermostToMatrix(channel, myPublicRooms);
                }
            } else {
                this.myLogger.warn('No teams for mattermost bot user');
            }
            /*
             * Do mappings from database table mapping. It includes the mappings for direct messages.
             */
            const dbMappings = await dbMapping.Mapping.find({});
            this.myLogger.info(
                'Found %d mappings in database table mappings for private Channels/Rooms',
                dbMappings.length,
            );
            for (let dbMap of dbMappings) {
                this.myLogger.info(
                    '\tChannel id=%s, Room id=%s',
                    dbMap.mattermost_channel_id,
                    dbMap.matrix_room_id,
                );
                this.doOneMapping(
                    dbMap.mattermost_channel_id,
                    dbMap.matrix_room_id,
                );
            }
        } catch (error) {
            this.myLogger.error(error.message);

            this.killBridge(1);
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
        await this.doInitialMapping();

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
                    const count = await dbMapping.Mapping.count({
                        where: {
                            mattermost_channel_id: channel.mattermostChannel,
                        },
                    });
                    if (count === 0) {
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
                    }
                } catch (e) {
                    await onChannelError(e, channel);
                }
            }),
        );

        await Promise.all(
            Array.from(this.channelsByMattermost, async ([, channel]) => {
                try {
                    const count = await dbMapping.Mapping.count({
                        where: {
                            mattermost_channel_id: channel.mattermostChannel,
                        },
                    });
                    if (count === 0) {
                        await channel.syncChannel();
                        const team = await channel.getTeam();
                        const channels = this.channelsByTeam.get(team);
                        if (channels === undefined) {
                            this.channelsByTeam.set(team, [channel]);
                        } else {
                            channels.push(channel);
                        }
                    }
                } catch (e) {
                    await onChannelError(e, channel);
                }
            }),
        );

        this.myLogger.info(
            'Number of channels bridged successfully =%d',
            this.channelsByMattermost.size,
        );

        await appservice;
        await this.ws.open();

        log.timeEnd.info('Bridge initialized');

        void notifySystemd();
        this.initialized = true;
        this.emit('initialize');
    }

    private async setupDataSource(): Promise<void> {
        const db: any = Object.assign({}, config().database);
        db['entities'] = [User, Post, dbMapping.Mapping];
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

    public async killBridge(exitCode: number): Promise<void> {
        const killed = this.killed;
        this.killed = true;

        this.emit('kill');
        if (killed) {
            return;
        }
        // Logout all Matrix Clients
        await this.mattermostUserStore.logoutClients();
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
        this.myLogger.debug(
            `Mattermost message:\n`,
            util.inspect(m, { showHidden: false, depth: 3, colors: true }),
        );

        const handler = MattermostMainHandlers[m.event];
        try {
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
                    const ubHandler = MattermostUnbridgedHandlers[m.event];
                    if (ubHandler) {
                        await ubHandler.bind(this)(m);
                    } else {
                        this.myLogger.debug(
                            `Message for unknown channel_id: ${m.broadcast.channel_id}`,
                        );
                    }
                }
            } else if (m.broadcast.team_id !== '') {
                const channels = this.channelsByTeam.get(m.broadcast.team_id);
                if (channels === undefined) {
                    this.myLogger.debug(
                        `Message for unknown team: ${m.broadcast.team_id}`,
                    );
                } else {
                    await Promise.all(
                        channels.map(c => c.onMattermostMessage(m)),
                    );
                }
            } else {
                this.myLogger.debug(`Unknown event type: ${m.event}`);
            }
        } catch (error) {
            this.myLogger.fatal(
                `Fatal error on mattermost event ${m.event}. Error=${error.message}`,
            );
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
