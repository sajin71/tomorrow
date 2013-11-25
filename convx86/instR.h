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


class CInstRDetect : IInstDetect {
private:
	const tInstR *ir;
	
	CInstRDetect(const tInstR *pir) {
		ir = pir;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE) {
		const tInstR *ir = NULL;
		
		unsigned char opcode = (instLE >> 26);
		unsigned char funct  = (unsigned char)(instLE & 0x3F);
		for (unsigned int i=0; i<s_instR; i++) {
			if ( InstR[i].opcode == opcode && InstR[i].funct == funct ) {
				ir = &InstR[i];
				break;
			}
		}
		
		if ( ir == NULL ) { return NULL; }
		
		return new CInstRDetect(ir);
	};
	
	virtual bool isValid() { return (ir!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { ir->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return ir->disasm(instLE); };
	
};

