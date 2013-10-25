#include "instI.h"

#include <string>
#include <sstream>

void tInstI::tox86(CAsm86Dest* dest, inst_t instLE) const {
	unsigned char regs[2];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 21 ));
	regs[1] = (unsigned char)(0x1F & ( instLE >> 16 ));
	
	imm_t imm = (imm_t)(0xFFFF & instLE);
	
	dprintf("%s s=%d t=%d imm=0x%04x\n", mnemonic, regs[0], regs[1], (uimm_t)imm);
	
	this->pfunc(dest, this, regs, imm);
}

std::string tInstI::disasm(inst_t instLE) const {
	unsigned char regs[2];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 21 ));
	regs[1] = (unsigned char)(0x1F & ( instLE >> 16 ));
	
	imm_t imm = (imm_t)(0xFFFF & instLE);
	
	std::stringstream ss;
	ss << this->mnemonic;
	ss << " ";
	
	if ( this->type != 2 ) {
		for(int ord=0; ord< this->opercnt; ord++ ) {
			ss << "$" << (int)regs[ getregbyorder(ord, 2, oporder) ];
			ss << ", ";
		}
		
		if ( this->type == 0 ) {
			ss << "0x" << std::hex << imm;
		} else {
			ss << ((signed long)imm)*4;
		}
	} else {
		ss << "$" << (int)regs[1] << ", ";
		ss << imm;
		ss << "($" << (int)regs[0] << ")";
	}
	
	return ss.str();
}



static void i_generic(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( regs[1] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	unsigned char exop = 0;
	if ( ii->opcode == 0x08 ) {
		exop = 0; //ADD
	} else if ( ii->opcode == 0x0C ) {
		exop = 4; //AND
	} else if ( ii->opcode == 0x0D ) {
		exop = 1; //OR
	} else {
		throw std::string("Unknown InstI generic");
	}
	
	unsigned char op = 0xCC;
	if ( isInBYTE(imm) ) {
		op = 0x83;
	} else {
		op = 0x81;
	}
	
	if ( regs[0] == regs[1] ) {
		dest->Emit(op);
		dest->EmitModRMexdisp(exop, rECX, regs[0]*4);
		
		if ( isInBYTE(imm) ) {
			dest->EmitDisp8( (signed char)imm );
		} else {
			dest->EmitDisp32(imm);
		}
		dprintf("\nXXX dword ptr [ECX+%d*4], %d\n", regs[1], imm);
	} else {
		// MOV EBX, [ECX+ Rs*4]
		dest->EmitMOV2r();
		dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
		
		// ADD EBX, 5
		dest->Emit(op);
		dest->EmitModRMexr(exop, rEBX);
		if ( isInBYTE(imm) ) {
			dest->EmitDisp8( (signed char)imm );
		} else {
			dest->EmitDisp32(imm);
		}
		
		// MOV [ECX+ Rt*4], EBX
		dest->EmitMOV2m();
		dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
		
		
		dprintf("\nMOV EBX, [ECX+%d*4]\n"
		       "XXX EBX, %d\n"
		       "MOV [ECX+%d*4], EBX\n" , regs[0], imm, regs[1]);
	}
	
	
}

static void i_addi(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( regs[1] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	if ( regs[0] == 0 ) {
		//即値代入
		dest->Emit(0xC7);
		dest->EmitModRMexdisp(0, rECX, regs[1]*4);
		dest->EmitDisp32(imm);
		
		dprintf("\nMOV dword ptr [ECX+%d*4], %d\n", regs[1], imm);
	} else {
		i_generic(dest, ii, regs, imm);
	}
}


static void i_slti(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( regs[1] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// CMP dword ptr [ECX+ Rs*4], imm
	unsigned char op = 0xCC;
	if ( isInBYTE(imm) ) {
		op = 0x83;
	} else {
		op = 0x81;
	}
	dest->Emit(op);
	dest->EmitModRMexdisp(7, rECX, regs[0]*4);
	if ( isInBYTE(imm) ) {
		dest->EmitDisp8( (signed char)imm );
	} else {
		dest->EmitDisp32(imm);
	}
	
	// MOV dword ptr [ECX+ Rt*4], 0
	dest->Emit(0xC7);
	dest->EmitModRMexdisp(0, rECX, regs[1]*4);
	dest->EmitDisp32(0);
	
	// JGE +3
	dest->Emit(0x7D);
	dest->Emit(0x03);
	
	// INC dword ptr [ECX+ Rt*4]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(0, rECX, regs[1]*4);
}


static void i_lw(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( regs[1] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	if ( isInBYTE(imm) ) {
		// MOV EBX, [ESI+EBX+imm]
		dest->Emit(0x8B);
		dest->Emit(0x5C);
		dest->Emit(0x1E);
		dest->EmitDisp8( (signed char)imm );
	} else {
		// MOV EBX, [ESI+EBX+imm]
		dest->Emit(0x8B);
		dest->Emit(0x9C);
		dest->Emit(0x1E);
		dest->EmitDisp32(imm);
	}
	
	// MOV [ECX+ Rt*4], EBX
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
}


static void i_sw(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	// PUSH EAX
	dest->Emit(0x50);
	
	// MOV EAX, [ECX+ Rt*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEAX, rECX, regs[1]*4);
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	if ( isInBYTE(imm) ) {
		// MOV [ESI+EBX+imm], EAX
		dest->Emit(0x89);
		dest->Emit(0x44);
		dest->Emit(0x1E);
		dest->EmitDisp8( (signed char)imm );
	} else {
		// MOV [ESI+EBX+imm], EAX
		dest->Emit(0x89);
		dest->Emit(0x84);
		dest->Emit(0x1E);
		dest->EmitDisp32(imm);
	}
	
	// POP EAX
	dest->Emit(0x58);
}


static void i_lui(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( regs[1] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	dest->Emit(0xC7);
	dest->EmitModRMexdisp(0, rECX, regs[1]*4);
	dest->EmitDisp32(imm<<16);
}


static void i_branch(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	// CMP EBX, [ECX+ Rt*4]
	dest->Emit(0x3B); //TODO: 0x39かも
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
	
	dprintf("\nMOV EBX, [ECX+%d*4]\n"
	       "CMP EBX, [ECX+%d*4]\n", regs[0], regs[1]);
	
	unsigned int to = dest->pos.size() + imm;
	
	if ( imm < 0 ) {
		int from86_8 = dest->code.size()+2;
		int to86 = dest->pos[to];
		
		int disp8 = to86 - from86_8;
		if ( isInBYTE(disp8) ) {
			if ( ii->opcode == 0x04 ) {
				dest->Emit(0x74); //JZ
			} else if ( ii->opcode == 0x05 ) {
				dest->Emit(0x75); //JNZ
			}
			dest->EmitDisp8( (signed char)disp8 );
			
			dprintf("\nJ[N]Z %d ;disp8\n", disp8);
			
			return;
		}
	}
	
	if ( ii->opcode == 0x04 ) {
		dest->Emit(0x0F); //JZ
		dest->Emit(0x84);
	} else if ( ii->opcode == 0x05 ) {
		dest->Emit(0x0F); //JNZ
		dest->Emit(0x85);
	}
	
	unsigned int from86_32 = dest->code.size()+4;
	int disp32 = 0;
	
	if ( imm < 0 ) {
		int to86 = dest->pos[to];
		disp32 = to86 - from86_32;
	} else {
		dest->jumpto.push_back( std::pair<unsigned int, unsigned int>(from86_32, to) );
	}
	
	dest->EmitDisp32(disp32);
	dprintf("\nJ[N]Z %d ;disp32\n", disp32);

}


const tInstI InstI[] = {
{ "ADDI",   0x08, 2, 0, {1,0}, i_addi},
{ "SLTI",   0x0A, 2, 0, {1,0}, i_slti},
{ "ANDI",   0x0C, 2, 0, {1,0}, i_generic},
{ "ORI",    0x0D, 2, 0, {1,0}, i_generic},
{ "LW",     0x23, 2, 2, {}   , i_lw},
{ "SW",     0x2B, 2, 2, {}   , i_sw},
{ "LUI",    0x0F, 2, 0, {2,0}, i_lui},
{ "BEQ",    0x04, 2, 1, {0,1}, i_branch},
{ "BNE",    0x05, 2, 1, {0,1}, i_branch},

};

const unsigned int s_instI = ARRSIZE(InstI);
