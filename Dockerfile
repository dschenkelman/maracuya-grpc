FROM node:8.0.0

RUN apt-get update
RUN apt-get --assume-yes install libev-dev libssl-dev automake python-docutils flex bison pkg-config

COPY ./deps/cert.sh ./deps/cleanup.sh ./deps/download.sh ./deps/build.sh /tmp/
RUN chmod +x /tmp/cert.sh /tmp/cleanup.sh /tmp/download.sh /tmp/build.sh

ENV HITCH_CERT_DIR /etc/ssl/hitch
RUN /tmp/download.sh
RUN /tmp/build.sh
RUN /tmp/cert.sh
RUN /tmp/cleanup.sh

WORKDIR /app

# use /var/lib/hitch as home 
RUN useradd -d /var/lib/hitch -ms /bin/bash hitch

RUN mkdir /app/deps
COPY ./deps/start.sh /app/deps
RUN chmod +x /app/deps/start.sh
RUN chown hitch /app/deps/start.sh

EXPOSE 443

USER hitch

# up to here, we have set up hitch as a TLS terminator inside the docker image
# now we will set up maracuya-grpc as a service
# hitch will proxy to maracuya-grpc
CMD /app/deps/start.sh