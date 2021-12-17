FROM phusion/baseimage:0.10.2
LABEL maintainer="yulin.li@blockin.com"

ENV TERM xterm
ENV XCOIN_VOLUME /root/.bitcoin
ENV KILL_PROCESS_TIMEOUT 60
ENV KILL_ALL_PROCESSES_TIMEOUT 60
# We ignore HOME, SHELL, USER and a bunch of other environment variables on purpose / by baseimage
RUN echo /root > /etc/container_environment/HOME

# Use baseimage-docker's init system. 
# Warning: can not be changed
CMD ["/sbin/my_init"]

RUN install_clean \
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
    git \
    wget

# build bch-abc
WORKDIR /root/source
RUN wget https://github.com/Bitcoin-ABC/bitcoin-abc/releases/download/v0.21.8/bitcoin-abc-0.21.8-x86_64-linux-gnu.tar.gz

RUN tar -zxvf bitcoin-abc-0.21.8-x86_64-linux-gnu.tar.gz
RUN cp /root/source/bitcoin-abc-0.21.8/bin/* /usr/local/bin

# logrotate
ADD logrotate /etc/logrotate.d/xcoind

# scripts
WORKDIR /root/scripts
ADD make_cron.sh /root/scripts/make_cron.sh
ADD opsgenie.sh  /root/scripts/opsgenie.sh

# init
RUN mkdir -p    /etc/my_init.d
ADD init.sh     /etc/my_init.d/init.sh
RUN chmod +x    /etc/my_init.d/init.sh

# services
RUN mkdir    /etc/service/xcoind
ADD run.sh   /etc/service/xcoind/run
RUN chmod +x /etc/service/xcoind/run

VOLUME ${XCOIN_VOLUME}

# ports: mainnet
EXPOSE 8333
EXPOSE 8332
EXPOSE 8331

# ports: testnet3
EXPOSE 18333
EXPOSE 18332
EXPOSE 18331
