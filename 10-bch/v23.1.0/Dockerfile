FROM ubuntu:20.04

ADD sources.list.20.04 /etc/apt/sources.list

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
        && apt upgrade -y \
        && apt install -y --no-install-recommends \
        dialog \
        apt-utils \
        build-essential \
        libtool \
        autotools-dev \
        automake \
        pkg-config \
        libssl-dev \
        libevent-dev \
        bsdmainutils \
        yasm \
        libboost-all-dev \
        libdb++-dev \
        libzmq3-dev \
        curl \
        wget

# build bitcoin-cash-node
        
WORKDIR /root/source
RUN wget --no-check-certificate https://github.com/bitcoin-cash-node/bitcoin-cash-node/releases/download/v23.1.0/bitcoin-cash-node-23.1.0-x86_64-linux-gnu.tar.gz
RUN tar -zxvf bitcoin-cash-node-23.1.0-x86_64-linux-gnu.tar.gz
RUN cp /root/source/bitcoin-cash-node-23.1.0/bin/* /usr/local/bin

WORKDIR /root/.bitcoin
CMD exec bitcoind -printtoconsole -debuglogfile=0 -conf="/root/.bitcoin/bitcoin.conf" -datadir="/root/.bitcoin"

# ports: mainnet
EXPOSE 8333
EXPOSE 8332
EXPOSE 8331

# ports: testnet3
EXPOSE 18333
EXPOSE 18332
EXPOSE 18331
