#!/bin/sh

wc -c < $1 | ~/cpuex/git/tomorrow/core/transmission/put_header
cat $1 > /dev/ttyUSB0
