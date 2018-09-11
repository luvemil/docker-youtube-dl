FROM debian:jessie-slim

RUN printf "deb http://httpredir.debian.org/debian jessie-backports main non-free\ndeb-src http://httpredir.debian.org/debian jessie-backports main non-free" > /etc/apt/sources.list.d/backports.list

RUN apt-get -qq update \
 && apt-get -qq install -y --no-install-recommends \
      curl \
      ca-certificates \
      python \
      bzip2 \
      libfontconfig \
 && apt-get -qq clean


RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl

ARG PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"

RUN curl -sL "https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2" | tar -xj -C /usr/local/share  \
 && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/share/phantomjs \
 && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs \
 && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs

RUN chmod a+rx /usr/local/bin/youtube-dl

WORKDIR /data

ENTRYPOINT [ "youtube-dl" ]
