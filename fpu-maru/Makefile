TARGET = finvtable fsqrttable

all: $(TARGET)

finvtable: finvtable.c
	gcc -O2 -Wall finvtable.c -o finvtable

fsqrttable: fsqrttable.c
	gcc -O2 -Wall fsqrttable.c -o fsqrttable -lm

clean:
	rm -f $(TARGET)
