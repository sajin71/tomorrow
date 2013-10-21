#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <vector>
#include <map>
#include <string>

#define BUFSIZE 2048
#define ARRSIZE(x) (sizeof(x) / sizeof(x[0]))

#define dprintf printf

typedef uint32_t inst_t;

// for VC++
#ifdef _MSC_VER
	#define strcasecmp stricmp
#endif

struct tInstR {
	const char *mnemonic;
	unsigned char opcode;
	unsigned char funct;
	int opercnt;
	int oporder[3]; //0...sに対応するのはアセンブラコードでいうと何番目？ 1...t 2...d  (3を指定すると0固定)
	bool shift;
};
const tInstR InstR[] = {
{ "ADD",    0x00, 0x20, 3, {1,2,0}, false },
{ "SUB",    0x00, 0x22, 3, {1,2,0}, false },
{ "AND",    0x00, 0x24, 3, {1,2,0}, false },
{ "OR",     0x00, 0x25, 3, {1,2,0}, false },
{ "XOR",    0x00, 0x26, 3, {1,2,0}, false },
{ "NOR",    0x00, 0x27, 3, {1,2,0}, false },
{ "MULT",   0x00, 0x18, 2, {0,1,3}, false },
{ "DIV",    0x00, 0x1A, 2, {0,1,3}, false },
{ "MFHI",   0x00, 0x10, 1, {3,3,0}, false },
{ "MFLO",   0x00, 0x12, 1, {3,3,0}, false },

{ "NOP",    0x00, 0x00, 0, {3,3,3}, false },
{ "SLL",    0x00, 0x00, 2, {1,0,3}, true },
{ "SRL",    0x00, 0x02, 2, {1,0,3}, true },
{ "SRA",    0x00, 0x03, 2, {1,0,3}, true },

// Tommorow extension
{ "OUTPUT", 0x3f, 0x00, 1, {0,1,2} },
{ "INPUT",  0x3e, 0x00, 1, {0,1,2} },
};


struct tInstI {
	const char *mnemonic;
	unsigned char opcode;
	int opercnt; //オペランドで指定するレジスタの数
	char type; //即値の形式 0...ふつう 1...オフセット
	int oporder[2]; //ふつう形式: 0...sに対応するのはアセンブラコードでいうと何番目？ 1...t  (2を指定すると0固定)
};
const tInstI InstI[] = {
{ "ADDI",   0x08, 2, 0, {1,0}},
{ "ANDI",   0x0C, 2, 0, {1,0}},
{ "ORI",    0x0D, 2, 0, {1,0}},
{ "LW",     0x23, 2, 1, {}   },
{ "SW",     0x2B, 2, 1, {}   },
{ "LUI",    0x0F, 2, 0, {2,0}},
};

struct tState {
	int linenum;
	std::vector<inst_t> dest;
	std::string nextlabel;
	
	std::map<std::string, int> labels;
};

bool is_blank(char c) {
	return (c==' ') || (c=='\t') || (c=='\r') || (c=='\n');
}

// 冒頭末尾の空白を削除
char* trim(char *str) {
	//冒頭
	char *head = str;
	while ( is_blank(*head) ) {
		head++;
	}
	
	//末尾
	char *tail = str + strlen(str) -1;
	while ( is_blank(*tail) && tail > head ) {
		*tail = '\0';
	}
	
	return head;
}

// ある文字をNULに置き換える
char* delafter(char *buf, char letter) {
	char *p = strchr(buf, letter);
	if ( p ) { *p = '\0'; }
	
	return p;
}



/*** オペランド関連の関数 ***/

const char *nregname[32][2] = {
{ "0", "zero"}, { "1", "at"}, { "2", "v0"}, { "3", "v1"}, { "4", "a0"}, { "5", "a1"}, { "6", "a2"}, { "7", "a3"},
{ "8", "t0"},   { "9", "t1"}, {"10", "t2"}, {"11", "t3"}, {"12", "t4"}, {"13", "t5"}, {"14", "t6"}, {"15", "t7"},
{"16", "s0"},   {"17", "s1"}, {"18", "s2"}, {"19", "s3"}, {"20", "s4"}, {"21", "s5"}, {"22", "s6"}, {"23", "s7"},
{"24", "t8"},   {"25", "t9"}, {"26", "k0"}, {"27", "k1"}, {"28", "gp"}, {"29", "sp"}, {"30", "fp"}, {"31", "ra"}
};

long str2long(char* op) {
	char *endptr = NULL;
	long ret = strtol(op, &endptr, 0);
	if ( endptr != NULL ) {
		throw std::string("Invalid numeric constant `") + std::string(op) + std::string("'");
	}
	
	return ret;
}

// 整数レジスタ名をレジスタ番号に変換する
short numreg(char* op) {
	if ( op[0] == '$' ) {
		op++;
		
		for(int i=0; i<32; i++) {
			if ( strcasecmp(nregname[i][0], op) == 0 ||
			     strcasecmp(nregname[i][1], op) == 0 ) {
				return i;
			}
		}
	}
	
	throw std::string("Invalid operand `") + std::string(op) + std::string("'");
}


// オペランドを切り分ける
// 返り値: オペランドの数
int opersplit(char *operand, char *op[3]) {
	char *pos = operand;
	char *comma;
	
	op[0] = pos;
	comma = strchr(pos, ',');
	if ( comma == NULL ) {
		return 1;
	}
	*comma = '\0';
	pos = comma+1;
	
	op[1] = pos;
	comma = strchr(pos, ',');
	if ( comma == NULL ) {
		return 2;
	}
	*comma = '\0';
	pos = comma+1;
	
	op[2] = pos;
	return 3;
}



// operandはNULLかも
void proc(char* mnemonic, char* operand, tState *state) {
	
	// TODO: なんか制御とかするんだろうけど
	if ( mnemonic[0] == '.' ) {
		return;
	}
	
	char *end = &mnemonic[ strlen(mnemonic) -1];
	if ( *end == ':' ) {
		//ラベルだ
		*end = '\0';
		char *label = trim(mnemonic);
		
		if ( label[0] == '\0' ) {
			throw std::string("Unknown label delimiter `:'");
		}
		
		state->nextlabel = label;
		
		dprintf("LABEL %s\n", label);
		return;
	}
	
	dprintf("%s\n", mnemonic);
	
	// ラベルを登録する
	if ( !state->nextlabel.empty() ) {
		if ( state->labels.find(state->nextlabel) != state->labels.end() ) {
			throw std::string("label `") + state->nextlabel + std::string("' has previous declaration");
		}
		state->labels.insert( std::map<std::string, int>::value_type( state->nextlabel, 4* state->dest.size() ) );
		state->nextlabel = "";
	}
	
	
	// *** R形式をチェック ***
	const tInstR *ir = NULL;
	for (unsigned int i=0; i< ARRSIZE(InstR); i++) {
		if ( strcasecmp(InstR[i].mnemonic, mnemonic) == 0 ) {
			ir = &InstR[i];
			break;
		}
	}
	if ( ir ) {
		inst_t inst;
		char *op[3];
		int opcnt = opersplit(operand, op);
		if ( opcnt != (ir->opercnt + (ir->shift?1:0) ) ) {
			throw std::string("Operand count not match");
		}
		
		// オペランドのレジスタを読み取る
		short opn[4] = {0,0,0,0};
		for(int o=0; o< ir->opercnt; o++) {
			opn[o] = numreg(trim(op[o]));
		}
		short shift = 0;
		if ( ir->shift ) {
			long lshi = str2long(trim(op[ir->opercnt]));
			if ( lshi >= 32 ) {
				throw std::string("constant shift value too big");
			}
			shift = (short)lshi;
		}
		
		inst = (ir->opcode<<26)
		     | (opn[ ir->oporder[0] ]<<21)
		     | (opn[ ir->oporder[1] ]<<16)
		     | (opn[ ir->oporder[2] ]<<11)
		     | (shift<<6)
		     | ir->funct;
		printf("0x%x\n", inst);
		
		state->dest.push_back(inst);
		return;
	}
	
	
	// *** I形式をチェック ***
	
	dprintf("NOT\n");
}

// 一行をニーモニックとオペランドに分ける
void procline(char *str, tState *state) {
	
	char *sline = trim(str);
	//空行はさよなら
	if ( sline[0] == '\0' ) { return; }
	
	// ニーモニック部とその他に分ける
	char *sp = strchr(sline, ' ');
	char *ht = strchr(sline, '\t');
	
	char *split;
	if ( sp == NULL ) {
		split = ht;
	} else if ( ht == NULL ) {
		split = sp;
	} else {
		split = (sp<ht)? sp : ht ; //先に出た方
	}
	
	if ( split != NULL ) {
		*split = '\0';
		split++;
		split = trim(split);
	}
	
	proc(sline, split, state);
}


int main() {

	FILE *fp = fopen("test.s", "r");
	
	tState state;
	state.linenum = 0;
	
	char buf[BUFSIZE];
	while ( fgets(buf, BUFSIZE-10, fp) ) {
		state.linenum++;
		
		char *sline = trim(buf);
		
		// コメントを捨てる
		// TODO: 文字リテラル
		delafter(sline, ';');
		delafter(sline, '#');
		
		char *pos = sline;
		// ラベルで行を分ける
		while ( char *colon = strchr(pos, ':') ) {
			char tmp = *(colon+1);
			
			//次の文字を一時的にアレして投げる
			*(colon+1) = '\0';
			procline(pos, &state);
			*(colon+1) = tmp;
			
			pos = colon+1;
		}
		
		procline(pos, &state);

	}

}
