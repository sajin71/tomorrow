#include "instFP.h"

#include <string>
#include <sstream>



void tInstFPArith::tox86(CAsm86Dest* dest, inst_t instLE) const {
	// PUSH ECX
	dest->Emit(0x51);
	
	unsigned char regs[3];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 16 )); //ft
	regs[1] = (unsigned char)(0x1F & ( instLE >> 11 )); //fs
	regs[2] = (unsigned char)(0x1F & ( instLE >>  6 )); //fd
	
	//PUSH funct
	dest->Emit(0x6A);
	dest->Emit(this->funct);
	
	// PUSH [ECX:fs]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(6, rECX, (regs[1]-32)*4);
	
	// PUSH [ECX:ft]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(6, rECX, (regs[0]-32)*4);
	
	// MOV ECX, [edi-24]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rECX, rEDI, -24);
	
	// CALL [ECX + funct*4] cdecl
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(2, rECX, (this->funct - 0x20)*4);
	
	// ADD esp, 8
	dest->Emit(0x83);
	dest->Emit(0xC4);
	dest->Emit(0x08);
	
	// POP ECX
	dest->Emit(0x59);
	
	// MOV [ECX:fd], EAX
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEAX, rECX, (regs[2]-32)*4);
	

}

std::string tInstFPArith::disasm(inst_t instLE) const {
	
	unsigned char regs[3];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 16 )); //ft
	regs[1] = (unsigned char)(0x1F & ( instLE >> 11 )); //fs
	regs[2] = (unsigned char)(0x1F & ( instLE >>  6 )); //fd
	
	std::stringstream ss;
	//ss << this->mnemonic << " 0x" << std::hex << ((signed long)addr)*4;
	ss << this->mnemonic << " ";
	
	for(int ord=0; ord< this->opercnt; ord++ ) {
		ss << "$f" << (int)regs[ getregbyorder(ord, 3, oporder) ];
		
		if ( ord == (this->opercnt-1) ) { break; }
		
		ss << ", ";
	}
	return ss.str();
}

const tInstFPArith InstFPArith[] = {
{ "ADD.S",    0x10, 0x00, 3, {2,1,0}},
{ "SUB.S",    0x10, 0x01, 3, {2,1,0}},
{ "MUL.S",    0x10, 0x02, 3, {2,1,0}},
{ "DIV.S",    0x10, 0x03, 3, {2,1,0}},
{ "SQRT.S",   0x10, 0x04, 2, {3,1,0}},
{ "ABS.S",    0x10, 0x05, 2, {3,1,0}},
{ "MOV.S",    0x10, 0x06, 2, {3,1,0}},
{ "NEG.S",    0x10, 0x07, 2, {3,1,0}},
{ "ROUND.W.S",0x10, 0x0C, 2, {3,1,0}},
{ "FLOOR.W.S",0x10, 0x0F, 2, {3,1,0}},
{ "RECIP.S",  0x10, 0x15, 2, {3,1,0}},
{ "CVT.S.W",  0x24, 0x20, 2, {3,1,0}},
};
const unsigned int s_instFPArith = ARRSIZE(InstFPArith);





void tInstFPComp::tox86(CAsm86Dest* dest, inst_t instLE) const {

	unsigned char regs[2];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 16 )); //ft
	regs[1] = (unsigned char)(0x1F & ( instLE >> 11 )); //fs
	
	unsigned char cc = (unsigned char)(0x7 & ( instLE >> 8 ));
	
	
	// PUSH ECX
	dest->Emit(0x51);
	
	// PUSH [ECX:fs]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(6, rECX, (regs[1]-32)*4);
	
	// PUSH [ECX:ft]
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(6, rECX, (regs[0]-32)*4);
	
	// MOV ECX, [edi-24]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rECX, rEDI, -24);
	
	// CALL [ECX + funct*4] cdecl
	dest->Emit(0xFF);
	dest->EmitModRMexdisp(2, rECX, 4*( (this->cond|0x30)-0x20 ) );
	
	// ADD esp, 8
	dest->Emit(0x83);
	dest->Emit(0xC4);
	dest->Emit(0x08);
	
	// POP ECX
	dest->Emit(0x59);
	
	// TEST EAX, EAX
	dest->Emit(0x85);
	dest->EmitModRMr2r(rEAX, rEAX);
	
	// JZ not_taken
	dest->Emit(0x74);
	dest->EmitDisp8(0x09);
	
	// cond=True
	// OR byte ptr [ECX+264], 0x01
	dest->Emit(0x80);
	dest->EmitModRMexdisp(1, rECX, 66*4);
	dest->Emit( ((unsigned char)1)<<cc );
	
	// JMP
	dest->Emit(0xEB);
	dest->EmitDisp8(0x07);
	
	// cond=False
	// AND [ECX+264], 0xfe
	dest->Emit(0x80);
	dest->EmitModRMexdisp(4, rECX, 66*4);
	dest->Emit( 0xff ^ (((unsigned char)1)<<cc)  );
	

}

std::string tInstFPComp::disasm(inst_t instLE) const {
	
	unsigned char regs[2];
	regs[0] = (unsigned char)(0x1F & ( instLE >> 16 )); //ft
	regs[1] = (unsigned char)(0x1F & ( instLE >> 11 )); //fs
	unsigned char cc = (unsigned char)(0x7 & ( instLE >> 8 ));
	
	std::stringstream ss;
	ss << this->mnemonic << " " << (int)cc << ", $f"<< (int)regs[1] << ", $f" << (int)regs[0];
	
	return ss.str();
}


const tInstFPComp InstFPComp[] = {
{ "C.UN.S",    0x10, 0x01},
{ "C.EQ.S",    0x10, 0x02},
{ "C.OLT.S",   0x10, 0x04},
};
const unsigned int s_instFPComp = ARRSIZE(InstFPComp);
