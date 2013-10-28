#include <stdio.h>
#include <string>

#include "MIPSinst.h"
#include "x86emit.h"

void procInst(CAsm86Dest* dest, inst_t inst) {
	
	dest->pos.push_back( dest->code.size() );
	CMIPSInstruction mips(inst);
	
	if ( mips.isUnknown() ) {
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
