import * as log4js from 'log4js';
import Channel from '../Channel';
import { User } from '../entities/User';
import { Post } from '../entities/Post';
import { Mapping } from '../entities/Mapping';
import { ClientError } from '../mattermost/Client';
import {
    joinMattermostChannel,
    leaveMattermostChannel,
} from '../mattermost/Utils';
import { handlePostError, none } from '../utils/Functions';
import { matrixToMattermost } from '../utils/Formatting';
import { MatrixEvent } from '../Interfaces';
import * as FormData from 'form-data';
import { getLogger } from '../Logging';
import main from '../Main'
import { config } from '../Config';


const myLogger: log4js.Logger = getLogger('MatrixHandler');

interface Metadata {
    edits?: string;
    root_id?: string;
}
async function uploadFile(
    this: Channel,
    user: User,
    event: MatrixEvent,
    metadata: Metadata,
) {
    const main = this.main;
    const client = main.botClient;
    const mxc: string = event.content.url;
    let parts = mxc.split('/');

    /*
    const body = await fetch(
        `${this.main.botClient.getBaseUrl()}/_matrix/media/r0/download/${mxc.slice(
            6,
        )}`,
    );
    */

    const body = await client.download(parts[2], parts[3], event.content.body);

    if (!body) {
        throw new Error(`Downloaded empty file: ${mxc}`);
    }

    const form = new FormData();
    form.append('files', body, {
        filename: event.content.body,
        contentType: event.content.info?.mimetype,
    });
    form.append('channel_id', this.mattermostChannel);

    const fileInfos = await user.client.post('/files', form);
    const fileid = fileInfos.file_infos[0].id;
    const post = await user.client.post('/posts', {
        channel_id: this.mattermostChannel,
        message: event.content.body,
        root_id: metadata.root_id,
        file_ids: [fileid],
    });
    await Post.create({
        postid: post.id,
        eventid: event.event_id,
        rootid: metadata.root_id || post.id,
    }).save();
}

const MatrixMessageHandlers = {
    'm.text': async function (
        this: Channel,
        user: User,
        event: MatrixEvent,
        metadata: Metadata,
    ) {
        if (metadata.edits) {
            try {
                await user.client.put(`/posts/${metadata.edits}/patch`, {
                    message: await matrixToMattermost(
                        event.content['m.new_content'],
                    ),
                });
            } catch (e) {
                await handlePostError(e, metadata.edits);
            }
            return;
        }
        const post = await user.client.post('/posts', {
            channel_id: this.mattermostChannel,
            message: await matrixToMattermost(event.content),
            root_id: metadata.root_id,
        });
        await Post.create({
            postid: post.id,
            eventid: event.event_id,
            rootid: metadata.root_id || post.id,
        }).save();
    },
    'm.emote': async function (
        this: Channel,
        user: User,
        event: MatrixEvent,
        metadata: Metadata,
    ) {
        if (metadata.edits) {
            const content = await matrixToMattermost(
                event.content['m.new_content'],
            );
            try {
                await user.client.put(`/posts/${metadata.edits}/patch`, {
                    message: `*${content}*`,
                    props: {
                        message: content,
                    },
                });
            } catch (e) {
                await handlePostError(e, metadata.edits);
            }

            return;
        }
        const content = await matrixToMattermost(event.content);
        await user.client.post('/commands/execute', {
            channel_id: this.mattermostChannel,
            team_id: await this.getTeam(),
            command: `/me ${content}`,
            root_id: metadata.root_id,
        });
        const posts = await user.client.get(
            `/channels/${this.mattermostChannel}/posts`,
        );
        for (const postid of posts.order) {
            const post = posts.posts[postid];
            if (post.type === 'me' && post.props.message === content) {
                await Post.create({
                    postid: postid,
                    eventid: event.event_id,
                    rootid: metadata.root_id || post.id,
                }).save();
                return;
            }
        }
        myLogger.info(`Cannot find post for ${content}`);
    },
    'm.file': uploadFile,
    'm.image': uploadFile,
    'm.audio': uploadFile,
    'm.video': uploadFile,
};

const MatrixMembershipHandler = {
    invite: none,
    knock: none,
    join: async function (this: Channel, userid: string): Promise<void> {
        if (this.main.skipMatrixUser(userid)) {
            return;
        }

        const channel = await this.main.client.get(
            `/channels/${this.mattermostChannel}`,
        );
        if (channel.type != 'G') {
            const user = await this.main.matrixUserStore.getOrCreate(
                userid,
                true,
            );
            await joinMattermostChannel(this, user);
        }
    },
    leave: async function (this: Channel, userid: string) {
        const user = await this.main.matrixUserStore.get(userid);
        if (user === undefined) {
            myLogger.info(`Found untracked matrix user ${userid}`);
            return;
        }
        const channel = await this.main.client.get(
            `/channels/${this.mattermostChannel}`,
        );
        if (channel.type != 'G') {
            await leaveMattermostChannel(
                this.main.client,
                this.mattermostChannel,
                user.mattermost_userid,
            );

            // Check if we have left all channels in the team. If so, leave the
            // team. This is useful because this is the only way to leave Town
            // Square.
            const team = await this.getTeam();
            const channels = this.main.channelsByTeam.get(team) as Channel[];

            const joined = await Promise.all(
                channels.map(async channel => {
                    const members = await this.main.botClient.getRoomMembers(
                        channel.matrixRoom,
                    );
                    return Object.keys(members.joined).includes(
                        user.matrix_userid,
                    );
                }),
            );

            if (!joined.some(x => x)) {
                await user.client.delete(
                    `/teams/${team}/members/${user.mattermost_userid}`,
                );
            }
        }
    },
    ban: async function (this: Channel, userid: string): Promise<void> {
        await MatrixMembershipHandler.leave.bind(this)(userid);
    },
};

const MatrixHandlers = {
    'm.room.message': async function (
        this: Channel,
        event: MatrixEvent,
    ): Promise<any> {
        const content = event.content;
        const user = await this.main.matrixUserStore.get(event.sender);
        if (user === undefined) {
            myLogger.info(
                `Received message from untracked matrix user ${event.sender}`,
            );
            return undefined;
        }

        const relatesTo = event.content['m.relates_to'];
        const metadata: Metadata = {};
        if (relatesTo !== undefined) {
            if (relatesTo.rel_type === 'm.replace') {
                const post = await Post.findOne({
                    //eventid: relatesTo.event_id,
                    where: { eventid: relatesTo.event_id },
                });
                if (post !== undefined) {
                    metadata.edits = post?.postid;
                }
            } else if (relatesTo['m.in_reply_to'] !== undefined) {
                const post = await Post.findOne({
                    //eventid: relatesTo['m.in_reply_to'].event_id,
                    where: { eventid: relatesTo['m.in_reply_to'].event_id },
                });
                if (post !== null) {
                    try {
                        const props = await user.client.get(
                            `/posts/${post.postid}`,
                        );
                        metadata.root_id = props.root_id || post?.postid;
                    } catch (e) {
                        if (post?.postid != null)
                            await handlePostError(e, post.postid);
                        else {
                            throw e;
                        }
                    }
                }
            }
        }
        let msgType: string = content.msgtype || 'not found';
        let handler = MatrixMessageHandlers[msgType];
        if (handler === undefined) {
            handler = MatrixMessageHandlers['m.text'];
        }
        return await handler.bind(this)(user, event, metadata);
    },
    'm.room.member': async function (
        this: Channel,
        event: MatrixEvent,
    ): Promise<void> {
       
        const findMapping = await Mapping.findOne(
            { "where": { matrix_room_id: event.room_id } }
        )
        if(findMapping) {
            const joined=await this.main.botClient.getJoinedMembers(event.room_id)
            myLogger.info("Mapping exist to room %s. Must fix membership in room for %s",
            event.room_id,event.state_key
            )
        }
        const membership: string = event.content.membership || 'not found';
        const handler = MatrixMembershipHandler[membership];
        if (handler === undefined) {
            myLogger.warn(
                `Invalid membership state: ${event.content.membership}`,
            );
            return;
        }
        await handler.bind(this)(event.state_key);
    },
    'm.room.redaction': async function (
        this: Channel,
        event: MatrixEvent,
    ): Promise<void> {
        const botid = this.main.botClient.getUserId();
        // Matrix loop detection doesn't catch redactions.
        if (event.sender === botid) {
            return;
        }
        const r: any = event['redacts'];
        const redacts: string = r || '';
        const post = await Post.findOne({
            //eventid: event.redacts as string,
            where: { eventid: redacts },
        });
        if (post === null) {
            return;
        }

        // Delete in database before sending the query, so that the
        // Mattermost event doesn't get processed.
        await Post.removeAll(post.postid);

        // The post might have been deleted already, either due to both
        // sides deleting simultaneously, or the message being deleted
        // while the bridge is down.
        try {
            await this.main.client.delete(`/posts/${post.postid}`);
        } catch (e) {
            if (
                !(
                    e instanceof ClientError &&
                    e.m.status_code === 403 &&
                    e.m.id === 'api.context.permissions.app_error'
                )
            ) {
                throw e;
            }
        }
    },

};

const roomInvitedMembers = new Map<string, Map<string, string>>()


export const MatrixUnbridgedHandlers = {
    'm.room.member': async function (
        this: main,
        event: MatrixEvent,
    ): Promise<void> {
        const room_id = event.room_id
        const displayName: string = event.content?.displayname || ''
        const botDisplayName = config().matrix_bot?.display_name

        let roomMembers = roomInvitedMembers.get(event.room_id)
        if (roomMembers === undefined) {
            roomMembers = new Map<string, string>()
            roomInvitedMembers.set(room_id, roomMembers)
        }

        if (botDisplayName === displayName) {
            const info = await this.botClient.joinRoom(room_id)
            myLogger.debug("Found bot client %s invite for room %s. Info=%s", botDisplayName, room_id, info)
            //roomMembers.push(config().matrix_bot.username)
            roomMembers.set(config().matrix_bot.username, event.state_key)

        } else {
            if (event.state_key) {
                roomMembers.set(event.state_key, displayName)
            }
        }
    },
    'm.room.message': async function (
        this: main,
        event: MatrixEvent,
    ): Promise<void> {
        const botUsername = config().matrix_bot?.username
        let roomMembers = roomInvitedMembers.get(event.room_id)
        const mmUsers: string[] = []
        let localMembers:number=0
        if (roomMembers) {
            for (let member of roomMembers.keys()) {
                if (member == botUsername) {
                    mmUsers.push(config().mattermost_bot_userid)
                } else {
                    const mmUser = await User.findOne(
                        { "where": { "matrix_userid": member, "is_matrix_user": false } }
                    )
                    if (mmUser) {
                        mmUsers.push(mmUser.mattermost_userid)
                    } else {
                        localMembers++;
                    }
                }
            }

            const user = await this.matrixUserStore.get(event.sender);

            mmUsers.push(user.mattermost_userid)
            if(mmUsers.length <3 || mmUsers.length >8) {
                const message=`No mapping to Mattermost channel done. No remote users invited or to many users invited. Invited remote users=${mmUsers.length-2}.`
                await this.botClient.sendMessage(event.room_id, "m.room.message",
                    {
                        msgtype: "m.text",
                        body: message
                    }
                )
                await this.botClient.leave(event.room_id)
                return
            }
            const channel = await user.client.post('/channels/group', mmUsers)
            const findMapping = await Mapping.findOne(
                { "where": { "mattermost_channel_id": channel.id } }
            )
            const roomExists: boolean = findMapping ? true : false
            myLogger.info("New direct message channel %s. Mapped to matrix room [%s]. Number of members=%d, Mapping exist=%s",
                channel.display_name, event.room_id, mmUsers.length, roomExists)

            this.doOneMapping(channel.id, event.room_id)

            const mapping = new Mapping()
            mapping.is_direct = true
            mapping.is_private = true
            mapping.matrix_room_id = event.room_id
            mapping.mattermost_channel_id = channel.id
            await mapping.save()
            roomInvitedMembers.delete(event.room_id)

            try {
                await this.redoMatrixEvent(event)
                if (findMapping) {
                    const message=`Mapping to Mattermost channel ${channel.display_name} no longer valid. Use new direct chat setup.`
                    await this.botClient.sendMessage(findMapping.matrix_room_id, "m.room.message",
                        {
                            msgtype: "m.text",
                            body: message
                        }
                    )
                    await this.botClient.leave(findMapping.matrix_room_id)
                }
            }
            catch (err) {
                myLogger.warn("First message to %s channel %s fails. Error=%s", channel.display_name, err.message)
            }

        } else {
            myLogger.warn("Event %s from unknown room %s", event.type, event.room_id)
        }

    }
}
export default MatrixHandlers;
