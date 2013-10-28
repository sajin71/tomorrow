#include "MIPSinst.h"

void CMIPSInstruction::tox86(CAsm86Dest* dest) {
	     if ( type == MIPS_Inst_R ) { is.r->tox86(dest, instLE); }
	else if ( type == MIPS_Inst_I ) { is.i->tox86(dest, instLE); }
	else if ( type == MIPS_Inst_J ) { is.j->tox86(dest, instLE); }
};

std::string CMIPSInstruction::disasm() {
	     if ( type == MIPS_Inst_R ) { return is.r->disasm(instLE); }
	else if ( type == MIPS_Inst_I ) { return is.i->disasm(instLE); }
	else if ( type == MIPS_Inst_J ) { return is.j->disasm(instLE); }
	return std::string("Unknown");
};

CMIPSInstruction::CMIPSInstruction(inst_t instLE) : instLE(instLE), type(MIPS_Inst_Unknown) {
	
	is.p = NULL;
	
	unsigned char opcode = (instLE >> 26);
	
	{
		const tInstR *ir = NULL;
		unsigned char funct  = (unsigned char)(instLE & 0x3F);
		for (unsigned int i=0; i<s_instR; i++) {
			if ( InstR[i].opcode == opcode && InstR[i].funct == funct ) {
				ir = &InstR[i];
				break;
			}
		}
		
		if ( ir ) {
			type = MIPS_Inst_R;
			is.r = ir;
			return;
		}
	}
	
	{
		const tInstI *ii = NULL;
		for (unsigned int i=0; i<s_instI; i++) {
			if ( InstI[i].opcode == opcode ) {
				ii = &InstI[i];
				break;
			}
		}
		
		if ( ii ) {
			type = MIPS_Inst_I;
			is.i = ii;
			return;
		}
	}
	{
		const tInstJ *ij = NULL;
		for (unsigned int i=0; i<s_instJ; i++) {
			if ( InstJ[i].opcode == opcode ) {
				ij = &InstJ[i];
				break;
			}
		}
		
		if ( ij ) {
			type = MIPS_Inst_J;
			is.j = ij;
			return;
		}
	}
};
