#pragma once

#include "x86emit.h"
#include <string>

struct tInstOther {
public:

	const char *mnemonic;
	int tag;
	
	bool (*pcheck)(inst_t instLE);
	void (*pfunc86)(CAsm86Dest* dest, const tInstOther* io, inst_t instLE);
	std::string (*pfuncdisasm)(const tInstOther* io, inst_t instLE);
	
	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
	
};

extern const tInstOther InstOther[];
extern const unsigned int s_instOther;


class CInstOtherDetect : IInstDetect {
private:
	const tInstOther *io;
	
	CInstOtherDetect(const tInstOther *pio) {
		io = pio;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE);
	
	virtual bool isValid() { return (io!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { io->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return io->disasm(instLE); };
	
};
