FROM java:openjdk-8-jdk

MAINTAINER Valentin Zberea valentin.zberea@gmail.com

RUN groupadd -g 999 teamcity \
      && useradd -u 999 -g teamcity -m teamcity \
      && mkdir -p /opt/TeamCity && chown teamcity:teamcity /opt/TeamCity
USER teamcity
COPY runAgent /opt/TeamCity/
VOLUME ["/home/teamcity"]
CMD ["/opt/TeamCity/runAgent"]

USER root

RUN apt-get update \
  && apt-get install -y rsync bzip2 build-essential \
  zip nodejs apt-transport-https \
  && curl -sL https://deb.nodesource.com/setup | bash - \
  && apt-get update \
  && apt-get install -y nodejs \
  && npm install -g npm@next \
  && npm install -g bower \
  && npm install -g npm-cache
  && curl -sSL https://get.docker.com/ | sh \
  && apt-get -y autoremove && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER teamcity
