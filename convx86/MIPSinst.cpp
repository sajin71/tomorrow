#include "MIPSinst.h"

void CMIPSInstruction::tox86(CAsm86Dest* dest) {
	if ( !this->isUnknown() ) {
		detect->Tox86(dest, instLE);
	} else {
		dest->Emit(0xCC);
	}
};

std::string CMIPSInstruction::disasm() {
	if ( !this->isUnknown() ) {
		return detect->Disasm(instLE);
	}
	return std::string("Unknown");
};

CMIPSInstruction::CMIPSInstruction(inst_t instLE) : instLE(instLE), type(MIPS_Inst_Unknown) {
	
	detect = CInstRDetect::NewFromInst(instLE);
	if(detect) { return; }
	
	detect = CInstIDetect::NewFromInst(instLE);
	if(detect) { return; }
	
	detect = CInstJDetect::NewFromInst(instLE);
	if(detect) { return; }
	
	detect = CInstFPArithDetect::NewFromInst(instLE);
	if(detect) { return; }
	
	detect = CInstFPCompDetect::NewFromInst(instLE);
	if(detect) { return; }
	
	detect = CInstOtherDetect::NewFromInst(instLE);
	if(detect) { return; }
};
