import * as log4js from 'log4js';
import { startBridge, test, main } from './utils/Bridge';
import { config } from '../Config';
import { getLogger } from '../Logging';

const myLogger: log4js.Logger = getLogger('tests.06-reload');

test('Start bridge', async t => {
    await startBridge();
    t.end();
});

test('reload log level', async t => {
    // A shallow copy is fine because we are editing a top level property.
    const newConfig = Object.assign({}, config());
    const oldLevel = newConfig.logging;
    newConfig.logging = 'warn';
    await main().updateConfig(newConfig);
    myLogger.level = 'warn';

    t.equal(myLogger.level.toString().toLowerCase(), newConfig.logging);

    newConfig.logging = oldLevel;
    await main().updateConfig(newConfig);

    t.end();
});

test('fail when changin non-reloadable config', async t => {
    // A shallow copy is fine because we are editing a top level property.
    const newConfig = Object.assign({}, config());
    const oldConfig = config();

    newConfig.mattermost_url = 'http://new.url';
    await main()
        .updateConfig(newConfig)
        .then(
            () => t.fail('Hot reloaded when non-reloadable key changed'),
            e =>
                t.equals(
                    e.message,
                    'Cannot hot reload config mattermost_url',
                    'Do not hot reload config mattermost_url ',
                ),
        );

    t.equals(config(), oldConfig, 'Do not change config on failed hot reload');
    t.end();
});

test('Kill bridge', async t => {
    await main().killBridge(0);
    t.end();
});
