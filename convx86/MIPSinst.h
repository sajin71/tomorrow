#pragma once

#include "instR.h"
#include "instI.h"
#include "instJ.h"

#include <string>

enum MIPSinstType { MIPS_Inst_Unknown, MIPS_Inst_R, MIPS_Inst_I, MIPS_Inst_J };

class CMIPSInstruction {
private:
	union {
		const unsigned char *p;
		const tInstR *r;
		const tInstI *i;
		const tInstJ *j;
	} is;
	
public:
	const inst_t instLE;
	MIPSinstType type;
	
	bool isUnknown() { return (type==MIPS_Inst_Unknown); }
	
	// 継承とかにしちゃうと初期化書くのが面倒になる感じなので・・・
	void tox86(CAsm86Dest* dest);
	std::string disasm();
	
	CMIPSInstruction(inst_t instLE);
};

