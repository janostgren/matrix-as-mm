import Main from '../Main';
import * as sdk from 'matrix-js-sdk';
import { MatrixClient, Registration } from '../Interfaces';
import { config } from '../Config';
import * as log4js from 'log4js'
import { Logger } from 'ajv';

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
): MatrixClient {
    let sdkClient=sdk.createClient({
        accessToken: registration.as_token,
        baseUrl: config().homeserver.url,
        userId,
        queryParams: {
            user_id: userId,
            access_token: registration.as_token,
        },
        scheduler: new (sdk as any).MatrixScheduler(),
        localTimeoutMs: 1000 * 60 * 2,
    });
    return sdkClient
}

export async function registerAppService(client:MatrixClient,username:string, logger:log4js.Logger):Promise<string>{
    try {
        await client.registerRequest({
            username: username,
            type: 'm.login.application_service',
        });
    } catch (e) {
        if (e.errcode !== 'M_USER_IN_USE') {
            logger.error(
                `Register application service as user: ${username} failed`,
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

export async function joinMatrixRoom(
    botClient: MatrixClient,
    client: MatrixClient,
    roomId: string,
): Promise<void> {
    try {
        await botClient.invite(roomId, client.getUserId());
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
