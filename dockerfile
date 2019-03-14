FROM microsoft/vsts-agent:ubuntu-14.04-docker-18.06.1-ce
# Install essential build tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential openssh-client firefox ansible \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && curl -sL https://git.io/n-install | bash -s -- -ny - \
 && ~/n/bin/n lts \
 && npm install -g gulp n \
 && rm -rf ~/n

RUN curl -sL https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz \
    | tar -xz \
    && mv geckodriver /usr/local/bin
