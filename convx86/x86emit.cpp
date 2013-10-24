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
