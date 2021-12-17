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

WORKDIR /root/source
RUN curl -o xcoin https://download.bitcoinabc.org/0.18.3/linux/bitcoin-abc-0.18.3-x86_64-linux-gnu.tar.gz
RUN tar xzf xcoin
RUN cp /root/source/bitcoin-abc-0.18.3/bin/* /usr/local/bin

# logrotate
ADD logrotate /etc/logrotate.d/xcoind

# scripts
WORKDIR /root/scripts
ADD make_conf.sh .
ADD make_cron.sh .
ADD opsgenie.sh .

# services
RUN mkdir -p /etc/service/xcoind
ADD run.sh /etc/service/xcoind/run
RUN chmod +x /etc/service/xcoind/run

# zcash default data dir
RUN mkdir -p ${XCOIN_VOLUME}

# reset WORKDIR
WORKDIR /root

VOLUME ${XCOIN_VOLUME}

# rpc port
EXPOSE 8332
# p2p port
EXPOSE 8333	
# zmq port
EXPOSE 8331

# port conflict
# rpc port
EXPOSE 28332
# p2p port
EXPOSE 28333	
# zmq port
EXPOSE 28331

#rpc port
EXPOSE 18332
#zmq port
EXPOSE 18331
#zmq port
EXPOSE 18333

# port conflict
#rpc port
EXPOSE 38332
#zmq port
EXPOSE 38331
#zmq port
EXPOSE 38333