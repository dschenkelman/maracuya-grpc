FROM node:8.0.0

RUN echo "deb http://httpredir.debian.org/debian/ jessie-backports main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://httpredir.debian.org/debian/ jessie-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get --assume-yes install libev-dev libssl-dev automake python-docutils flex bison pkg-config supervisor

# this is an unsafe configuration but we need this for http2 as openssl supports ALPN
RUN apt-get --assume-yes install -t jessie-backports openssl

# configure supervisord
COPY ./deps/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ./deps/hitch /tmp/
RUN chmod +x /tmp/cleanup.sh /tmp/download.sh /tmp/build.sh

RUN /tmp/download.sh
RUN /tmp/build.sh
RUN /tmp/cleanup.sh

ENV HITCH_CERT_DIR /etc/ssl/hitch
RUN mkdir $HITCH_CERT_DIR
COPY ./deps/certs/localhost.pem $HITCH_CERT_DIR

WORKDIR /app

# use /var/lib/hitch as home 
RUN useradd -d /var/lib/hitch -ms /bin/bash hitch

RUN mkdir /app/hitch
COPY ./deps/hitch/start.sh /app/hitch
RUN chmod +x /app/hitch/start.sh

# up to here, we have set up hitch as a TLS terminator inside the docker image
# now we will set up maracuya-grpc as a service
# hitch will proxy to maracuya-grpc
RUN mkdir /app/maracuya /app/maracuya/bin

ENV MARACUYA_PORT 50001

RUN useradd -ms /bin/bash maracuya

WORKDIR /app/maracuya
COPY package.json package-lock.json /app/maracuya/
RUN npm install --production
COPY ./index.js service.proto /app/maracuya/
COPY ./bin/* /app/maracuya/bin/
COPY ./deps/maracuya-config.json /app/maracuya/bin/

ENV MARACUYA_CONFIG /app/maracuya/bin/maracuya-config.json

WORKDIR /app

# configure hitch port
ARG port=4433
ENV HITCH_PORT $port
EXPOSE $port

# start supervisord
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf -n