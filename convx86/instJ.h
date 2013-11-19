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


class CInstJDetect : IInstDetect {
private:
	const tInstJ *ij;
	
	CInstJDetect(const tInstJ *pij) {
		ij = pij;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE) {
		const tInstJ *ij = NULL;
		
		unsigned char opcode = (instLE >> 26);
		for (unsigned int i=0; i<s_instJ; i++) {
			if ( InstJ[i].opcode == opcode ) {
				ij = &InstJ[i];
				break;
			}
		}
		
		if ( ij == NULL ) { return NULL; }
		
		return new CInstJDetect(ij);
	};
	
	virtual bool isValid() { return (ij!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { ij->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return ij->disasm(instLE); };
	
};

