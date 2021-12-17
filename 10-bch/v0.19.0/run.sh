#!/usr/bin/env bash

export LC_ALL=C
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

# datadir must be set by cmd, not config file
bitcoind -conf="${XCOIN_VOLUME}/bitcoin.conf" -datadir="${XCOIN_VOLUME}"