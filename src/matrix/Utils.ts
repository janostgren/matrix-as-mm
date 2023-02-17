import Main from '../Main';
import * as mxClient from './MatrixClient';
import * as log4js from 'log4js';
import { Registration } from '../Interfaces';
import { config } from '../Config';

export async function getMatrixUsers(
    main: Main,
    roomid: string,
): Promise<{
    real: Set<string>;
    remote: Set<string>;
}> {
    const realMatrixUsers: Set<string> = new Set();
    const remoteMatrixUsers: Set<string> = new Set();

    /*const allMatrixUsers = Object.keys(
        (await main.botClient.getRoomMembers(roomid)),
    );
    */
    const allMatrixUsers: string[] = [];
    let resp = await main.botClient.getRoomMembers(roomid);
    for (let member of resp.chunk) {
        allMatrixUsers.push(member.user_id);
    }

    for (const matrixUser of allMatrixUsers) {
        if (main.isRemoteUser(matrixUser)) {
            remoteMatrixUsers.add(matrixUser);
        } else {
            realMatrixUsers.add(matrixUser);
        }
    }
    return {
        real: realMatrixUsers,
        remote: remoteMatrixUsers,
    };
}

export function getMatrixClient(
    registration: Registration,
    userId: string,
    apiTrace:boolean=false
): mxClient.MatrixClient {
    const client = new mxClient.MatrixClient({
        userId: userId,
        baseUrl: config().homeserver.url,
        accessToken: registration.as_token,
        apiTrace:apiTrace
    });
    return client;
}

export async function registerAppService(
    client: mxClient.MatrixClient,
    username: string,
    logger: log4js.Logger,
): Promise<string> {
    try {
        let ret = await client.registerService(username);
        logger.debug(
            'Register app service with username:%s userId:%s returns %s',
            username,
            client.getUserId(),
            ret,
        );
        return ret;
    } catch (e) {
        throw e;
    }
}

export async function loginAppService(
    client: mxClient.MatrixClient,
    username: string,
): Promise<any> {
    const info =await client.loginAppService(username);
    client.setAccessToken(info.access_token)
    return info
}

export async function joinMatrixRoom(
    client: mxClient.MatrixClient,
    roomId: string,
): Promise<void> {
    const reason = 'Needed for app service';
    try {
        const userId = client.getUserId();
        const resp = await client.getJoinedRooms();
        const joinedRooms: string[] = resp.joined_rooms;
        const foundRoom = joinedRooms.find(room => room === roomId);
        if (!foundRoom) {
            await client.invite(roomId, userId, reason);
        }
    } catch (e) {
        if (
            !(
                e.errcode === 'M_FORBIDDEN' &&
                e.error.endsWith('is already in the room.')
            )
        ) {
            throw e.message;
        }
    }
    await client.joinRoom(roomId, reason);
}
