# Testing

This repository has both unit and integration tests, using [tape](https://github.com/substack/tape) for both of them. It also uses [Prettier](https://prettier.io) to enforce code style and [ESLint](https://eslint.org) for linting.

## Linting

Running

```
$ npm run lint
```

checks the code with `prettier` and `eslint`. We do not permit any ESLint warnings.

To fix errors, we can use Prettier to autoformat the code via

```
$ npm run fmt.
```

One can also run ESLint's autofix with

```
$ npm run fix
```

which will correct some but not all of the eslint warnings.

## Unit tests

Unit tests are placed next to the source files, e.g. the unit tests for `src/utils/Functions.ts` are at `src/utils/Functions.test.ts`. These are run by the subcommand

```
$ npm run test
```

While attempts have been made to make the code more modular, hence more unit-testable, most of the code is not really amenable to unit testing. Instead, most of it is covered under integration tests.

## Integration tests

We use Docker to set up real instances of Mattermost and Synapse for integration tests, with the bridge running on the host so that we can modify the bridge to test different configurations. The tests are present in `src/tests`, while the Docker configuration is in `docker/`.

### Integration tests are run with

```
$ npm run integration
```

which automatically fires up Docker instances for the test, and tears it down at the end of the test. This uses `docker-compose`, and runs `docker-compose` without `sudo` --- one can either use rootless Docker or add the user to the `docker` group. Alternatively one can start the docker instances by hand by setting the `INTEGRATION_MANUAL_DOCKER` environment variable to `true`:

```
$ docker-compose -f docker/docker-compose.yaml up
$ INTEGRATION_MANUAL_DOCKER=true npm run integration
$ docker-compose -f docker/docker-compose.yaml down -v
```
### Important about integration tests 
Integration tests are from original version of the Mattermost to Matrix bridge. They don't work in this release. We will replace them with a new solution.

# Docker containers

The rest of this section documents the docker containers used development environment.

## Postgres

This is a standard postgres image pulled from DockerHub. It has two database, one for mattermost and one for synapse, with the mattermost one being the "default" one.
There is also an additional database used by the bridge for storing some meta-data. Does not need to be postgres in a target environment. Sqlite is supported https://www.sqlite.org/index.html.

The tables are pre-populated with hardcoded values extracted from live instances. This makes it faster to start up and more convenient to write tests with known ids. The dumps are piped through awk to remove redundant lines. The awk script is placed at `docker/postgres/minify-dump.awk`.

## Matrix

This installs synapse from the alpine repositories. It uses `nc` to wait until `postgres` is up before starting synapse, since synapse crashes if the database is inaccessible.
Synapse is the only container which access the bridge through http. It should use the special host called host.docker.internal. See https://docs.docker.com/desktop/networking/

Example of the registration file in docker.

```yaml
id: xfbONb3M-hYO861rkzW7N0xUKm-6MII2M6sj-z8sdc0DaiXV1S25SXdr5ElIvatt
hs_token: 4Z9Nbbv5SJHskTzytN2-hSMubMUCKgybSRrgtmrlkpB-QaUwm-PAdtgnAwlptwPT
as_token: c6QW7JvyncGYcoqwPrsE7fU12cnvFkbkwmCQw_3tYQKCf0bnmzN3nZJHrTYmTUY2
namespaces:
  users:
    - exclusive: true
      regex: '@mm_.*:localhost'
url: http://host.docker.internal:9995
sender_localpart: matterbot
rate_limited: true
protocols:
  - mattermost
```

## Mattermost

This performs a standard Mattermost 7.5.1 install on alpine.

This again uses `nc` to wait until `postgres` is up. While Mattermost has built in support for retrying connecting to the database, it waits for 10 seconds between retries, which is generally too much.

## Element

The container for Element web UI. This container talks to Synapse Matrix Server on the home server port.
Configuration file _element-config.json_ changes.

```json
 "default_server_config": {
    "m.homeserver": {
      "base_url": "http://synapse:8008",
      "server_name": "synapse"
    },
    "m.identity_server": {
      "base_url": "http://localhost:8008"
    }
  }
```

## Mailhog
A simple SNMP server for testing of email. An installation of the MailHog docker container. See https://github.com/mailhog/MailHog
for additional information.


