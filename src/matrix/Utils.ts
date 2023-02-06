import Main from '../Main';
import * as sdk from 'matrix-js-sdk';
import * as log4js from 'log4js'
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

    const allMatrixUsers = Object.keys(
        (await main.botClient.getJoinedRoomMembers(roomid)).joined,
    );
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
): sdk.MatrixClient {
    const client: sdk.MatrixClient = sdk.createClient({
        accessToken: registration.as_token,
        baseUrl: config().homeserver.url,
        userId,
        queryParams: {
            user_id: userId,
            access_token: registration.as_token,
        },
        scheduler: new (sdk as any).MatrixScheduler(),
        localTimeoutMs: 1000 * 60 * 2,
    })
    return client
    
    }


export async function registerAppService(client: sdk.MatrixClient, username: string, logger: log4js.Logger): Promise<string> {
    try {
        await client.registerRequest({
            username: username,
            auth:{
            type: 'm.login.application_service',
            }
        });
    } catch (e) {
        if (e.errcode !== 'M_USER_IN_USE') {
            const token=client.getAccessToken()
            logger.error(
                `Register application service as user: ${username} failed. Token: ${token}`,
            );
            throw e;
        } else {
            logger.debug(
                'Register Application Service as %s return message: %s',
                username,
                e.errcode || '',
            );
            return e.errcode
        }
    }
    return 'OK'
}


export async function loginAppService(client: sdk.MatrixClient,username:string): Promise<any> {

    return await client.login("m.login.application_service",
    {
        "identifier": {
            "type": "m.id.user",
            "user": username
          }

    })

}    


export async function joinMatrixRoom(
    client: sdk.MatrixClient,
    roomId: string,
): Promise<void> {
    try {
        await client.invite(roomId, client.getUserId() || '');
    } catch (e) {
        if (
            !(
                e.data.errcode === 'M_FORBIDDEN' &&
                e.data.error.endsWith('is already in the room.')
            )
        ) {
            throw e;
        }
    }
    await client.joinRoom(roomId);
}
