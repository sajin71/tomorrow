#include <stdio.h>
#include <string>

#include "MIPSinst.h"
#include "x86emit.h"

inst_t instbuf[100000];

void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	
	// ADD esi, 1
	dest->Emit(0x83);
	dest->EmitModRMexr(0, rESI);
	dest->Emit(0x01);
	
	//if ( mips.isUnknown() ) {
	//	dprintf("Unknown Instruction 0x%08X\n", inst);
	//	dest->Emit(0xCC);
	//} else {
		//fputs(mips.disasm().c_str() , stderr);
		//fputs("\n", stderr);
		mips.tox86(dest);
	//}

	
	//throw std::string("Unknown Opcode/funct");
	
}

int main(void) {

	FILE *ifp = stdin;//fopen("/dev/stdin", "rb");
	
	CAsm86Dest dest;
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	printf("\tDWORD blockram[] = {\n");
	
	int instcnt = 0;
	while ( fread(&buf, sizeof(inst_t), 1, ifp) ==1 ) {
		
		inst_t instLE = buf.b[0] << 24 |
		              buf.b[1] << 16 |
		              buf.b[2] << 8  |
		              buf.b[3] << 0;
		
		instbuf[instcnt] = instLE;
		instcnt++;
		
		procInst(&dest, instLE);
		
		printf("0x%08X, ", instLE);
		if ( instcnt%16 == 15 ) { printf("\n"); }
	}
	printf("\n};\n");
	
	
	printf("\n\n");
	printf("\tDWORD off_pos[] = {(DWORD)(softfp+0x20), 0xcccccccc, 0xcccccccc, (DWORD)blockram, sram_offset, 0xcccccccc, \n");
	for ( unsigned int i=0; i< dest.pos.size(); i++ ) {
		printf("0x%02X, ", dest.pos[i]);
		if ( i%16 == 15 ) { printf("\n"); }
	}
	printf("\n};\n");
	printf(
	"\tDWORD *pos = off_pos+6;\n"
"\n"
"__asm {\n"
"\n"
	"\tlea  ecx, regs\n"
	"\tadd  ecx, 128\n"
	"\tmov  edi, pos\n"
"\n"
	"\tlea  eax, main_code\n"
	"\tmov  [edi-4], eax\n"
	"\t\n"
	"\tlea  eax, save_memory\n"
	"\tmov  [edi-16], eax\n"
	"\t\n"
	"\tlea  eax, load_memory\n"
	"\tmov  [edi-20], eax\n"
	"\t\n"
"\n"
"main_code:\n\n"
);
	
	for ( unsigned int i=0; i< dest.jumpto.size(); i++ ) {
		unsigned int by = dest.jumpto[i].first;
		unsigned int to = dest.jumpto[i].second;
		
		if ( to >= dest.pos.size() ) {
			throw std::string("Unknown forward jump");
		}
		
		union {
			inst_t w;
			unsigned char b[4];
		} addr;
		addr.w = dest.pos[to] - by;
		
		dest.code[ by-4 ] = addr.b[0];
		dest.code[ by-3 ] = addr.b[1];
		dest.code[ by-2 ] = addr.b[2];
		dest.code[ by-1 ] = addr.b[3];
	}
	
	
	dest.pos.push_back( dest.code.size() );
	for ( unsigned int i=0; i< dest.pos.size()-1; i++ ) {
		printf("// [%08X] 0x%08x\n", i*4, instbuf[i]);
		CMIPSInstruction mips(instbuf[i]);
		printf("//   %s\n", mips.disasm().c_str() );
		printf("        ");
		
		for ( unsigned int em = dest.pos[i]; em < dest.pos[i+1]; em++ ) {
			printf("_E 0x%02X ", dest.code[em]);
		}
		
		printf("\n");
	}
	
	
	//for ( unsigned int i=0; i< dest.code.size(); i++ ) {
	//	dprintf("0x%02X, ", dest.code[i]);
		//fwrite(&dest.code[i], 1,1, stdout);
	//	if ( i%16 == 15 ) { dprintf("\n"); }
	//}
	printf("\n");
	
	return 0;
}
