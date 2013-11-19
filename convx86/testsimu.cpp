#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#include <string>
#include <sys/mman.h> 

#include "MIPSinst.h"
#include "x86emit.h"

typedef uint32_t DWORD;

DWORD regs[67] = {0,1,2,3,4,5,6,7,8,9,10}; //0...31:fpr  32...63:gpr  64:hi 65:lo 66:cc
unsigned char *insts;
DWORD sram_offset;
DWORD *blockram;
DWORD *pos;

const char *print_int_format = "%d";


union intflt {
	DWORD i;
	float f;
};


typedef DWORD(*ptr_softfp)(intflt, intflt);

#define MY_CDECL __attribute__((cdecl))
#define BREAKPOINT __asm("int 3");

#define SOFTFP_BINOP(name, op) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { intflt ret; ret.f = s.f op t.f; return ret.i; }
#define SOFTFP_UNIOP(name, func) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { intflt ret; ret.f = func(t.f); return ret.i; }
#define SOFTFP_COMP(name, op) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { return (s.f op t.f)?1:0; }


SOFTFP_BINOP(add, +)
SOFTFP_BINOP(sub, -)
SOFTFP_BINOP(mul, *)
SOFTFP_BINOP(div, /)
SOFTFP_UNIOP(sqrt, sqrtf)
SOFTFP_UNIOP(abs, fabs)
DWORD MY_CDECL softfp_mov (intflt t, intflt s) { return t.i; }
SOFTFP_UNIOP(neg, -)
DWORD MY_CDECL softfp_round (intflt t, intflt s) { intflt ret; ret.f = floorf(t.f+0.5f); return ret.i; }
SOFTFP_UNIOP(floor, floorf)
SOFTFP_UNIOP(recip, 1/)

DWORD MY_CDECL softfp_cvt (intflt t, intflt s) { intflt ret; ret.f = (float)s.i; return ret.i; }

DWORD MY_CDECL softfp_un (intflt t, intflt s) { BREAKPOINT return 0; /*TODO*/ }
SOFTFP_COMP(eq, ==)
SOFTFP_COMP(olt, <)

DWORD MY_CDECL softfp_ERR (intflt t, intflt s) { BREAKPOINT return 0; }



void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	if ( mips.isUnknown() ) {
		dprintf("Unknown Instruction 0x%08X\n", inst);
		dest->Emit(0xCC);
	} else {
		mips.tox86(dest);
	}
	
}

int main(void) {

	//DWORD hogera = softfp(1, 2, 3);
	
	FILE *ifp = stdin;//fopen("/dev/stdin", "rb");
	
	CAsm86Dest dest;
	dest.halt = 0xC3; //RET
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	blockram = (DWORD*)malloc( sizeof(DWORD) * 0x10000 );
	int brcnt = 0;
	
	while ( fread(&buf, sizeof(inst_t), 1, ifp) ==1 ) {
		
		inst_t instLE = buf.b[0] << 24 |
		              buf.b[1] << 16 |
		              buf.b[2] << 8  |
		              buf.b[3] << 0;
		procInst(&dest, instLE);
		blockram[brcnt++] = instLE;

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
	
	DWORD *sram = (DWORD*)malloc( sizeof(DWORD) * 0x100000 );
	sram_offset = ((DWORD)sram) - 0x80000000;
	
	DWORD *pos_raw = (DWORD*)malloc( sizeof(DWORD) * (dest.pos.size()+100) );
	pos = pos_raw + 8;
	pos[-1] = (unsigned long)insts;
	pos[-2] = sram_offset;
	pos[-3] = (DWORD)blockram;
	
	ptr_softfp softfp[0x38] = {
		softfp_add, softfp_sub, softfp_mul, softfp_div, softfp_sqrt, softfp_abs, softfp_mov, softfp_neg,
		softfp_ERR, softfp_ERR, softfp_ERR, softfp_ERR, softfp_round,softfp_ERR, softfp_ERR, softfp_floor,
		softfp_ERR, softfp_ERR, softfp_ERR, softfp_ERR, softfp_ERR,  softfp_recip, softfp_ERR,softfp_ERR };
	softfp[0x20] = softfp_cvt;
	softfp[0x31] = softfp_un;
	softfp[0x32] = softfp_eq;
	softfp[0x33] = softfp_ERR;
	softfp[0x34] = softfp_olt;
	
	
	pos[-6] = (DWORD)(softfp+0x20);
	
	for ( unsigned int i=0; i< dest.pos.size(); i++ ) {
		pos[i] = dest.pos[i];
	}
	
	
//	__asm__("int $3");
	
	__asm__ ( 
	"lea  ecx, regs \n"
	"add  ecx, 128 \n"
//	"mov  esi, sram_offset \n"
	"mov  edi, pos \n"
//	"lea  eax, my_print_int \n"
//	"mov  [edi-xx], eax \n"
	
	"lea  eax, save_memory \n"
	"mov  [edi-16], eax \n"
	
	"lea  eax, load_memory \n"
	"mov  [edi-20], eax \n"
	
	"call [edi-4] \n"
	"jmp  my_asm_end \n"
	
	
"load_memory: \n"
	"test  ebx, 0x80000000 \n"
	"jz    load_memory_blockram \n"
	
	"cmp   ebx, 0xffffffff \n"
	"jnz   load_memory_sram \n"
	"int 3 \n"

"load_memory_sram: \n"
	"add   ebx, [edi-8] \n"
	"mov   eax, [ebx] \n"
	"ret \n"
"load_memory_blockram: \n"
	"add   ebx, [edi-12] \n"
	"mov   eax, [ebx] \n"
	"ret \n"



"save_memory: \n"
	"test  ebx, 0x80000000 \n"
	"jz    save_memory_blockram \n"
	
	"cmp   ebx, 0xffffffff \n"
	"jz    my_print_int \n"

	"add   ebx, [edi-8] \n"
	"mov   [ebx], eax \n"
	"ret \n"
"save_memory_blockram: \n"
	"add   ebx, [edi-12] \n"
	"mov   [ebx], eax \n"
	"ret \n"

	
"my_print_int: \n"
	"push  ecx \n"
	"push  eax \n"
	"push  print_int_format \n"
	"call  printf \n"
	"add   esp, 8 \n"
	"pop   ecx \n"
	"ret \n"
	
	
	
"my_asm_end: \n"
	"nop"
	
	:
	:
	: "eax", "ebx", "ecx", "edx", "esi", "edi", "cc"
	);

	return 0;
}
