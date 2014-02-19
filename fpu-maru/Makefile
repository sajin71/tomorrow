TARGET = finvtable fsqrttable finv.o fsqrt.o check_func

all: $(TARGET)

finvtable: finvtable.c
	gcc -O3 -Wall finvtable.c -o finvtable

fsqrttable: fsqrttable.c
	gcc -O3 -Wall fsqrttable.c -o fsqrttable -lm

finv.o : finv.c
	gcc -O3 -Wall finv.c -c

fsqrt.o : fsqrt.c
	gcc -O3 -Wall fsqrt.c -c

check_func : check_func.c finv.o fsqrt.o
	gcc -O3 -Wall -o check_func check_func.c finv.o fsqrt.o -lm

clean:
	rm -f $(TARGET)
