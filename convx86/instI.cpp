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
	
	if ( this->type == tInstI::T_Mem || this->type == tInstI::T_MemCo ) {
		ss << "$";
		if ( this->type == tInstI::T_MemCo ) {
			ss << "f";
		}
		ss << (int)regs[1] << ", ";
		ss << imm;
		ss << "($" << (int)regs[0] << ")";
	} else {
		for(int ord=0; ord< this->opercnt; ord++ ) {
			ss << "$" << (int)regs[ getregbyorder(ord, 2, oporder) ];
			ss << ", ";
		}
		
		if ( this->type == tInstI::T_Arith ) {
			ss << imm;
		} else {
			ss << ((signed long)imm)*4;
		}
	}
	
	return ss.str();
}



static void i_generic(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( dest->zeroforce && regs[1] == 0 ) {
		dest->EmitWriteZeroReg();
		return;
	}
	
	uint32_t imm86;
	
	union {
		imm_t s;
		uimm_t u;
	} imm_sign;
	imm_sign.s = imm;
	
	unsigned char exop = 0;
	if ( ii->opcode == 0x08 ) {
		imm86 = imm_sign.s;
		exop = 0; //ADD
	} else if ( ii->opcode == 0x0C ) {
		imm86 = imm_sign.u;
		exop = 4; //AND
	} else if ( ii->opcode == 0x0D ) {
		imm86 = imm_sign.u;
		exop = 1; //OR
	} else {
		throw std::string("Unknown InstI generic");
	}
	
	unsigned char op = 0x81;
	
	if ( regs[0] == regs[1] ) {
		dest->Emit(op);
		dest->EmitModRMexdisp(exop, rECX, regs[0]*4);
		
		dest->EmitDisp32(imm86);
		dprintf("\nXXX dword ptr [ECX+%d*4], %d\n", regs[1], imm);
	} else {
		// MOV EBX, [ECX+ Rs*4]
		dest->EmitMOV2r();
		dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
		
		// ADD EBX, 5
		dest->Emit(op);
		dest->EmitModRMexr(exop, rEBX);
		dest->EmitDisp32(imm86);
		
		// MOV [ECX+ Rt*4], EBX
		dest->EmitMOV2m();
		dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
		
		
		dprintf("\nMOV EBX, [ECX+%d*4]\n"
		       "XXX EBX, %d\n"
		       "MOV [ECX+%d*4], EBX\n" , regs[0], imm, regs[1]);
	}
	
	
}

static void i_ori(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( dest->zeroforce && regs[1] == 0 ) {
		dest->EmitWriteZeroReg();
		return;
	}
	
	if ( regs[0] == 0 ) {
		//即値代入
		dest->Emit(0xC7);
		dest->EmitModRMexdisp(0, rECX, regs[1]*4);
		dest->EmitDisp32( (uimm_t)imm );
		
		dprintf("\nMOV dword ptr [ECX+%d*4], %d\n", regs[1], imm);
	} else {
		i_generic(dest, ii, regs, imm);
	}
}


static void i_slti(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( dest->zeroforce && regs[1] == 0 ) {
		dest->EmitWriteZeroReg();
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
	if ( ii->type == tInstI::T_Mem && dest->zeroforce && regs[1] == 0 ) {
		dest->EmitWriteZeroReg();
		return;
	}
	
	int reg_offset = 0;
	if ( ii->type == tInstI::T_MemCo ) {
		reg_offset = -32*4;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	// ADD EBX, imm
	if ( isInBYTE(imm) ) {
		dest->Emit(0x83);
		dest->EmitModRMexr(0, rEBX);
		dest->EmitDisp8( (signed char)imm );
	} else {
		dest->Emit(0x81);
		dest->EmitModRMexr(0, rEBX);
		dest->EmitDisp32(imm);
	}
	
	// CALL [EDI-20]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(2, rEDI, -20);
	
	// MOV [ECX+ Rt*4], EAX
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEAX, rECX, regs[1]*4 + reg_offset);
}


static void i_sw(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	
	int reg_offset = 0;
	if ( ii->type == tInstI::T_MemCo ) {
		reg_offset = -32*4;
	}
	
	
	// MOV EAX, [ECX+ Rt*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEAX, rECX, regs[1]*4 + reg_offset);
	
	/*
	// TODO: 分岐命令でやる
	if ( false && regs[0]==0 && imm == -1 ) {
		dprintf("sw convert to output\n");
		
		// CALL [EDI-8]
		dest->Emit(0xFF);
		dest->EmitModRMexdisp(2, rEDI, -8);
	} else {
	*/
	
		// MOV EBX, [ECX+ Rs*4]
		dest->EmitMOV2r();
		dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
		
		// ADD EBX, imm
		if ( isInBYTE(imm) ) {
			dest->Emit(0x83);
			dest->EmitModRMexr(0, rEBX);
			dest->EmitDisp8( (signed char)imm );
		} else {
			dest->Emit(0x81);
			dest->EmitModRMexr(0, rEBX);
			dest->EmitDisp32(imm);
		}
		
		// CALL [EDI-16]
		dest->Emit(0xFF);
		dest->EmitModRMexdisp(2, rEDI, -16);
		
		/*
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
		*/
	//}
	
}


static void i_lui(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm) {
	if ( dest->zeroforce && regs[1] == 0 ) {
		dest->EmitWriteZeroReg();
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
	
	dest->EmitBranch(imm, (ii->opcode == 0x04) );

}


const tInstI InstI[] = {
{ "ADDI",   0x08, 2, tInstI::T_Arith, {1,0}, i_generic},
{ "SLTI",   0x0A, 2, tInstI::T_Arith, {1,0}, i_slti},
{ "ANDI",   0x0C, 2, tInstI::T_Arith, {1,0}, i_generic},
{ "ORI",    0x0D, 2, tInstI::T_Arith, {1,0}, i_ori},
{ "LW",     0x23, 2, tInstI::T_Mem,   {}   , i_lw},
{ "SW",     0x2B, 2, tInstI::T_Mem,   {}   , i_sw},
{ "LWC1",   0x31, 2, tInstI::T_MemCo, {}   , i_lw},
{ "SWC1",   0x39, 2, tInstI::T_MemCo, {}   , i_sw},
{ "LUI",    0x0F, 1, tInstI::T_Arith, {2,0}, i_lui},
{ "BEQ",    0x04, 2, tInstI::T_Branch,{0,1}, i_branch},
{ "BNE",    0x05, 2, tInstI::T_Branch,{0,1}, i_branch},

};

const unsigned int s_instI = ARRSIZE(InstI);
