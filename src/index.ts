import * as log4js from 'log4js';
import * as yargs from 'yargs';
import { writeFileSync } from 'fs';
import * as yaml from 'js-yaml';

import { loadYaml, randomString } from './utils/Functions';
import { validate } from './Config';
import { Registration } from './Interfaces';

import Main from './Main';
import log, { getLogger } from './Logging';
console.time('Bridge loaded');
const logConfigFile = `${__dirname}/../config/log4js.json`;
log4js.configure(logConfigFile);

const myLogger: log4js.Logger = getLogger('index.js');

const argv = yargs
    .scriptName('matrix-appservice-mattermost')
    .help('help')
    .alias('h', 'help')
    .option('r', { describe: 'generate registration file' })
    .option('c', { describe: 'configuration file', nargs: 1, demand: true })
    .option('f', {
        describe: 'registration file',
        nargs: 1,
        demand: true,
    }).argv;

if (argv.r === undefined) {
    const main = new Main(loadYaml(argv.c), argv.f);
    log.timeEnd.info('Bridge loaded');
    void main.init();

    process.on('SIGTERM', () => {
        myLogger.info('Received SIGTERM. Shutting down bridge.');
        void main.killBridge(0);
    });
    process.on('SIGINT', () => {
        myLogger.info('Received SIGINT. Shutting down bridge.');
        void main.killBridge(0);
    });
    process.on('SIGHUP', () => {
        myLogger.info('Received SIGHUP. Reloading config.');

        const newConfig = loadYaml(argv.c);
        try {
            validate(newConfig);
        } catch (e) {
            myLogger.error(`Invalid config: ${e}`);
        }
        main.updateConfig(newConfig).catch(e => {
            myLogger.error(e);
        });
    });
} else {
    const config = loadYaml(argv.c);
    validate(config);

    const registration: Registration = {
        id: randomString(64),
        hs_token: randomString(64),
        as_token: randomString(64),
        namespaces: {
            users: [
                {
                    exclusive: true,
                    regex: `@${config.matrix_localpart_prefix}.*:${config.homeserver.server_name}`,
                },
            ],
        },
        url: `${config.appservice.schema}://${config.appservice.hostname}:${config.appservice.port}`,
        sender_localpart: config.matrix_bot.username,
        rate_limited: true,
        protocols: ['mattermost'],
    };

    writeFileSync(argv.f, yaml.dump(registration));

    myLogger.info(`Output registration to: ${argv.f}`);
    process.exit(0);
}
