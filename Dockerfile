FROM java:openjdk-8-jdk

MAINTAINER Valentin Zberea valentin.zberea@gmail.com

ADD setup-agent.sh /setup-agent.sh

RUN apt-get update \
  && apt-get install -y rsync bzip2 build-essential sudo \
  zip nodejs apt-transport-https \
  && curl -sL https://deb.nodesource.com/setup | bash - \
  && apt-get update \
  && apt-get install -y python-pip python-dev build-essential \
  && pip install ansible \
  && apt-get install -y nodejs \
  && npm install -g npm@next \
  && npm install -g bower \
  && npm install -g npm-cache \
  && curl -sSL https://get.docker.com/ | sh \
  && apt-get -y autoremove && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9090
CMD sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER AGENT_NAME=Default bash /setup-agent.sh run"
