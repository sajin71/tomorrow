#pragma once

#include "x86emit.h"
#include <string>

struct tInstI {
	const char *mnemonic;
	unsigned char opcode;
	int opercnt; //オペランドで指定するレジスタの数
	char type; //即値の形式 0...ふつう 1...PC相対 2...メモリオフセット
	int oporder[2]; //ふつう形式: 0...sに対応するのはアセンブラコードでいうと何番目？ 1...t  (2を指定すると0固定)

	void (*pfunc)(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm);
	
	// member functions
	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
};

extern const tInstI InstI[];
extern const unsigned int s_instI;
