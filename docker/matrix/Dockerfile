FROM matrixdotorg/synapse:latest

RUN apt-get update && apt-get install netcat -y
RUN mkdir /data
RUN mkdir /var/log/synapse

#CMD until nc -z postgres 5432; do sleep 0.5; done; /usr/bin/python3 -m synapse.app.homeserver --config-path=/data/homeserver.yaml
CMD [ "bash", "-c", "until nc -z postgres 5432; do sleep 0.5; done; /usr/bin/python3 -m synapse.app.homeserver --config-path=/data/homeserver.yaml" ]