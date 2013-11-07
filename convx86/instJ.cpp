#include "instJ.h"
#include <string>
#include <sstream>

void tInstJ::tox86(CAsm86Dest* dest, inst_t instLE) const {
	inst_t addr = 0x3FFFFFF&instLE;
	dprintf("%s addr=%d\n", this->mnemonic, addr);
	this->pfunc(dest, this, addr);
}

std::string tInstJ::disasm(inst_t instLE) const {
	inst_t addr = 0x3FFFFFF&instLE;
	std::stringstream ss;
	ss << this->mnemonic << " 0x" << std::hex << ((signed long)addr)*4;
	
	return ss.str();
}

static void jumpimpl(CAsm86Dest* dest, const tInstJ* ij, inst_t to) {
	
	int imm = to - dest->pos.size();
	
	if ( imm < 0 ) {
		int from86_8 = dest->code.size()+2;
		int to86 = dest->pos[to];
		
		int disp8 = to86 - from86_8;
		if ( isInBYTE(disp8) ) {
			dest->Emit(0xEB); //JMP
			dest->EmitDisp8( (signed char)disp8 );
			
			dprintf("\nJMP %d ;disp8\n", disp8);
			
			return;
		}
	}
	
	dest->Emit(0xE9); //JMP
	
	unsigned int from86_32 = dest->code.size()+4;
	int disp32 = 0;
	
	if ( imm < 0 ) {
		int to86 = dest->pos[to];
		disp32 = to86 - from86_32;
	} else {
		dest->jumpto.push_back( std::pair<unsigned int, unsigned int>(from86_32, to) );
	}
	
	dest->EmitDisp32(disp32);
	dprintf("\nJMP %d ;disp32\n", disp32);

}

static void j_j(CAsm86Dest* dest, const tInstJ* ij, inst_t addr) {
	jumpimpl(dest, ij, addr);
}

static void j_jal(CAsm86Dest* dest, const tInstJ* ij, inst_t addr) {
	// $31にリターン先を入れる
	dest->Emit(0xC7);
	dest->EmitModRMexdisp(0, rECX, 31*4);
	dest->EmitDisp32( dest->pos.size() );
	
	dprintf("\nMOV [ECX+31*4], %lu\n", dest->pos.size());
	
	jumpimpl(dest, ij, addr);
}


const tInstJ InstJ[] = {
{ "J",      0x02, j_j},
{ "JAL",    0x03, j_jal},
};
const unsigned int s_instJ = ARRSIZE(InstJ);
