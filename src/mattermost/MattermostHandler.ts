import * as log4js from 'log4js';
import * as mxClient from '../matrix/MatrixClient';
import Channel from '../Channel';
import { Post } from '../entities/Post';
import Main from '../Main';
import { getLogger } from '../Logging';
import {
    MattermostMessage,
    MattermostPost,
    MatrixMessage,
    MatrixEvent,
    MattermostFileInfo,
} from '../Interfaces';
import { config } from '../Config'
//import { joinMatrixRoom } from '../matrix/Utils';
import { handlePostError, none } from '../utils/Functions';
import { mattermostToMatrix, constructMatrixReply } from '../utils/Formatting';
import * as fs from 'fs'
import * as path from 'path';
import * as util from 'util';

const myLogger: log4js.Logger = getLogger('MattermostHandler');

interface Metadata {
    replyTo?: {
        matrix: string;
        mattermost: string;
    };
}

const matrixUsersInRoom: Map<string, string> = new Map<string, string>();

async function joinUserToMatrixRoom(
    client: mxClient.MatrixClient,
    roomId: string,
    ownerClient: mxClient.MatrixClient,
) {
    const userId = client.getUserId() || '';
    const roomKey: string = `${userId}:${roomId}`;
    if (userId) {

        if (matrixUsersInRoom.get(roomKey) === undefined) {
            const rooms = await client.getJoinedRooms();
            const foundRoom = rooms.joined_rooms.find(room => {
                return room === roomId;
            });
            if (!foundRoom) {
                const inv = await ownerClient.invite(roomId, userId);
                const join = await client.joinRoom(roomId);
            }
            matrixUsersInRoom.set(roomKey, userId)

        }
    }
}


async function sendMatrixMessage(
    client: mxClient.MatrixClient,
    room: string,
    postid: string,
    message: MatrixMessage,
    metadata: Metadata,
) {
    let rootid = postid;
    let original: MatrixEvent = {} as any;
    if (metadata.replyTo !== undefined) {
        const replyTo = metadata.replyTo;
        rootid = replyTo.mattermost;

        try {
            original = await client.getRoomEvent(room, replyTo.matrix);
        } catch (e) { }
        if (original !== undefined) {
            constructMatrixReply(original, message);
        }
    }

    const event = await client.sendMessage(room, 'm.room.message', message);

    await Post.create({
        postid,
        rootid,
        eventid: event.event_id,
    }).save();
    return event.event_id;
}

export const MattermostUnbridgedHandlers = {
    posted: async function (
        this: Main,
        m: MattermostMessage,

    ): Promise<void> {

        if (m.data?.post) {
            const post:MattermostPost = JSON.parse(m.data.post) as MattermostPost
            if (((post.type || '') === 'system_add_to_channel'
                && (post.props?.addedUserId || '') === config().mattermost_bot_userid)) {
                let ok = await this.onChannelCreated(m.broadcast.channel_id)

            }
        }
    },
}



const MattermostPostHandlers = {
    '': async function (
        this: Channel,
        client: mxClient.MatrixClient,
        post: MattermostPost,
        metadata: Metadata,
    ) {
        const postMessage = await mattermostToMatrix(post.message);
        await sendMatrixMessage(
            client,
            this.matrixRoom,
            post.id,
            //await mattermostToMatrix(post.message),
            postMessage,
            metadata,
        );

        if (post.metadata.files !== undefined) {
            for (const file of post.metadata.files) {
                // Read everything into memory to compute content-length
                const body: Buffer = await this.main.client.getFile(file.id)
                let mimetype = file.mime_type;
                let fileName = `${file.name}`;

                let msgtype = 'm.file';

                if (mimetype.startsWith('image/')) {
                    msgtype = 'm.image';
                } else if (mimetype.startsWith('audio/')) {
                    msgtype = 'm.audio';
                } else if (mimetype.startsWith('video/')) {
                    msgtype = 'm.video';
                } else if (file.extension === 'mp4') {
                    mimetype = 'image/mp4';
                    msgtype = 'm.video';

                }

                const url = await client.upload(
                    fileName,
                    file.extension,
                    mimetype,
                    body,
                );

                myLogger.debug(
                    `Sending to Matrix ${msgtype} ${mimetype} ${url}`,
                );
                let info = {
                    size: file.size,
                    mimetype: mimetype
                }
                if (file.height && file.width) {
                    info['w'] = file.width
                    info['h'] = file.height
                }
                await sendMatrixMessage(
                    client,
                    this.matrixRoom,
                    post.id,
                    {
                        msgtype,
                        body: file.name,
                        url,
                        info: info
                    },
                    metadata,
                );
            }
        }

        client
            .sendTyping(this.matrixRoom, client.getUserId(), false, 3000)
            .catch(e =>
                myLogger.warn(
                    `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                ),
            );
    },
    me: async function (
        this: Channel,
        client: mxClient.MatrixClient,
        post: MattermostPost,
        metadata: Metadata,
    ) {
        await sendMatrixMessage(
            client,
            this.matrixRoom,
            post.id,
            await mattermostToMatrix(post.props.message, 'm.emote'),
            metadata,
        );
        client
            .sendTyping(this.matrixRoom, client.getUserId(), false, 3000)
            .catch(e =>
                myLogger.warn(
                    `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                ),
            );
    },
};

export const MattermostHandlers = {

    posted: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const post: MattermostPost = JSON.parse(m.data.post) as MattermostPost;
        if (post.type.startsWith('system_')) {
            return;
        }
        if (post.user_id === config().mattermost_bot_userid) {
            return 
        }

        if (!(await this.main.isMattermostUser(post.user_id))) {
            return;
        }

        const client = await this.main.mattermostUserStore.getClient(
            post.user_id,
        );
        if (client === undefined) {
            return;
        }
        const metadata: Metadata = {};
        if (post.root_id !== '') {
            try {
                const threadResponse = await this.main.client.get(
                    `/posts/${post.root_id}/thread`,
                );

                // threadResponse.order often contains duplicate entries
                const threads = Object.values(threadResponse.posts)
                    .sort((a: any, b: any) => a.create_at - b.create_at)
                    .map((x: any) => x.id);

                const thisIndex = threads.indexOf(post.id);
                const id = threads[thisIndex - 1] as string;
                const replyTo = await Post.findOne({
                    //postid: id
                    where: { postid: id },
                });
                if (replyTo) {
                    metadata.replyTo = {
                        matrix: replyTo.eventid,
                        mattermost: post.root_id,
                    };
                }
            } catch (e) {
                await handlePostError(e, post.root_id);
            }
        }

        const handler = MattermostPostHandlers[post.type];
        if (handler !== undefined) {
            await handler.bind(this)(client, post, metadata);
        } else {
            myLogger.debug(`Unknown post type: ${post.type}`);
        }
    },
    post_edited: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const post = JSON.parse(m.data.post);
        if (!(await this.main.isMattermostUser(post.user_id))) {
            return;
        }
        const client = await this.main.mattermostUserStore.getOrCreateClient(
            post.user_id,
        );

        const matrixEvent = await Post.findOne({
            //postid: post.id,
            where: { postid: post.id },
        });
        const msgtype = post.type === '' ? 'm.text' : 'm.emote';

        const msg = await mattermostToMatrix(post.message, msgtype);
        msg.body = `* ${msg.body}`;
        if (msg.formatted_body) {
            msg.formatted_body = `* ${msg.formatted_body}`;
        }

        if (matrixEvent) {
            msg['m.new_content'] = await mattermostToMatrix(
                post.message,
                msgtype,
            );
            msg['m.relates_to'] = {
                event_id: matrixEvent.eventid,
                rel_type: 'm.replace',
            };
        }
        await client.sendMessage(this.matrixRoom, m.event, {
            msgtype: msg.msgtype,
            body: msg.body,
        });
    },
    post_deleted: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        // See the README for details on the logic.
        const post = JSON.parse(m.data.post);

        // There can be multiple corresponding Matrix posts if it has
        // attachments.
        const matrixEvents = await Post.find({
            where: [{ rootid: post.id }, { postid: post.id }],
        });

        const promises: Promise<unknown>[] = [Post.removeAll(post.postid)];
        // It is okay to redact an event already redacted.
        for (const event of matrixEvents) {
            promises.push(
                //this.main.botClient.redactEvent(this.matrixRoom, event.eventid),
                this.main.botClient.sendStateEvent(
                    this.matrixRoom,
                    'm.room.redaction',
                    this.main.botClient.getUserId(),
                    {
                        event_id: event.eventid,
                    },
                ),
            );
            promises.push(event.remove());
        }
        await Promise.all(promises);
    },
    user_added: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {

        const client = await this.main.mattermostUserStore.getOrCreateClient(
            m.data.user_id,
        );
        await joinUserToMatrixRoom(client, this.matrixRoom, this.main.adminClient);

    },
    user_removed: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const client = await this.main.mattermostUserStore.getClient(
            m.data.user_id,
        );
        if (client !== undefined) {
            await client.leave(this.matrixRoom);
            const roomKey: string = `${client.getUserId()}:${this.matrixRoom}`;
            matrixUsersInRoom.delete(roomKey)

        }
    },
    leave_team: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        await MattermostHandlers.user_removed.bind(this)(m);
    },
    typing: async function (
        this: Channel,
        m: MattermostMessage,
    ): Promise<void> {
        const client = await this.main.mattermostUserStore.getClient(
            m.data.user_id,
        );

        if (client !== undefined) {
            await joinUserToMatrixRoom(
                client,
                this.matrixRoom,
                this.main.adminClient,
            );
            client
                .sendTyping(this.matrixRoom, client.getUserId(), true, 6000)
                .catch(e =>
                    myLogger.warn(
                        `Error sending typing notification to ${this.matrixRoom}\n${e.stack}`,
                    ),
                );
        }
    },
    channel_viewed: none,
};

export const MattermostMainHandlers = {
    hello: none,
    added_to_team: none,
    new_user: none,
    status_change: none,
    channel_viewed: none,
    preferences_changed: none,
    sidebar_category_updated: none,
    channel_created: async function (
        this: Main,
        m: MattermostMessage,

    ): Promise<void> {
        const ok = await this.onChannelCreated(m.data.channel_id)
    },
    direct_added: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {
        await this.client.post('/posts', {
            channel_id: m.broadcast.channel_id,
            message: 'This is a bot. You will not get a reply',
        });
    },
    user_updated: async function (
        this: Main,
        m: MattermostMessage,
    ): Promise<void> {
        const user = this.mattermostUserStore.get(m.data.user.id);
        if (user !== undefined) {
            await this.mattermostUserStore.updateUser(m.data.user, user);
        }
    },
};
