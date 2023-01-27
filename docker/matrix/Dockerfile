FROM matrixdotorg/synapse:latest

# RUN apk add --no-cache synapse
RUN apt-get update && apt-get install netcat -y
RUN mkdir /data

CMD until nc -z postgres 5432; do sleep 0.5; done; /usr/bin/python3 -m synapse.app.homeserver --config-path=/data/homeserver.yaml
