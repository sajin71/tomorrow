#pragma once

#include "tools.h"

#include <string>
#include <vector>
#include <map>

enum X86REG { rEAX=0, rECX=1, rEDX=2, rEBX=3, rESP=4, rEBP=5, rESI=6, rEDI=7 };


class CAsm86Dest {
public:
	std::vector<unsigned char> code;
	std::vector<unsigned int> pos;  //MIPSの命令がどこに対応するか？
	std::vector<std::pair<unsigned int, unsigned int> > jumpto; //first: x86上  second:MIPS上
	unsigned char halt;
	unsigned char writezeroreg;
	bool zeroforce;
	
	void Emit(unsigned char inst86);
	
	void EmitMOV2m() { Emit(0x89); };
	void EmitMOV2r() { Emit(0x8B); };
	void EmitNOP()   { Emit(0x90); };
	
	void EmitWriteZeroReg() { Emit(writezeroreg); };
	
	void EmitDisp8(signed char disp8);
	void EmitDisp32(disp_t disp32);
	
	void EmitModRMdisp(X86REG reg, X86REG base, disp_t disp);
	void EmitModRMr2r (X86REG dest, X86REG src);
	void EmitModRMexr(char op, X86REG reg) { EmitModRMr2r( (X86REG)op, reg ); }
	void EmitModRMexdisp(char op, X86REG base, disp_t disp) { EmitModRMdisp( (X86REG)op, base, disp ); }
	
	void EmitBranch(imm_t imm, bool isJZ);
	
	
	CAsm86Dest() {
		halt = 0xCC;
		writezeroreg = 0xCC;
		zeroforce = true;
	}
};

class IInstDetect {
public:
	
	virtual ~IInstDetect() {};
	virtual bool isValid() = 0;
	
	virtual void Tox86(CAsm86Dest* dest, inst_t instLE) = 0;
	virtual std::string Disasm(inst_t instLE) = 0;
	
};

