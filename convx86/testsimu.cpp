#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#include <string>
#include <sys/mman.h> 

#include "MIPSinst.h"
#include "x86emit.h"

typedef int32_t  int32;
typedef uint32_t DWORD;

DWORD regs[67] = {0,1,2,3,4,5,6,7,8,9,10}; //0...31:fpr  32...63:gpr  64:hi 65:lo 66:cc
unsigned char *insts;
DWORD sram_offset;
DWORD *blockram;
DWORD *pos;


/** External Table Object File **/
// fsqrt_table.o
extern uint32_t _binary_fsqrt_table_start[];
// finv_table.o
extern uint32_t _binary_finv_table_start[];


const char *print_int_format = "%d";
const char *print_char_format = "%c";
const char *print_float_format = "%f";

unsigned int total_insts;

union intflt {
	DWORD i;
	int32 s;
	float f;
};


typedef DWORD(*ptr_softfp)(intflt, intflt);

#define MY_CDECL __attribute__((cdecl))
#define BREAKPOINT __asm("int 3");

#define SOFTFP_BINOP(name, op) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { intflt ret; ret.f = s.f op t.f; return ret.i; }
#define SOFTFP_UNIOP(name, func) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { intflt ret; ret.f = func(s.f); return ret.i; }
#define SOFTFP_COMP(name, op) \
DWORD MY_CDECL softfp_##name (intflt t, intflt s) { return (s.f op t.f)?1:0; }


SOFTFP_BINOP(add, +)
SOFTFP_BINOP(sub, -)
SOFTFP_BINOP(mul, *)
SOFTFP_BINOP(div, /)


// Thanks to YutaMarunaka
DWORD MY_CDECL softfp_sqrt (intflt unused, intflt input) {
	
	uint32_t a0,a1,e,gc[2],y,q;
	uint32_t a = input.i;

	a0 = (a<<9)>>23;  /* a0 <= a(22 downto 14) */
	a1 = (a<<18)>>18; /* a1 <= a(13 downto 0)  */
	e = (a<<1)>>24;   /* e  <= a(30 downto 23) */
	
	uint32_t tablepos = 2*(((e&1)<<9)|a0);
	gc[0] = _binary_fsqrt_table_start[tablepos];
	gc[1] = _binary_fsqrt_table_start[tablepos+1];

	y = gc[1] + ((gc[0] * a1)>>13);  /* GWIDTH = 13 */

	if((e&1) == 0){
		q = ((63+(e>>1))<<23) | y;
	} else {
		q = ((64+(e>>1))<<23) | y;
	}
	
	return q;
}


// Thanks to YutaMarunaka
DWORD MY_CDECL softfp_recip (intflt unused, intflt input) {
	
	uint32_t a0,a1,e,s,gc[2],y,q;
	uint32_t a = input.i;

	a0 = (a<<9)>>22;   /* a0 <= a(22 downto 13) */
	a1 = (a<<19)>>19;  /* a1 <= a(12 downto 0) */
	e = (a<<1)>>24;    /* e <= a(30 downto 23) */
	s = a>>31;         /* s <= a(31) */
	
	uint32_t tablepos = 2*a0;
	gc[0] = _binary_finv_table_start[tablepos];
	gc[1] = _binary_finv_table_start[tablepos+1];

	y = gc[1] - ((gc[0] * a1)>>12);  /* GWIDTH = 12 */

	if(a0 == 0 && a1 == 0){
		q = (s<<31) | ((254 - e)<<23);
	} else {
		q = (s<<31) | ((253 - e)<<23) | y;
	}
	
	return q;
}


SOFTFP_UNIOP(abs, fabs)
DWORD MY_CDECL softfp_mov (intflt t, intflt s) { return s.i; }
SOFTFP_UNIOP(neg, -)
DWORD MY_CDECL softfp_round (intflt t, intflt s) { float f = roundf(s.f); return (int32)f; }
DWORD MY_CDECL softfp_trunc (intflt t, intflt s) { float f = truncf(s.f); return (int32)f; }
DWORD MY_CDECL softfp_ceil  (intflt t, intflt s) { float f = ceilf (s.f); return (int32)f; }
DWORD MY_CDECL softfp_floor (intflt t, intflt s) { float f = floorf(s.f); return (int32)f; }

DWORD MY_CDECL softfp_cvt (intflt t, intflt s) { intflt ret; ret.f = (float)s.s; return ret.i; }

DWORD MY_CDECL softfp_un (intflt t, intflt s) { BREAKPOINT return 0; /*TODO*/ }
SOFTFP_COMP(eq, ==)
SOFTFP_COMP(olt, <)

DWORD MY_CDECL softfp_ERR (intflt t, intflt s) { BREAKPOINT return 0; }



SOFTFP_UNIOP(_sin, sinf)
SOFTFP_UNIOP(_cos, cosf)
SOFTFP_UNIOP(_atan, atanf)


extern "C" { 
DWORD MY_CDECL read_dword() {
	unsigned char p[4];
	fread(p, 1, 4, stdin);
	
	DWORD r = (p[0] << 24) | (p[1] << 16) | (p[2] << 8) | p[3];
	return r;
}

DWORD MY_CDECL read_int() {
	int i;
	scanf("%d", &i);
	return i;
}

DWORD MY_CDECL read_float() {
	intflt r;
	scanf("%f", &(r.f));
	return r.i;
}


DWORD MY_CDECL prerr_float(intflt param) {
	fprintf(stderr, "%lf", (double)param.f);
	return 0;
}


FILE *my_stderr = stderr;

}


void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	// ADD esi, 1
	dest->Emit(0x83);
	dest->EmitModRMexr(0, rESI);
	dest->Emit(0x01);
	
	if ( mips.isUnknown() ) {
		dprintf("Unknown Instruction 0x%08X\n", inst);
		dest->Emit(0xCC);
	} else {
		mips.tox86(dest);
	}
	
}

int main(int argc, char **argv) {

	//DWORD hogera = softfp(1, 2, 3);
	
	FILE *ifp = stdin;
	if ( argc == 2 ) {
		ifp = fopen(argv[1], "rb");
	}
	
	CAsm86Dest dest;
	dest.halt = 0xC3; //RET
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	blockram = (DWORD*)malloc( sizeof(DWORD) * 0x8000 );
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
		softfp_add, softfp_sub,  softfp_mul, softfp_div, softfp_sqrt, softfp_abs, softfp_mov, softfp_neg,
		softfp_ERR, softfp_ERR,  softfp_ERR, softfp_ERR, softfp_round,softfp_trunc, softfp_ceil, softfp_floor,
		softfp_ERR, softfp_ERR,  softfp_ERR, softfp_ERR, softfp_ERR,  softfp_recip,softfp__sin,softfp__cos,softfp__atan };
	softfp[0x20] = softfp_cvt;
	softfp[0x31] = softfp_un;
	softfp[0x32] = softfp_eq;
	softfp[0x33] = softfp_ERR;
	softfp[0x34] = softfp_olt;
	
	
	pos[-6] = (DWORD)(softfp+0x20);
	pos[-7] = dest.pos.size() * 4;
	
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
	
	"mov  esi, 0 \n" //total counter
	
	"call [edi-4] \n"
	
	"mov  total_insts, esi \n"
	
	"jmp  my_asm_end \n"
	
	
"load_memory: \n"
"	mov edx, ebx \n"
"	shr edx, 29 \n"
"	cmp edx, 7 \n"
"	jz  my_read_syscall \n"

"	add ebx, [edi-12+edx] \n"
"	mov eax, [ebx] \n"
"	ret \n"

"my_read_syscall: \n"

"	cmp   ebx, 0xfffffffe  \n"
"	jz    my_read_float  \n"

"	cmp   ebx, 0xffffffff  \n"
"	jz    my_read_int  \n"

"	push  ecx  \n"
"	call read_dword \n"
"	pop ecx  \n"
"	ret  \n"

"my_read_int:  \n"
"	push  ecx  \n"
"	call read_int \n"
"	pop ecx  \n"
"	ret  \n"

"my_read_float:  \n"
"	push ecx  \n"
"	call read_float  \n"
"	pop ecx  \n"
"	ret \n"



"save_memory: \n"
	"mov edx, ebx \n"
	"shr edx, 29 \n"
	"cmp edx, 7 \n"
	"jz  my_write_syscall \n"

	"add ebx, [edi-12+edx] \n"
	"mov [ebx], eax \n"
	
// Invalidate inst if BlockRAM changed
	"test edx, edx \n"
	"jnz  my_write_return \n"
	
	"sub ebx, [edi-12] \n"
	"cmp ebx, [edi-28] \n"
	"jae my_write_return \n"
	
	"mov ebx, [edi+ebx] \n"
	"add ebx, [edi-4] \n"
	"mov byte ptr [ebx], 0xcc \n"

"my_write_return: \n"
	"ret \n"


"my_write_syscall: \n"
	"cmp   ebx, 0xffffffff \n"
	"jz    my_print_char \n"
	
	"cmp   ebx, 0xfffffffd \n"
	"jz    my_perr_int \n"
	
	"cmp   ebx, 0xfffffffc \n"
	"jz    my_perr_char \n"
	
	"cmp   ebx, 0xfffffffb \n"
	"jz    my_perr_float \n"

	
//"my_print_int: \n"
	"push  ecx \n"
	"push  eax \n"
	"push  print_int_format \n"
	"call  printf \n"
	"add   esp, 8 \n"
	"pop   ecx \n"
	"ret \n"

"my_print_char: \n"
	"push  ecx \n"
	"push  eax \n"
	"push  print_char_format \n"
	"call  printf \n"
	"add   esp, 8 \n"
	"pop   ecx \n"
	"ret \n"



"my_perr_int: \n"
	"push  ecx \n"
	"push  eax \n"
	"push  print_int_format \n"
	"push  my_stderr \n"
	"call  fprintf \n"
	"add   esp, 12 \n"
	"pop   ecx \n"
	"ret \n"

"my_perr_char: \n"
	"push  ecx \n"
	"push  eax \n"
	"push  print_char_format \n"
	"push  my_stderr \n"
	"call  fprintf \n"
	"add   esp, 12 \n"
	"pop   ecx \n"
	"ret \n"

/* 暗黙の型変換があるので */
"my_perr_float: \n"
	"push  ecx \n"
	"push  eax \n"
	"call  prerr_float \n"
	"add   esp, 4 \n"
	"pop   ecx \n"
	"ret \n"

"my_asm_end: \n"
	"nop"
	
	:
	:
	: "eax", "ebx", "ecx", "edx", "esi", "edi", "cc"
	);
	
	fprintf(stderr, "Total Instruction Count: %u\n", total_insts);

	return 0;
}
