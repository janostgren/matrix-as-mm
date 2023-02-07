import * as log4js from 'log4js';
import { getLogger } from '../Logging';

import * as axios from 'axios';
import * as https from 'https';
import { TIMEOUT } from 'dns';
import { timeStamp } from 'console';
export interface MatrixClientCreateOpts {
    userId: string;
    baseUrl: string;
    accessToken: string;
}

export interface SendRoomContent {
    body: string;
    msgtype: string;
}

export class MatrixClient {
    private myLogger: log4js.Logger;
    private client: axios.AxiosInstance;
    private userId: string;
    private baseUrl: string;
    private accessToken: string;

    constructor(options: MatrixClientCreateOpts) {
        //super()
        this.myLogger = getLogger('MatrixClient', 'trace');

        this.accessToken = options.accessToken;
        (this.userId = options.userId), (this.baseUrl = options.baseUrl);
        let httpsAgent = new https.Agent({
            keepAlive: true,
        });
        const bearer: string = `Bearer ${options.accessToken}`;
        this.client = axios.default.create({
            baseURL: options.baseUrl,
            httpsAgent: httpsAgent,
            headers: {
                Authorization: bearer,
            },
        });
    }

    public getUserId(): string {
        return this.userId;
    }

    public setUserId(userId: string) {
        this.userId = userId;
    }

    public getAccessToken(): string {
        return this.accessToken;
    }

    public setAccessToken(token: string) {
        this.accessToken = token;
    }

    public getBaseUrl(): string {
        return this.baseUrl;
    }

    public async getWellKnownClient(): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.get(
            '/.well-known/matrix/client',
        );
        return resp.data;
    }

    public async whoAmI(): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.get(
            '_matrix/client/v3/account/whoami',
        );
        return resp.data;
    }

    public async getPublicRooms(limit: number = 100): Promise<any> {
        return this.doRequest({
            url: '_matrix/client/v3/publicRooms',
            params: { limit: limit },
        });
    }

    public async getRoomVisibility(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/r0/directory/list/room/${roomId}`,
        });
    }

    public async getRoomStateAll(roomId: string): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.get(
            `_matrix/client/v3/rooms/${roomId}/state`,
        );
        return resp.data;
    }

    public async getRoomState(roomId: string, state: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/state/${state}`,
        });
    }

    public async sendStateEvent(
        roomId: string,
        eventType: string,
        stateKey: string,
        data?: any,
    ): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.put(
            ` _matrix/client/v3/rooms/${roomId}/state/${eventType}/n${stateKey}`,
            data,
        );
        return resp.data;
    }

    public async getRoomEvent(roomId: string, eventId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/event/${eventId}`,
        });
    }

    public async getRoomAliases(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/aliases`,
        });
    }

    public async getRoomMembers(roomId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/members`,
        });
    }

    public async invite(
        roomId: string,
        userId: string,
        reason: string,
    ): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/rooms/${roomId}/invite`,
            method: 'POST',
            data: {
                user_id: userId,
                reason: reason,
            },
        });
    }

    public async joinRoom(
        roomId: string,
        reason: string = 'joining room',
    ): Promise<any> {
        return await this.doRequest({
            method: 'POST',
            url: `_matrix/client/v3/rooms/${roomId}/join`,
            data: {
                reason: reason,
            },
        });
    }

    public async leave(
        roomId: string,
        reason: string = 'leaving room',
    ): Promise<any> {
        return await this.doRequest({
            method: 'POST',
            url: `_matrix/client/v3/rooms/${roomId}/leave`,
            data: {
                reason: reason,
            },
        });
    }

    public async getJoinedRooms(): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/joined_rooms`,
        });
    }

    public async registerService(userName?: string): Promise<string> {
        let retValue: string = 'OK';
        try {
            const resp: axios.AxiosResponse = await this.client.post(
                '/_matrix/client/r0/register',
                {
                    username: userName,
                    type: 'm.login.application_service',
                },
                {
                    params: { as_token: this.accessToken },
                },
            );
            retValue = resp.statusText;
        } catch (error: any) {
            const me = MatrixClient.getMatrixError(error);
            const code = me.errcode;
            if (code && code === 'M_USER_IN_USE') {
                retValue = code;
            } else {
                throw error;
            }
        }
        return retValue;
    }

    public async loginAppService(userName: string): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.post(
            '/_matrix/client/r0/login',
            {
                username: userName,
                type: 'm.login.application_service',
                identifier: {
                    type: 'm.id.user',
                    user: userName,
                },
            },
        );
        return resp.data;
    }

    public async getProfileInfo(userId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/profile/${userId}`,
        });
    }

    public async getUserDisplayName(userId: string): Promise<any> {
        return await this.doRequest({
            url: `_matrix/client/v3/profile/${userId}/displayname`,
        });
    }

    public async setUserDisplayName(
        userId: string,
        displayName: string,
    ): Promise<any> {
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/profile/${userId}/displayname`,
            data: {
                displayname: displayName,
            },
        });
    }

    public async sendTyping(
        roomId: string,
        userId: string,
        typing: boolean = true,
        timeout: number = 2000,
    ): Promise<any> {
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/rooms/${roomId}/typing/${userId}`,
            data: {
                timeout: timeout,
                typing: typing,
            },
        });
    }

    public async sendMessage(
        roomId: string,
        eventType: string,
        content: SendRoomContent,
    ): Promise<any> {
        let txnId: string = 'm' + Date.now();
        return await this.doRequest({
            method: 'PUT',
            url: `_matrix/client/v3/rooms/${roomId}/send/${eventType}/${txnId}`,
            data: content,
        });
    }

    public async upload(fileName: string, contentType: string): Promise<any> {
        const resp: axios.AxiosResponse = await this.client.post(
            `_matrix/media/v3/upload`,
            undefined,
            {
                headers: {
                    'Content-Type': contentType,
                },
                params: {
                    filename: fileName,
                },
            },
        );
        return resp.data;
    }

    private async doRequest(options: axios.AxiosRequestConfig): Promise<any> {
        let method = options.method || 'GET';
        this.myLogger.trace(
            `${method} ${options.url} active userId=${this.getUserId()}`,
        );
        try {
            let response: axios.AxiosResponse = await this.client.request(
                options,
            );
            return response.data;
        } catch (e: any) {
            const me = MatrixClient.getMatrixError(e);
            if (me) {
                this.myLogger.error(
                    `${method} ${options.url} error: ${me.errcode}:${me.error}`,
                );
            }
            throw me || e;
        }
    }

    public static getMatrixError(error: any): any {
        let me = error?.response?.data || {};
        return me;
    }
}
