FROM phusion/baseimage:0.10.1
LABEL maintainer="yulin.li@blockin.com"

ENV TERM xterm
ENV XCOIN_VOLUME /root/.bitcoin
# We ignore HOME, SHELL, USER and a bunch of other environment variables on purpose / by baseimage
RUN echo /root > /etc/container_environment/HOME

# Use baseimage-docker's init system. 
# Warning: can not be changed
CMD ["/sbin/my_init"]

WORKDIR /root/source
RUN curl -o xcoin https://download.bitcoinabc.org/0.17.1/linux/bitcoin-abc-0.17.1-x86_64-linux-gnu.tar.gz
RUN tar xzf xcoin
RUN cp /root/source/bitcoin-abc-0.17.1/bin/* /usr/local/bin

# logrotate
ADD logrotate /etc/logrotate.d/xcoind

# scripts
WORKDIR /root/scripts
ADD make_conf.sh .
ADD make_cron.sh .
ADD opsgenie.sh .

# services
RUN mkdir -p /etc/service/xcoind
ADD run_testnet.sh /etc/service/xcoind/run
RUN chmod +x /etc/service/xcoind/run

# zcash default data dir
RUN mkdir -p ${XCOIN_VOLUME}

# reset WORKDIR
WORKDIR /root

VOLUME ${XCOIN_VOLUME}

#rpc port
EXPOSE 18332
#zmq port
EXPOSE 18331
#zmq port
EXPOSE 18333