#!/usr/bin/env bash

export LC_ALL=C
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

tee <<EOF
dbcache=1000
blockmaxsize=1000000
maxuploadtarget=1024
EOF

echo "rpcuser=${XCOIN_RPC_USER}"
echo "rpcpassword=${XCOIN_RPC_PASSWORD}"
echo "rpcthreads=${XCOIN_RPC_THREADS}"
echo "zmqpubhashblock=${XCOIN_ZMQ_PUSH_HASH_BLOCK}"

IFS=';' read -ra ADDR <<< "${XCOIN_RPC_ALLOW_IP}"
for i in "${ADDR[@]}"; do
    echo "rpcallowip=$i"
done

IFS=';' read -ra ADDR <<< "${XCOIN_PEER_NODES}"
for i in "${ADDR[@]}"; do
    echo "addnode=$i"
done

if [ "${XCOIN_REINDEX}" = true ]; then
    echo "reindex=1"
fi

if [ "${XCOIN_TX_INDEX}" = true ]; then
    echo "txindex=1"
fi
