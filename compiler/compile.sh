#!/bin/sh


echo "compiling" $1 1>&2
./min-caml `echo $1 | sed -e "s/\.ml//"`

echo "connecting libmincaml.S" 1>&2
./connect_lib.sh `echo $1 | sed -e "s/\.ml/.s/"`

echo "assembling" `echo $1 | sed -e "s/\.ml/.s/"` 1>&2 
../asm/asm `echo $1 | sed -e "s/\.ml/.s/"` `echo $1 | sed -e "s/\.ml//"`

echo "done"



