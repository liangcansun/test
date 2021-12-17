#!/usr/bin/env bash

export LC_ALL=C
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

tee <<EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
EOF

echo "OPS_API_KEY=$OPS_API_KEY"
echo "OPS_ENDPOINT_HOST=$OPS_ENDPOINT_HOST"
echo "OPS_HEARTBEAT_NAME=$OPS_HEARTBEAT_NAME"

tee <<EOF
# xcoind heart beats
* * * * * root bash /root/scripts/opsgenie.sh > /dev/null 2>&1
EOF
