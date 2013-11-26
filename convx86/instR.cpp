#include "instR.h"

#include <string>
#include <sstream>

void tInstR::tox86(CAsm86Dest* dest, inst_t instLE) const {
	unsigned char regs[3];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 21 ));
	regs[1] = (unsigned char)(0x1F & ( instLE >> 16 ));
	regs[2] = (unsigned char)(0x1F & ( instLE >> 11 ));
	
	unsigned char shi = (unsigned char)(0x1F & ( instLE >> 6 ));
	
	dprintf("%s s=%d t=%d d=%d shift=%d\n", mnemonic, regs[0], regs[1], regs[2], shi);
	
	this->pfunc(dest, this, regs, shi);
}

std::string tInstR::disasm(inst_t instLE) const {
	unsigned char regs[3];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 21 ));
	regs[1] = (unsigned char)(0x1F & ( instLE >> 16 ));
	regs[2] = (unsigned char)(0x1F & ( instLE >> 11 ));
	
	unsigned char shi = (unsigned char)(0x1F & ( instLE >> 6 ));
	
	std::stringstream ss;
	ss << this->mnemonic;
	ss << " ";
	
	
	if ( !this->shift ) {
		for(int ord=0; ord< this->opercnt; ord++ ) {
			ss << "$" << (int)regs[ getregbyorder(ord, 3, oporder) ];
			
			if ( ord == (this->opercnt-1) ) { break; }
			
			ss << ", ";
		}
	} else {
		for(int ord=0; ord< this->opercnt; ord++ ) {
			ss << "$" << (int)regs[ getregbyorder(ord, 3, oporder) ];
			ss << ", ";
		}
		
		ss << (int)shi;
	}
	
	return ss.str();
}


static void r_generic3(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	// ADD EBX, [ECX+ Rt*4]
	unsigned char funct = ir->funct;
	if        ( funct == 0x20 ) {
		dest->Emit(0x03); //ADD
	} else if ( funct == 0x22 ) {
		dest->Emit(0x2B); //SUB
	} else if ( funct == 0x24 ) {
		dest->Emit(0x23); //AND
	} else if ( funct == 0x25 ) {
		dest->Emit(0x0B); //OR
	} else if ( funct == 0x26 ) {
		dest->Emit(0x33); //XOR
	} else if ( funct == 0x27 ) { //mips: NOR
		dest->Emit(0x0B); //OR
	} else {
		throw std::string("Unknown InstR generic3");
	}
	
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
	
	dprintf("\nMOV EBX, [ECX+%d*4]\n"
	       "XXX EBX, [ECX+%d*4]\n", regs[0], regs[1]);
	
	
	if ( funct == 0x27 ) { //mips: NOR
		// NOT EBX
		dest->Emit(0xF7); //NOT
		dest->EmitModRMexr(2, rEBX);
		dprintf("\nNOT EBX\n");
	}
	
	// MOV [ECX+ Rd*4], EBX
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, regs[2]*4);
	
	dprintf("\nMOV [ECX+%d*4], EBX\n", regs[2]);

}



static void r_add(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	if ( regs[0] == 0 || regs[1] == 0 ) {
		//レジスタ間MOVに
		char copyreg = regs[0]+regs[1];
		dest->EmitMOV2r();
		dest->EmitModRMdisp(rEBX, rECX, copyreg*4);
		
		dest->EmitMOV2m();
		dest->EmitModRMdisp(rEBX, rECX, regs[2]*4);
		
	
		dprintf("\nMOV EBX, [ECX+%d*4]\n"
		       "MOV [ECX+%d*4], EBX\n", copyreg, regs[2]);
	       
	} else {
		r_generic3(dest, ir, regs, shift);
	}

}

static void r_slt(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	// CMP EBX, [ECX+ Rt*4]
	dest->Emit(0x3B);
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
	
	// MOV dword ptr [ECX+ Rd*4], 0
	dest->Emit(0xC7);
	dest->EmitModRMexdisp(0, rECX, regs[2]*4);
	dest->EmitDisp32(0);
	
	// JGE +3
	dest->Emit(0x7D);
	dest->Emit(0x03);
	
	// INC dword ptr [ECX+ Rd*4]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(0, rECX, regs[2]*4);
}


static void r_mult(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEAX, rECX, regs[0]*4);
	
	dest->Emit(0xF7); //MUL
	dest->EmitModRMexdisp(4, rECX, regs[1]*4);
	
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEDX, rECX, 128); //Hi
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEAX, rECX, 132); //Lo
	
	dprintf("\nMOV EAX, [ECX+%d*4]\n"
		     "MUL (EAX, )[ECX+%d*4]\n"
		     "MOV [ECX+128], EDX\n"
		     "MOV [ECX+132], EAX\n", regs[0], regs[1]);
}

static void r_div(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEAX, rECX, regs[0]*4);
	
	// XOR EDX, EDX
	dest->Emit(0x33);
	dest->Emit(0xD2);
	
	dest->Emit(0xF7); //DIV
	dest->EmitModRMexdisp(6, rECX, regs[1]*4);
	
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEDX, rECX, 128); //Hi
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEAX, rECX, 132); //Lo
	
	dprintf("\nMOV EAX, [ECX+%d*4]\n"
	         "XOR EDX, EDX\n"
		     "DIV (EAX, )[ECX+%d*4]\n"
		     "MOV [ECX+128], EDX\n"
		     "MOV [ECX+132], EAX\n", regs[0], regs[1]);
}

static void r_mfhilo(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	dest->EmitMOV2r();
	if ( ir->funct == 0x10 ) { //MFHI
		dest->EmitModRMdisp(rEBX, rECX, 128);
	} else { //MFLO
		dest->EmitModRMdisp(rEBX, rECX, 132);
	}
	
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, regs[2]*4);
	
	dprintf("\nMOV EBX, [ECX+128/132]\n"
	        "MOV [ECX+%d*4], EBX\n", regs[2]);
}

static void r_shift(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
	
	unsigned char exop;
	if ( ir->funct == 0x00 ) { //SLL
		exop = 4;
	} else if ( ir->funct == 0x02 ) { //SRL
		exop = 5;
	} else { //SRA
		exop = 7;
	}
	
	dest->Emit(0xC1);
	dest->EmitModRMexr(exop, rEBX);
	dest->EmitDisp8(shift);
	
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, regs[2]*4);
}

static void r_shiftv(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	if ( dest->zeroforce && regs[2] == 0 ) {
		dest->EmitNOP();
		return;
	}
	
	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[1]*4);
	
	// PUSH ECX
	dest->Emit(0x51);
	
	// MOV ECX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rECX, rECX, regs[0]*4);
	
	unsigned char exop;
	if ( ir->funct == 0x04 ) { //SLL
		exop = 4; //x86(SHL)
	} else if ( ir->funct == 0x06 ) { //SRL
		exop = 5; //x86(SHR)
	} else { //SRA
		exop = 7; //x86(SAR)
	}
	
	// xxx EBX[, cl]
	dest->Emit(0xD3);
	dest->EmitModRMexr(exop, rEBX);
	
	// POP ECX
	dest->Emit(0x59);
	
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, regs[2]*4);
}

static void r_jr(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {

	// MOV EBX, [ECX+ Rs*4]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, regs[0]*4);
	
	// MOV EBX, dword ptr [EDI+EBX]
	dest->EmitMOV2r();
	dest->Emit(0x1C);
	dest->Emit(0x1F);
	// ADD EBX, dword ptr [EDI-4]
	dest->Emit(0x03);
	dest->EmitModRMdisp(rEBX, rEDI, -4);
	// JMP EBX
	dest->Emit(0xFF);
	dest->Emit(0xE3);

}

static void r_nop(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	dest->EmitNOP();
}

static void r_halt(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift) {
	//TODO
	dest->Emit(dest->halt);
}


const tInstR InstR[] = {
{ "ADD",    0x00, 0x20, 3, {1,2,0}, false,  r_add },
{ "SUB",    0x00, 0x22, 3, {1,2,0}, false, r_generic3 },
{ "AND",    0x00, 0x24, 3, {1,2,0}, false, r_generic3 },
{ "OR",     0x00, 0x25, 3, {1,2,0}, false, r_generic3 },
{ "XOR",    0x00, 0x26, 3, {1,2,0}, false, r_generic3 },
{ "NOR",    0x00, 0x27, 3, {1,2,0}, false, r_generic3 },
{ "SLT",    0x00, 0x2A, 3, {1,2,0}, false, r_slt  },
{ "MULT",   0x00, 0x18, 2, {0,1,3}, false, r_mult },
{ "DIV",    0x00, 0x1A, 2, {0,1,3}, false, r_div },
{ "MFHI",   0x00, 0x10, 1, {3,3,0}, false, r_mfhilo },
{ "MFLO",   0x00, 0x12, 1, {3,3,0}, false, r_mfhilo },

{ "NOP",    0x00, 0x00, 0, {3,3,3}, false, r_nop },
{ "HALT",   0x3C, 0x00, 0, {3,3,3}, false, r_halt },
{ "JR",     0x1B, 0x00, 1, {0,3,3}, false, r_jr },

{ "SLL",    0x18, 0x00, 2, {3,1,0}, true, r_shift },
{ "SRL",    0x18, 0x02, 2, {3,1,0}, true, r_shift },
{ "SRA",    0x18, 0x03, 2, {3,1,0}, true, r_shift },
{ "SLLV",   0x18, 0x04, 3, {2,1,0}, false, r_shiftv },
{ "SRLV",   0x18, 0x06, 3, {2,1,0}, false, r_shiftv },
{ "SRAV",   0x18, 0x07, 3, {2,1,0}, false, r_shiftv },
};

const unsigned int s_instR = ARRSIZE(InstR);

