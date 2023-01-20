FROM matrixdotorg/synapse:latest

# RUN apk add --no-cache synapse
# RUN  apt-get update && apt-get install netcat -y
# RUN mkdir /data

# RUN mkdir /media_store 
#    chown synapse:synapse /media_store && \
#    sed -i "s/handlers: .*/handlers: [console]/;s%/homeserver.log%/dev/null%" \
#        /etc/synapse/my.domain.name.log.config

#EXPOSE 8008

# USER synapse

COPY ./data/homeserver.yaml /data

CMD until nc -z postgres 5432; do sleep 0.5; done; /usr/bin/python3 -m synapse.app.homeserver --config-path=/data/homeserver.yaml
