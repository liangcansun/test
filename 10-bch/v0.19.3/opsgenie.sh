#!/usr/bin/env bash

SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

if [ "$OPS_API_KEY|$OPS_ENDPOINT_HOST|$OPS_HEARTBEAT_NAME" = "||" ]; then
    echo "please set OPS_API_KEY, OPS_ENDPOINT_HOST, OPS_HEARTBEAT_NAME."
    exit
fi

# api endpoint
ENDPOINT="https://$OPS_ENDPOINT_HOST/v2/heartbeats/$OPS_HEARTBEAT_NAME/ping"

# RPC CALL
RPC_CMD="bitcoin-cli "
RPCINFO=`$RPC_CMD getnetworkinfo`
#NOERROR=`echo "$RPCINFO" |  grep '"errors" : ""' | wc -l`
#HEIGHT=`echo "$RPCINFO" | grep "blocks" | awk '{print $2}' | awk -F"," '{print $1}'`
CONNS=`echo "$RPCINFO" | grep "connections" | awk '{print $2}' | awk -F"," '{print $1}'`

if [[ $CONNS -ne 0 ]]; then
  # avoid calling opsgenie at the same time
  sleep $(expr $RANDOM \% 30)
  curl --silent --max-time 20 -X "GET" "$ENDPOINT" --header "Authorization: GenieKey $OPS_API_KEY"
else
  echo "connections is 0: $RPCINFO"
fi
