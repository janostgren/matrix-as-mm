/*
 * Client for working directly with the Synapse Matrix Server - Admin API
*/

import * as log4js from 'log4js';
import { getLogger } from '../Logging';
import {MatrixClient} from './MatrixClient'

import * as axios from 'axios';
import * as https from 'https';
import * as http from 'http';

const TRACE_ENV_NAME = 'API_TRACE';

export class SynapseAdminClient {
    private client: axios.AxiosInstance;
    constructor(matrixClient:MatrixClient) {
        this.client=matrixClient.getClient()


    }
   
    
}
