#!/bin/sh


cd test
for var in `ls -1 *.ml`
do
    echo "compiling" $var 1>&2
    .././min-caml `echo $var | sed -e "s/\.ml//"`
done
echo "done generating assembly" 1>&2
echo "assembling" 1>&2
for var in `ls -1 *.s`
do 
    echo "connecting library" $var 1>&2
    cd ../
    ./connect_lib.sh test/$var
    cd test
    echo "assembling" $var 1>&2
    ../../asm/./asm $var `echo $var | sed -e "s/\.s//"`
done
echo "done assembling test" 1>&2

for var in `ls -1 *.ml`
do 
    echo "testing " $var 1>&2
    echo $var >> ../simulation_log.out
    ../../convx86/./testsimu `echo $var | sed -e "s/\.ml//"`>> ../simulation_log.out
    echo "" >> ../simulation_log.out

    echo "ocaml " $var 1>&2
    echo $var >> ../ocaml_log.out
    ocaml $var >> ../ocaml_log.out
    echo "" >> ../ocaml_log.out
done
echo "done generating log files" 1>&2



cd ../
cd shootout
for var in `ls -1 *.ml`
do
    echo "compiling" $var 1>&2
    .././min-caml `echo $var | sed -e "s/\.ml//"`
done
echo "done generating assembly" 1>&2
echo "assembling" 1>&2

for var in `ls -1 *.s`
do 
    echo "connecting library" $var 1>&2
    cd ../
    ./connect_lib.sh test/$var
    cd shootout 

    echo "assembling" $var 1>&2
    ../../asm/./asm $var `echo $var | sed -e "s/\.s//"`
done
echo "done assembling shootout" 1>&2

for var in `ls -1 *.ml`
do 
    echo "testing " $var 1>&2
    echo $var >> ../simulation_log.out
    ../../convx86/./testsimu `echo $var | sed -e "s/\.ml//"`>> ../simulation_log.out
    echo "" >> ../simulation_log.out
    echo "ocaml " $var 1>&2
    echo $var >>  ../ocaml_log.out
    ocaml $var >> ../ocaml_log.out
    echo "" >> ../ocaml_log.out
done
echo "done generating log files" 1>&2
