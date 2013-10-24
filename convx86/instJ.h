#pragma once

#include "x86emit.h"
#include <string>

struct tInstJ {
	const char *mnemonic;
	unsigned char opcode;
	
	void (*pfunc)(CAsm86Dest* dest, const tInstJ* ij, inst_t addr);
	
	// member functions
	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
};

extern const tInstJ InstJ[];
extern const unsigned int s_instJ;
