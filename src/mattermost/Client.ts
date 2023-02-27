// import fetch, { Response } from 'node-fetch';
import * as axios from 'axios';
import * as https from 'https';
import * as http from 'http';
import * as WebSocket from 'ws';
import { EventEmitter } from 'events';
import * as util from 'util';

import * as log4js from 'log4js';
import * as FormData from 'form-data';

//export type Method = "GET" | "POST" | "PUT" | "DELETE";
const TRACE_ENV_NAME = 'API_TRACE';

export class Client {
    private joinTeamPromises: Map<string, Promise<any>>;
    private myLogger: log4js.Logger;
    private client: axios.AxiosInstance;
    readonly logLevel: string = 'debug';

    constructor(
        readonly domain: string,
        readonly userid: string,
        readonly token: string,
    ) {
        this.domain = domain.replace(/\/*$/, '');
        this.joinTeamPromises = new Map();

        let apiTraceEnv = process.env[TRACE_ENV_NAME];
        this.logLevel =
            apiTraceEnv && apiTraceEnv === 'true' ? 'trace' : 'debug';
        this.myLogger = log4js.getLogger('MM Client');
        this.myLogger.level = this.logLevel;

        let httpsAgent = new https.Agent({
            keepAlive: true,
        });
        let httpAgent = new http.Agent({
            keepAlive: true,
        });

        const bearer: string = this.token ? `Bearer ${this.token}` : '';
        this.client = axios.default.create({
            baseURL: this.domain,
            httpsAgent: httpsAgent,
            httpAgent: httpAgent,
            headers: {
                Authorization: bearer,
            },
        });
    }

    private async send_raw(
        method: axios.Method,
        endpoint: string,
        data?: any | FormData,

        raw: boolean = false,
    ): Promise<any> {
        const options: axios.AxiosRequestConfig = {
            method: method,
            url: `/api/v4${endpoint}`,
            data: data,
        };
        if (raw) {
            options.responseType = 'arraybuffer';
        }

        this.myLogger.trace(`${method}  ${endpoint} `);
        try {
            let response: axios.AxiosResponse = await this.client.request(
                options,
            );
            return response.data;
        } catch (error: any) {
            let message: string = error.message;
            let errName = 'ApiError';
            let ae: boolean = axios.isAxiosError(error);
            let errData: any = error.response?.data || {};
            let errObject: ErrorObject = {
                is_oauth: false,
                id: '',
                request_id: '',
                status_code: 0,
            };
            if (ae) {
                if (error.response) {
                    // The request was made and the server responded with a status code
                    // that falls out of the range of 2xx

                    if (error.response.data) {
                        errData = error.response.data;
                        let dm: any = error.response.data.message;
                        message += dm ? '. ' + dm : '';
                        errName = error.response.data.id || errName;
                        errObject.status_code = errData.status_code;
                        (errObject.id = errData.id),
                            (errObject.request_id = errData.request_id);
                    }
                } else if (error.request) {
                }
            } else {
            }

            let clientError = new ClientError(
                message,
                method,
                endpoint,
                errData,
                errObject,
            );
            clientError.name = errName;
            this.myLogger.fatal('%s %s message: %s', method, endpoint, message);
            throw clientError;
        }
    }

    private async send(
        method: axios.Method,
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send_raw(method, endpoint, data, raw);
    }

    public async get(
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send('GET', endpoint, data, raw);
    }
    public async post(
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send('POST', endpoint, data, raw);
    }
    public async put(
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send('PUT', endpoint, data, raw);
    }

    public async patch(
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send('PATCH', endpoint, data, raw);
    }

    public async delete(
        endpoint: string,
        data?: any,
        raw: boolean = false,
    ): Promise<any> {
        return await this.send('DELETE', endpoint, data, raw);
    }

    public websocket(): ClientWebsocket {
        return new ClientWebsocket(this);
    }

    public async joinTeam(userid: string, teamid: string): Promise<any> {
        // Since ids are fixed length, it is okay to just concatenate.
        const key = userid + teamid;
        const sent = this.joinTeamPromises.get(key);
        if (sent !== undefined) {
            return sent;
        }
        const promise = this.post(`/teams/${teamid}/members`, {
            user_id: userid,
            team_id: teamid,
        });
        this.joinTeamPromises.set(key, promise);
        const result = await promise;
        this.joinTeamPromises.delete(key);
        return result;
    }
}

interface PromiseCallbacks {
    resolve;
    reject;
}

export class ClientWebsocket extends EventEmitter {
    private myLogger: log4js.Logger;
    private ws: WebSocket;
    private seq: number;
    private promises: PromiseCallbacks[];
    private isInitialized: boolean;

    constructor(private client: Client) {
        super();
        this.myLogger = log4js.getLogger('Websocket');
        this.myLogger.level = client.logLevel;
        if (this.client.token === null) {
            throw new Error('Cannot open websocket without access token');
        }
        this.isInitialized = false;
        this.seq = 0;
        this.promises = [];
    }
    public initialized(): boolean {
        return this.isInitialized;
    }

    public async open() {
        const parts = this.client.domain.split(':');

        let wsProto = parts[0] === 'http' ? 'ws' : 'wss';
        const wsUrl = `${wsProto}${this.client.domain.slice(
            4,
        )}/api/v4/websocket`;
        const options = {
            followRedirects: true,
            /*
      headers: {
        raworization: "Bearer " + this.client.token,
      },
      */
        };

        this.ws = new WebSocket(wsUrl, [], options);

        this.ws.on('open', async () => {
            try {
                await this.send('authentication_challenge', {
                    token: this.client.token,
                });
                this.isInitialized = true;
            } catch (error) {
                this.myLogger.error('ws open event error %s', error.message);
            }
        });

        this.ws.on('unexpected-response', resp => {
            this.myLogger.error('Unexpected response %s', resp);
        });

        this.ws.on('message', m => {
            const ev = JSON.parse(m);
            this.myLogger.trace(
                'Message: ',
                util.inspect(ev, {
                    showHidden: false,
                    depth: 4,
                    colors: true,
                }),
            );
            if (ev.seq_reply !== undefined) {
                const promise = this.promises[ev.seq_reply];
                if (promise === null) {
                    this.myLogger.warn(
                        `websocket: Received reply with unknown sequence number: ${m}`,
                    );
                }
                if (ev['status'] === 'OK') {
                    promise.resolve(ev.data);
                } else {
                    promise.reject(ev.error);
                }
                delete this.promises[ev.seq_reply];
            } else {
                this.emit('message', ev);
            }
        });
        this.ws.on('close', (code, reason) => this.emit('close', code, reason));
        this.ws.on('error', e => this.emit('error', e));
    }

    public async close(): Promise<void> {
        // If the websocket is already closed, we will not receive a close event.
        if (this.ws.readyState === WebSocket.CLOSED) {
            return;
        }
        this.ws.close();
        await new Promise(resolve => this.ws.once('close', resolve));
    }
    public async send(action: string, data: unknown): Promise<any> {
        this.seq += 1;
        this.ws.send(
            JSON.stringify({
                action: action,
                seq: this.seq,
                data: data,
            }),
        );
        return await new Promise(
            (resolve, reject) =>
                (this.promises[this.seq] = {
                    resolve: resolve,
                    reject: reject,
                }),
        );
    }
}

export class ClientError extends Error {
    constructor(
        message: string,
        public readonly method: axios.Method,
        public readonly endpoint: string,
        public readonly data: any,
        public readonly m: ErrorObject,
    ) {
        super(message);
        this.message += `status_code:${this.m.status_code} method:${method} endpoint:${endpoint}`;
    }
}

export interface ErrorObject {
    id: string;
    status_code: number;
    request_id: string;
    is_oauth: boolean;
}
