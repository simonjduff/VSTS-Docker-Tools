FROM ubuntu:20.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu66 \
        libunwind8 \
        netcat \
        libssl1.0 \
        build-essential \
        openssh-client \
        firefox \
        python3-pip \
        zip unzip \
        software-properties-common \
        iptables

RUN curl -l https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && add-apt-repository universe \
    && apt-get update \
    && apt-get install powershell

RUN python3 -m pip install setuptools --upgrade \
    && python3 -m pip install ansible --upgrade

RUN apt-get update \
 && curl -sL https://git.io/n-install | bash -s -- -ny - \
 && ~/n/bin/n lts \
 && npm install -g gulp n \
 && rm -rf ~/n

RUN curl -sL https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz \
    | tar -xz \
    && mv geckodriver /usr/local/bin

RUN curl -sL https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.3-1_amd64.deb -o containerd.deb \
    && dpkg -i containerd.deb \
    && curl -sL https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.3~3-0~ubuntu-focal_amd64.deb -o docker-cli.deb \
    && dpkg -i docker-cli.deb \
    && curl -sL https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.3~3-0~ubuntu-focal_amd64.deb -o docker-ce.deb \
    && dpkg -i docker-ce.deb

WORKDIR /azp

COPY ./entrypoint.sh .
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]