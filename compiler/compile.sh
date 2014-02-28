#!/bin/sh

echo "connecting globals and runtime" $1 1>&2
cat cpuex/runtime.ml cpuex/globals_test.ml `echo $1` > cpuex/tmp.ml 

echo "compiling" $1 1>&2
./min-caml cpuex/tmp #`echo $1 | sed -e "s/\.ml//"`

echo "connecting libmincaml.S" 1>&2
./connect_lib.sh cpuex/tmp.s #`echo $1 | sed -e "s/\.ml/.s/"`
mv cpuex/tmp.s `echo $1 | sed -e "s/\.ml/.s/"`

echo "assembling" `echo $1 | sed -e "s/\.ml/.s/"` 1>&2 
../asm/asm `echo $1 | sed -e "s/\.ml/.s/"` `echo $1 | sed -e "s/\.ml//"`

echo "done"



