#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string>
#include <sys/mman.h> 

#include "MIPSinst.h"
#include "x86emit.h"

typedef uint32_t DWORD;

DWORD regs[32] = {0};
unsigned char *insts;
DWORD mem_offset;
DWORD *pos;

const char *print_int_format = "%d";

void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	if ( mips.isUnknown() ) {
		dprintf("Unknown Instruction 0x%08X\n", inst);
		throw std::string("Unknown Opcode/funct");
		dest->Emit(0xCC);
	} else {
		mips.tox86(dest);
	}
	
}

int main(void) {

	FILE *ifp = stdin;//fopen("/dev/stdin", "rb");
	
	CAsm86Dest dest;
	dest.halt = 0xC3; //RET
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	while ( fread(&buf, sizeof(inst_t), 1, ifp) ==1 ) {
		
		inst_t instLE = buf.b[0] << 24 |
		              buf.b[1] << 16 |
		              buf.b[2] << 8  |
		              buf.b[3] << 0;
		procInst(&dest, instLE);

	}
	
	
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
	
	
	
	insts = (unsigned char*)mmap(NULL, sizeof(unsigned char)*(dest.code.size()+100), PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	std::copy(dest.code.begin(), dest.code.end(), insts);
	
	DWORD *mem = (DWORD*)malloc( sizeof(DWORD) * 0x100000 );
	mem_offset = ((DWORD)mem) - 0x80000000;
	
	DWORD *pos_raw = (DWORD*)malloc( sizeof(DWORD) * (dest.pos.size()+10) );
	pos = pos_raw + 2;
	pos[-1] = (unsigned long)insts;
	//pos[-2]
	
	for ( unsigned int i=0; i< dest.pos.size(); i++ ) {
		pos[i] = dest.pos[i];
	}
	
	
//	__asm__("int $3");
	
	__asm__ ( 
	"leal regs, %%ecx \n"
	"movl mem_offset,  %%esi \n"
	"movl pos,  %%edi \n"
	"leal my_print_int, %%eax \n"
	"movl %%eax, -8(%%edi) \n"
	"call *-4(%%edi) \n"
	"jmp my_asm_end \n"
	
"my_print_int: \n"
	"pushl %%ecx \n"
	"pushl %%edx \n"
	"pushl %%eax \n"
	"pushl print_int_format \n"
	"call  printf \n"
	"addl  $8, %%esp \n"
	"popl  %%edx \n"
	"popl  %%ecx \n"
	"ret \n"
	
"my_asm_end: \n"
	"nop"
	
	
	:
	:
	: "%eax", "%ebx", "%ecx", "%edx", "%esi", "%edi", "cc"
	);

	return 0;
}
