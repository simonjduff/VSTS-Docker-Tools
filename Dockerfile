FROM microsoft/vsts-agent:ubuntu-14.04-docker-17.06.0-ce
# Install essential build tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && curl -sL https://git.io/n-install | bash -s -- -ny - \
 && ~/n/bin/n lts \
 && npm install -g gulp n \
 && rm -rf ~/n