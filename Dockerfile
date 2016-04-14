FROM ubuntu
MAINTAINER Pedro Tacla Yamada <tacla.yamada@gmail.com>

RUN apt-get update
RUN apt-get install -y wget

RUN wget http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list
RUN apt-get update && apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring

RUN apt-get purge -y wget

RUN apt-get update

RUN apt-get install -y gdc dub
RUN apt-get install -y libcurl3-gnutls

ADD . /app/
# Set default WORKDIR
WORKDIR /app

RUN dub build --compiler=gdc
