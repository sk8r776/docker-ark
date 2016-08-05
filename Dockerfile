FROM ubuntu:latest

MAINTAINER Sk8r776

# Starting steam with validate is slow, lets make it an option
ENV CHECKFILES "false"
# Variable to enable RCON, enabled by default
ENV RCON "true"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install lib32gcc1 wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && mkdir -p /data/containerdata/ark1/backup \
    && useradd -d /data/ark -s /bin/bash --uid 1000 ark \
    && chown -R ark: /data/containerdata/ark1

EXPOSE 27015/udp 7778/udp
EXPOSE 32330/tcp

ADD /data/containerdata/ark1/ark.sh /usr/local/bin/ark

USER ark
VOLUME /data/containerdata/ark1
WORKDIR /data/containerdata/ark1
CMD ["ark"]