FROM node:latest

EXPOSE 11014

WORKDIR /root/app
RUN curl https://install.meteor.com/ | sh
RUN curl -SLO "https://github.com/lair-framework/lair/releases/download/v2.5.0/lair-v2.5.0-linux-amd64.tar.gz" \
    && tar -zxf lair-v2.5.0-linux-amd64.tar.gz \
    && cd bundle/programs/server \
    && npm i

COPY ./package.json /root/app/bundle/programs/server/package.json

ENV ROOT_URL=http://0.0.0.0
ENV PORT 11014
ENV MONGO_URL=mongodb://lairdb:27017/lair
ENV MONGO_OPLOG_URL=mongodb://lairdb:27017/local

CMD mkdir /scripts
COPY ./docker-entrypoint.sh /scripts/
COPY ./wait.sh /scripts/
COPY ./startup.js /root/app/bundle/programs/server/app/server/
RUN chown 501:501 /root/app/bundle/programs/server/app/server/startup.js
CMD chmod +x /scripts/docker-entrypoint.sh 
RUN chmod +x /scripts/wait.sh



ENTRYPOINT ["/scripts/docker-entrypoint.sh"]