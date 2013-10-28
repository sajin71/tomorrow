#include <stdio.h>
#include <string>

#include "MIPSinst.h"
#include "x86emit.h"

void procInst(FILE *ofp, inst_t inst) {
	
	CMIPSInstruction mips(inst);
	
	fputs(mips.disasm().c_str(), ofp);
	fputs("\n\n", ofp);
}

int main(int argc, char *argv[]) {
	
	FILE *ifp = stdin;
	if ( argc >= 2 ) {
		ifp = fopen(argv[1], "rb");
		if ( !ifp ) {
			fputs("input file cannot open.", stderr);
			return 1;
		}
	}
	
	FILE *ofp = stdout;
	if ( argc >= 3 ) {
		ifp = fopen(argv[2], "w");
		if ( !ofp ) {
			fputs("output file cannot open.", stderr);
			return 1;
		}
	}
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	int cnt = 0;
	while ( fread(&buf, sizeof(inst_t), 1, ifp) ==1 ) {
		
		inst_t instLE = buf.b[0] << 24 |
		              buf.b[1] << 16 |
		              buf.b[2] << 8  |
		              buf.b[3] << 0;
		fprintf(ofp, "# [%08X] 0x%08x\n", cnt*4, instLE);
		procInst(ofp, instLE);
		
		cnt++;
	}
	
	if ( ifp != stdin ) {
		fclose(ifp);
	}
	if ( ofp != stdout ) {
		fclose(ofp);
	}
	
	return 0;
}
