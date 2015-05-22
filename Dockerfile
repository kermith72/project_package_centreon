FROM debian:wheezy
MAINTAINER Zeysh, zeysh.zorg@gmail.com

WORKDIR /data
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install curl build-essential cmake librrd-dev libqt4-dev libqt4-sql-mysql libgnutls-dev lsb-release libperl-dev libssh2-1-dev libgcrypt11-dev libcgsi-gsoap-dev zlib1g-dev libssl-dev libxerces-c-dev -y
RUN apt-get clean

CMD ["/data/build.sh"]
