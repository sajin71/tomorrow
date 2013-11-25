#include "instOther.h"

#include <string>
#include <sstream>

static bool det_bc1f(inst_t instLE) {
	return ((instLE&0xFFE10000) == 0x45000000);
}
static bool det_bc1t(inst_t instLE) {
	return ((instLE&0xFFE10000) == 0x45010000);
}
static bool det_mtc1(inst_t instLE) {
	return ((instLE&0xFFE007FF) == 0x44800000);
}
static bool det_mfc1(inst_t instLE) {
	return ((instLE&0xFFE007FF) == 0x44000000);
}


void tInstOther::tox86(CAsm86Dest* dest, inst_t instLE) const {
	this->pfunc86(dest, this, instLE);
}
std::string tInstOther::disasm(inst_t instLE) const {
	return this->pfuncdisasm(this, instLE);
}


static void proc_bc1 (CAsm86Dest* dest, const tInstOther* io, inst_t instLE) {
	unsigned char cc = (instLE>>18)&0x7;
	imm_t imm = (imm_t)(instLE&0xffff);
	
	// TEST byte ptr [ECX+264], 0x..
	dest->Emit(0xF6);
	dest->EmitModRMexdisp(0, rECX, 66*4);
	dest->Emit( ((unsigned char)1)<<cc );
	
	dest->EmitBranch(imm, (io->tag == 0) );
}


static void proc_mtfc1 (CAsm86Dest* dest, const tInstOther* io, inst_t instLE) {
	unsigned char rt = (instLE>>16)&0x1F;
	unsigned char fs = (instLE>>11)&0x1F;
	
	int src, dst;
	
	
	if ( io->tag == 2 ) {
		//MTC1
		src = rt*4;
		dst = (-32+fs)*4;
	} else {
		//MFC1
		src = (-32+fs)*4;
		dst = rt*4;
	}
	
	// MOV EBX, [ECX+ src]
	dest->EmitMOV2r();
	dest->EmitModRMdisp(rEBX, rECX, src);
	
	// MOV [ECX+ dst], EBX
	dest->EmitMOV2m();
	dest->EmitModRMdisp(rEBX, rECX, dst);
}




static std::string disasm_mtfc1(const tInstOther* io, inst_t instLE) {
	unsigned char rt = (instLE>>16)&0x1F;
	unsigned char fs = (instLE>>11)&0x1F;
	
	std::stringstream ss;
	ss << io->mnemonic << " " << "$"<< (int)rt << ", $f" << (int)fs;
	
	return ss.str();
}

static std::string disasm_bc1(const tInstOther* io, inst_t instLE) {
	unsigned char cc = (instLE>>18)&0x7;
	imm_t imm = (imm_t)(instLE&0xffff);
	
	std::stringstream ss;
	ss << io->mnemonic << " " << (int)cc << ", " << 4*(int)imm;
	
	return ss.str();
}



const tInstOther InstOther[] = {
{ "BC1F",  0, det_bc1f, proc_bc1, disasm_bc1},
{ "BC1T",  1, det_bc1t, proc_bc1, disasm_bc1},
{ "MTC1",  2, det_mtc1, proc_mtfc1, disasm_mtfc1},
{ "MFC1",  3, det_mfc1, proc_mtfc1, disasm_mtfc1},
};
const unsigned int s_instOther = ARRSIZE(InstOther);


IInstDetect* CInstOtherDetect::NewFromInst(inst_t instLE) {

	const tInstOther *io = NULL;
	
	for (unsigned int i=0; i<s_instOther; i++) {
		if ( InstOther[i].pcheck(instLE) ) {
			io = &InstOther[i];
			break;
		}
	}
	
	if ( io == NULL ) { return NULL; }
	
	return new CInstOtherDetect(io);
};

