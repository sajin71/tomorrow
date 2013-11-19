#pragma once

#include "x86emit.h"
#include <string>

struct tInstI {
public:

	enum EInstIType { T_Arith, T_Branch, T_Mem, T_MemCo };
	
	const char *mnemonic;
	unsigned char opcode;
	int opercnt; //オペランドで指定するレジスタの数
	EInstIType type; //即値の形式 0...ふつう 1...PC相対 2...メモリオフセット
	int oporder[2]; //ふつう形式: 0...sに対応するのはアセンブラコードでいうと何番目？ 1...t  (2を指定すると0固定)

	void (*pfunc)(CAsm86Dest* dest, const tInstI* ii, unsigned char regs[], imm_t imm);
	
	// member functions
	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
};

extern const tInstI InstI[];
extern const unsigned int s_instI;


class CInstIDetect : IInstDetect {
private:
	const tInstI *ii;
	
	CInstIDetect(const tInstI *pii) {
		ii = pii;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE) {
		const tInstI *ii = NULL;
		
		unsigned char opcode = (instLE >> 26);
		for (unsigned int i=0; i<s_instI; i++) {
			if ( InstI[i].opcode == opcode ) {
				ii = &InstI[i];
				break;
			}
		}
		
		if ( ii == NULL ) { return NULL; }
		
		return new CInstIDetect(ii);
	};
	
	virtual bool isValid() { return (ii!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { ii->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return ii->disasm(instLE); };
	
};
