#pragma once

#include "x86emit.h"
#include <string>

struct tInstR {
	
	const char *mnemonic;
	unsigned char opcode;
	unsigned char funct;
	int opercnt;
	int oporder[3]; //0...sに対応するのはアセンブラコードでいうと何番目？ 1...t 2...d  (3を指定すると0固定)
	bool shift;
	
	void (*pfunc)(CAsm86Dest* dest, const tInstR* ir, unsigned char regs[], unsigned char shift);

	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
	
};

extern const tInstR InstR[];
extern const unsigned int s_instR;
