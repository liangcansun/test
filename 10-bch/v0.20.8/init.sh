#!/usr/bin/env bash

export LC_ALL=C
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

bash /root/scripts/make_cron.sh > /etc/cron.d/xcoind
# force cron to reload the crontab
touch /etc/cron.d/xcoind