FROM microsoft/vsts-agent:ubuntu-14.04-docker-17.06.0-ce
RUN apt-get update \
 && apt-get install nodejs-legacy npm -y \
 && npm install -g gulp n \
 && rm -rf ~/n