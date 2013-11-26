#include "x86emit.h"

void CAsm86Dest::Emit(unsigned char inst86) {
	dprintf("%02X ", inst86);
	
	this->code.push_back(inst86);
}

void CAsm86Dest::EmitDisp8(signed char disp8) {
	union {
		unsigned char u;
		signed   char s;
	} c;
	c.s = disp8;
	this->Emit(c.u);
}
void CAsm86Dest::EmitDisp32(disp_t disp32) {
	union {
		unsigned char u[4];
		disp_t s;
	} c;
	c.s = disp32;
	this->Emit(c.u[0]);
	this->Emit(c.u[1]);
	this->Emit(c.u[2]);
	this->Emit(c.u[3]);
}

void CAsm86Dest::EmitModRMdisp(X86REG reg, X86REG base, disp_t disp) {
	char mod;
	if ( disp == 0 ) {
		mod = 0;
	} else if ( isInBYTE(disp) ) {
		mod = 1;
	} else {
		mod = 2;
	}
	
	unsigned char c = mod      << 6 |
	                  (reg &7) << 3 |
	                  (base&7);
	this->Emit(c);
	
	if ( mod == 0 ) { return; }
	else if ( mod == 1 ) {
		this->EmitDisp8( (signed char)disp );
	} else {
		this->EmitDisp32( disp );
	}
}

void CAsm86Dest::EmitModRMr2r(X86REG dest, X86REG src) {
	unsigned char c = 3        << 6 |
	                  (dest&7) << 3 |
	                  (src &7);
	this->Emit(c);
}

void CAsm86Dest::EmitBranch(imm_t imm, bool isJZ) {
	unsigned int to = this->pos.size() + imm;
	
	if ( imm < 0 ) {
		int from86_8 = this->code.size()+2;
		int to86 = this->pos[to];
		
		int disp8 = to86 - from86_8;
		if ( isInBYTE(disp8) ) {
			if ( isJZ ) {
				this->Emit(0x74); //JZ
			} else {
				this->Emit(0x75); //JNZ
			}
			this->EmitDisp8( (signed char)disp8 );
			
			dprintf("\nJ[N]Z %d ;disp8\n", disp8);
			
			return;
		}
	}
	
	if ( isJZ ) {
		this->Emit(0x0F); //JZ
		this->Emit(0x84);
	} else {
		this->Emit(0x0F); //JNZ
		this->Emit(0x85);
	}
	
	unsigned int from86_32 = this->code.size()+4;
	int disp32 = 0;
	
	if ( imm < 0 ) {
		int to86 = this->pos[to];
		disp32 = to86 - from86_32;
	} else {
		this->jumpto.push_back( std::pair<unsigned int, unsigned int>(from86_32, to) );
	}
	
	this->EmitDisp32(disp32);
	dprintf("\nJ[N]Z %d ;disp32\n", disp32);
}
