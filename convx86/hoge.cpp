#include <stdio.h>
#include "x86emit.h"
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
	
	
	// 継承とかにしちゃうと初期化書くのが面倒になる感じなので・・・
	void tox86(CAsm86Dest* dest) {
		     if ( type == MIPS_Inst_R ) { is.r->tox86(dest, instLE); }
		else if ( type == MIPS_Inst_I ) { is.i->tox86(dest, instLE); }
		else if ( type == MIPS_Inst_J ) { is.j->tox86(dest, instLE); }
	};
	
	std::string disasm() {
		     if ( type == MIPS_Inst_R ) { return is.r->disasm(instLE); }
		else if ( type == MIPS_Inst_I ) { return is.i->disasm(instLE); }
		else if ( type == MIPS_Inst_J ) { return is.j->disasm(instLE); }
		return std::string("Unknown");
	};
	
	CMIPSInstruction(inst_t instLE) : instLE(instLE), type(MIPS_Inst_Unknown) {
		
		is.p = NULL;
		
		unsigned char opcode = (instLE >> 26);
		
		{
			const tInstR *ir = NULL;
			unsigned char funct  = (unsigned char)(instLE & 0x3F);
			for (unsigned int i=0; i<s_instR; i++) {
				if ( InstR[i].opcode == opcode && InstR[i].funct == funct ) {
					ir = &InstR[i];
					break;
				}
			}
			
			if ( ir ) {
				type = MIPS_Inst_R;
				is.r = ir;
				return;
			}
		}
		
		{
			const tInstI *ii = NULL;
			for (unsigned int i=0; i<s_instI; i++) {
				if ( InstI[i].opcode == opcode ) {
					ii = &InstI[i];
					break;
				}
			}
			
			if ( ii ) {
				type = MIPS_Inst_I;
				is.i = ii;
				return;
			}
		}
		{
			const tInstJ *ij = NULL;
			for (unsigned int i=0; i<s_instJ; i++) {
				if ( InstJ[i].opcode == opcode ) {
					ij = &InstJ[i];
					break;
				}
			}
			
			if ( ij ) {
				type = MIPS_Inst_J;
				is.j = ij;
				return;
			}
		}
	};
};

void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	if ( mips.type == MIPS_Inst_Unknown ) {
		dprintf("Unknown Instruction 0x%08X\n", inst);
		dest->Emit(0xCC);
	} else {
		fputs(mips.disasm().c_str() , stderr);
		fputs("\n", stderr);
		mips.tox86(dest);
	}

	
	//throw std::string("Unknown Opcode/funct");
	
}

int main(void) {

	FILE *ifp = stdin;//fopen("/dev/stdin", "rb");
	
	CAsm86Dest dest;
	
	union {
		inst_t inst;
		unsigned char b[4];
	} buf;
	
	while ( fread(&buf, sizeof(inst_t), 1, ifp) ==1 ) {
		
		inst_t instLE = buf.b[0] << 24 |
		              buf.b[1] << 16 |
		              buf.b[2] << 8  |
		              buf.b[3] << 0;
		dprintf("0x%08X  ", instLE);
		procInst(&dest, instLE);
		dprintf("\n");

	}
	
	for ( unsigned int i=0; i< dest.jumpto.size(); i++ ) {
		unsigned int by = dest.jumpto[i].first;
		unsigned int to = dest.jumpto[i].second;
		
		if ( to >= dest.pos.size() ) {
			throw std::string("Unknown forward jump");
		}
		
		union {
			inst_t w;
			unsigned char b[4];
		} addr;
		addr.w = dest.pos[to] - by;
		
		dest.code[ by-4 ] = addr.b[0];
		dest.code[ by-3 ] = addr.b[1];
		dest.code[ by-2 ] = addr.b[2];
		dest.code[ by-1 ] = addr.b[3];
	}
	
	for ( unsigned int i=0; i< dest.code.size(); i++ ) {
		dprintf("0x%02X, ", dest.code[i]);
		//fwrite(&dest.code[i], 1,1, stdout);
	}
	dprintf("\n");
	
	return 0;
}
