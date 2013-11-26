#pragma once

#include "x86emit.h"
#include <string>

struct tInstFPArith {
public:

	const char *mnemonic;
	unsigned char fmt;
	unsigned char funct;
	int opercnt;
	int oporder[3]; //0...ftに対応するのはアセンブラコードでいうと何番目？ 1...fs 2...fd  (3を指定すると0固定)

	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
	
};

extern const tInstFPArith InstFPArith[];
extern const unsigned int s_instFPArith;


struct tInstFPComp {
	const char *mnemonic;
	const char fmt;
	unsigned char cond;
	
	void tox86(CAsm86Dest* dest, inst_t instLE) const;
	std::string disasm(inst_t instLE) const;
};

extern const tInstFPComp InstFPComp[];
extern const unsigned int s_instFPComp;




class CInstFPArithDetect : IInstDetect {
private:
	const tInstFPArith *fa;
	
	CInstFPArithDetect(const tInstFPArith *pfa) {
		fa = pfa;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE) {
		const tInstFPArith *fa = NULL;
		
		unsigned char opcode = (instLE >> 26);
		if ( opcode == 0x11 ) {
			unsigned char fmt   = (unsigned char)( (instLE>>21) & 0x1F);
			unsigned char funct = (unsigned char)(instLE & 0x3F);
			
			for (unsigned int i=0; i<s_instFPArith; i++) {
				if ( InstFPArith[i].fmt == fmt && InstFPArith[i].funct == funct ) {
					fa = &InstFPArith[i];
					break;
				}
			}
		}
		
		if ( fa == NULL ) { return NULL; }
		
		return new CInstFPArithDetect(fa);
	};
	
	virtual bool isValid() { return (fa!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { fa->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return fa->disasm(instLE); };
	
};


class CInstFPCompDetect : IInstDetect {
private:
	const tInstFPComp *fc;
	
	CInstFPCompDetect(const tInstFPComp *pfc) {
		fc = pfc;
	};
	
public:
	static IInstDetect* NewFromInst(inst_t instLE) {
		const tInstFPComp *fc = NULL;
		
		unsigned char opcode = (instLE >> 26);
		unsigned char fmt   = (unsigned char)( (instLE>>21) & 0x1F);
		unsigned char check = (unsigned char)( (instLE>>4) & 0xF);
		unsigned char cond  = (unsigned char)(instLE & 0xF);
		
		if ( opcode == 0x11 && check == 3 ) {
			
			for (unsigned int i=0; i<s_instFPComp; i++) {
				if ( InstFPComp[i].fmt == fmt && InstFPComp[i].cond == cond ) {
					fc = &InstFPComp[i];
					break;
				}
			}
		}
		
		if ( fc == NULL ) { return NULL; }
		
		return new CInstFPCompDetect(fc);
	};
	
	virtual bool isValid() { return (fc!=NULL); };
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) { fc->tox86(dest, instLE); };
	virtual std::string Disasm(inst_t instLE) { return fc->disasm(instLE); };
	
};
