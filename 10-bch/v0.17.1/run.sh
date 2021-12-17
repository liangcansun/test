#!/usr/bin/env bash

export LC_ALL=C
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

bash /root/scripts/make_cron.sh > /etc/cron.d/xcoind
# force cron to reload the crontab
touch /etc/cron.d/xcoind

bash /root/scripts/make_conf.sh > ${XCOIN_VOLUME}/bitcoin.conf

# datadir must be set by cmd, not config file
bitcoind -conf="${XCOIN_VOLUME}/bitcoin.conf" -datadir="${XCOIN_VOLUME}"
