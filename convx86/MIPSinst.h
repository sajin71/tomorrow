#pragma once

#include "instR.h"
#include "instI.h"
#include "instJ.h"
#include "instFP.h"
#include "instOther.h"

#include <string>

enum MIPSinstType { MIPS_Inst_Unknown, MIPS_Inst_R, MIPS_Inst_I, MIPS_Inst_J, MIPS_Inst_FPArith, MIPS_Inst_FPComp, MIPS_Inst_Other };

class CMIPSInstruction {
private:
	
	IInstDetect *detect;
	
public:
	const inst_t instLE;
	MIPSinstType type;
	
	~CMIPSInstruction() {
		if ( detect ) {
			delete detect;
			detect = NULL;
		}
	}
	
	bool isUnknown() { return (detect==NULL); }
	
	void tox86(CAsm86Dest* dest);
	std::string disasm();
	
	CMIPSInstruction(inst_t instLE);
};

