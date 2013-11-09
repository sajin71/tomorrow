#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <iostream>
#include <vector>
#include <map>
#include <string>

#define BUFSIZE 2048
#define ARRSIZE(x) (sizeof(x) / sizeof(x[0]))

//#define dprintf printf
int dprintf(...) { return 0; }

typedef uint32_t inst_t;
typedef uint32_t addr_t;
typedef int16_t imm_t;

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
{ "SLT",    0x00, 0x2A, 3, {1,2,0}, false },
{ "MULT",   0x00, 0x18, 2, {0,1,3}, false },
{ "DIV",    0x00, 0x1A, 2, {0,1,3}, false },
{ "MFHI",   0x00, 0x10, 1, {3,3,0}, false },
{ "MFLO",   0x00, 0x12, 1, {3,3,0}, false },

{ "MOV" ,   0x00, 0x20, 2, {1,3,0}, false }, //pseudo
{ "MOVE",   0x00, 0x20, 2, {1,3,0}, false }, //pseudo

{ "NOP",    0x00, 0x00, 0, {3,3,3}, false },
{ "SLL",    0x18, 0x00, 2, {3,1,0}, true },
{ "SRL",    0x18, 0x02, 2, {3,1,0}, true },
{ "SRA",    0x18, 0x03, 2, {3,1,0}, true },

{ "JR",     0x1B, 0x00, 1, {0,3,3}, false },
{ "HALT",   0x3c, 0x00, 0, {3,3,3}, false },

// Tommorow extension
{ "OUTPUT", 0x3f, 0x00, 1, {0,1,2} },
{ "INPUT",  0x3e, 0x00, 1, {0,1,2} },
};


struct tInstI {
	const char *mnemonic;
	unsigned char opcode;
	int opercnt; //オペランドで指定するレジスタの数
	char type; //即値の形式 0...ふつう 1...PC相対 2...メモリオフセット 3...SET命令（絶対ポインタ）
	int oporder[2]; //ふつう形式: 0...sに対応するのはアセンブラコードでいうと何番目？ 1...t  (2を指定すると0固定)
};
const unsigned char opcode_LUI = 0x0F;
const tInstI InstI[] = {
{ "ADDI",   0x08, 2, 0, {1,0}},
{ "ANDI",   0x0C, 2, 0, {1,0}},
{ "SLTI",   0x0A, 2, 0, {1,0}},
{ "ORI",    0x0D, 2, 0, {1,0}},
{ "LW",     0x23, 2, 2, {}   },
{ "SW",     0x2B, 2, 2, {}   },
{ "SET",    0x0D, 1, 3, {}   }, //pseudo, load absolute address imm. expand 2-ops LUIを別途先に入れておく
{ "LLI",    0x0D, 1, 0, {2,0}}, //pseudo ORI
{ "LUI",    opcode_LUI, 1, 0, {2,0}},
{ "BEQ",    0x04, 2, 1, {0,1}},
{ "BNE",    0x05, 2, 1, {0,1}},
};


struct tInstJ {
	const char *mnemonic;
	unsigned char opcode;
};
const tInstJ InstJ[] = {
{ "J",      0x02},
{ "JAL",    0x03},
};


// ラベルが使用されているところの情報
struct tLabelPoint {
	unsigned int pnum;
	std::string label;
	char type; //0...I 1...J 2...即値上位 3...即値下位
	int linenum;
};

// グローバル変数的なひとたち
struct tState {
	int linenum;
	std::vector<inst_t> dest;
	std::vector<std::string> nextlabels;
	
	std::map<std::string, int> labels;
	std::vector<tLabelPoint> lplaces;
	
	unsigned int getPnum() {
		return this->dest.size();
	}
};

bool is_blank(char c) {
	return (c==' ') || (c=='\t') || (c=='\r') || (c=='\n');
}
bool is_labelhead(char c) {
	return (c=='_') || ('a'<=c&&c<='z') || ('A'<=c&&c<='Z');
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
		tail--;
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

// 文字列を整数に変換
long str2long(char* op) {
	
	char *endptr = NULL;
	long ret = strtol(op, &endptr, 0);
	if ( op[0] == '\0' || *endptr != '\0' ) {
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
	
	throw std::string("Invalid register operand `") + std::string(op) + std::string("'");
}


// オペランドを切り分ける
// 返り値: オペランドの数
int opersplit(char *operand, char *op[3]) {
	
	if ( operand == NULL || operand[0] == '\0' ) {
		return 0;
	}
	
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
		if ( !is_labelhead(label[0]) ) {
			throw std::string("Invalid label name");
		}
		
		if ( state->labels.find(label) != state->labels.end() ) {
			throw std::string("label `") + label + std::string("' has previous declaration");
		}
		
		state->nextlabels.push_back( std::string(label) );
		
		dprintf("LABEL %s\n", label);
		return;
	}
	
	dprintf("%s\n", mnemonic);
	
	// ラベルを登録する
	if ( !state->nextlabels.empty() ) {
		for(unsigned int i=0; i < state->nextlabels.size(); i++ ) {
			state->labels.insert( std::map<std::string, int>::value_type( state->nextlabels[i], state->getPnum() ) );
		}
		state->nextlabels.clear();
	}
	
	
	// オペランドを分解
	char *op[3];
	int opcnt = opersplit(operand, op);
	
	// *** R形式をチェック ***
	{
	const tInstR *ir = NULL;
		for (unsigned int i=0; i< ARRSIZE(InstR); i++) {
			if ( strcasecmp(InstR[i].mnemonic, mnemonic) == 0 ) {
				ir = &InstR[i];
				break;
			}
		}
		if ( ir ) {
			if ( opcnt != (ir->opercnt + (ir->shift?1:0) ) ) {
				throw std::string("Operand count not match");
			}
			
			// オペランドのレジスタを読み取る
			short opn[3+1] = {0,0,0,0};
			for(int o=0; o< ir->opercnt; o++) {
				opn[o] = numreg(trim(op[o]));
			}
			// シフト数
			short shift = 0;
			if ( ir->shift ) {
				long lshi = str2long(trim(op[ir->opercnt]));
				if ( lshi >= 32 || lshi<0 ) {
					throw std::string("constant shift value is out of range");
				}
				shift = (short)lshi;
			}
			
			
			// 命令を組み立てて追加
			inst_t inst;
			inst = (ir->opcode<<26)
			     | (opn[ ir->oporder[0] ]<<21)
			     | (opn[ ir->oporder[1] ]<<16)
			     | (opn[ ir->oporder[2] ]<<11)
			     | (shift<<6)
			     | ir->funct;
			dprintf("0x%x\n", inst);
			
			state->dest.push_back(inst);
			return;
		}
	}
	
	
	// *** I形式をチェック ***
	{
		const tInstI *ii = NULL;
		for (unsigned int i=0; i< ARRSIZE(InstI); i++) {
			if ( strcasecmp(InstI[i].mnemonic, mnemonic) == 0 ) {
				ii = &InstI[i];
				break;
			}
		}
		if ( ii ) {
			char rs, rt;
			imm_t con; //16bit
			
			
			if ( ii->type == 2 ) {
			// メモリアドレスのオフセットを指定してるやつ
				rt = numreg(trim(op[0]));
				
				// かっこをほぐす
				char *kakko1 = strchr(op[1], '(');
				if ( kakko1 == NULL ) {
					throw std::string("Unknown addressing operand. `(' not found");
				}
				*kakko1 = '\0';
				
				char *kreg = kakko1+1;
				char *kakko2 = strchr(kreg, ')');
				if ( kakko2 == NULL ) {
					throw std::string("Unknown addressing operand. `)' not found");
				}
				*kakko2 = '\0';
				if ( *(kakko2+1) != '\0' ) {
					throw std::string("Unexpected string `") + std::string(kakko2+1) + std::string("'");
				}
				
				con = (imm_t)str2long(trim(op[1]));
				rs = numreg(trim(kreg));
			} else if ( ii->type == 3 ) {
			// 特殊処理
			// ラベルによってその位置のアドレス自体を即値代入する
				if ( opcnt != (ii->opercnt+1) ) {
					throw std::string("Operand count not match");
				}
				rs = 0;
				rt = numreg(trim(op[0]));
				con = 0;
				
				char *opcon = trim(op[ii->opercnt]);
				if ( !is_labelhead(opcon[0]) ) {
					throw std::string("Invalid label identifier `") + std::string(opcon) + std::string("'");
				}
				
				// ラベル位置を登録（上位）
				tLabelPoint tlpup;
				tlpup.pnum = state->getPnum();
				tlpup.label = std::string(opcon);
				tlpup.type = 2;
				tlpup.linenum = state->linenum;
				
				state->lplaces.push_back(tlpup);
				
				
				// 命令を組み立てて追加（上位）LUIを入れちゃう
				inst_t inst;
				inst = (opcode_LUI<<26)
				     | (rs<<21)
				     | (rt<<16)
				     | (con & 0xFFFF);
				dprintf("0x%x\n", inst);
			
				state->dest.push_back(inst);
				
				
				
				// ラベル位置を登録（下位）
				tLabelPoint tlp;
				tlp.pnum = state->getPnum();
				tlp.label = std::string(opcon);
				tlp.type = 3;
				tlp.linenum = state->linenum;
				
				state->lplaces.push_back(tlp);
				
			} else {
			// 0...最後のオペランドが定数になってるふつう形式
			// 1...PC相対（ラベルかも？）
				
				if ( opcnt != (ii->opercnt+1) ) {
					throw std::string("Operand count not match");
				}
				// オペランドのレジスタを読み取る
				short opn[2+1] = {0,0,0};
				for(int o=0; o< ii->opercnt; o++) {
					opn[o] = numreg(trim(op[o]));
				}
				rs = opn[ ii->oporder[0] ];
				rt = opn[ ii->oporder[1] ];
				
				char *opcon = trim(op[ii->opercnt]);
				
				if ( ii->type == 0 ) {
					// 定数を読み取る
					con = (imm_t)str2long(opcon);
				} else {
					if ( is_labelhead(opcon[0]) ) {
						con = 0;
						// ラベル位置を登録
						tLabelPoint tlp;
						tlp.pnum = state->getPnum();
						tlp.label = std::string(opcon);
						tlp.type = 0;
						tlp.linenum = state->linenum;
						
						state->lplaces.push_back(tlp);
					} else {
						long lc = str2long(opcon);
						if ( lc%4 != 0 ) {
							throw std::string("branch address must be multiples of 4");
						}
						con = (imm_t)(lc/4);
					}
				}
			}
			
			// 命令を組み立てて追加
			inst_t inst;
			inst = (ii->opcode<<26)
			     | (rs<<21)
			     | (rt<<16)
			     | (con & 0xFFFF);
			dprintf("0x%x\n", inst);
			
			state->dest.push_back(inst);
			return;
		}
	}
	
	
	// *** J形式をチェック ***
	{
		const tInstJ *ij = NULL;
		for (unsigned int i=0; i< ARRSIZE(InstJ); i++) {
			if ( strcasecmp(InstJ[i].mnemonic, mnemonic) == 0 ) {
				ij = &InstJ[i];
				break;
			}
		}
		if ( ij ) {
			if ( opcnt != 1 ) {
				throw std::string("Operand count not match");
			}
			
			long con;
			
			char *opcon = trim(op[0]);
			if ( is_labelhead(opcon[0]) ) {
				con = 0;
				// ラベル位置を登録
				tLabelPoint tlp;
				tlp.pnum = state->getPnum();
				tlp.label = std::string(opcon);
				tlp.type = 1;
				tlp.linenum = state->linenum;
				
				state->lplaces.push_back(tlp);
			} else {
				long lc = str2long(opcon);
				if ( lc%4 != 0 ) {
					throw std::string("jump address must be multiples of 4");
				}
				con = lc/4;
			}
			
			// 命令を組み立てて追加
			inst_t inst;
			inst = (ij->opcode<<26)
			     | (con & 0x3FFFFFF);
			dprintf("0x%x\n", inst);
			
			state->dest.push_back(inst);
			return;
		}
	}
	
	throw std::string("Unknown mnemonic `") + std::string(mnemonic) + std::string("'");
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


int main(int argc, char *argv[]) {
	
	const char *outfile = "a.bin";
	FILE *ifp = stdin;
	
	if ( argc == 3 ) {
		outfile = argv[2];
	} else if ( argc == 2 ) {
	} else if ( argc == 1 ) {
		
		ifp = fopen(argv[1], "r");
		if ( ifp == NULL ) {
			fprintf(stderr, "input error\n");
			return 1;
		}
		
	} else {
		fprintf(stderr, "Usage: %s [input asm [output bin]]\n", argv[0]);
		return 1;
	}
	
	tState state;
	state.linenum = 0;
	
	char buf[BUFSIZE];
	while ( fgets(buf, BUFSIZE-10, ifp) ) {
		state.linenum++;
		
		try { 
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
		} catch ( std::string excepstr ) {
			std::cerr << "Error line " << state.linenum << ": " << excepstr << std::endl;
			fclose(ifp);
			return 1;
		}
	}
	
	if ( ifp != stdin ) {
		fclose(ifp);
	}
	
	
	// ラベルの解決
	for(unsigned int i=0; i<state.lplaces.size(); i++) {
		std::map<std::string, int>::iterator it = state.labels.find( state.lplaces[i].label );
		
		try {
			if ( it == state.labels.end() ) {
				throw std::string("not found");
			}
			
			unsigned int from = state.lplaces[i].pnum + 1;
			unsigned int to   = (*it).second;
			
			if ( state.lplaces[i].type == 0 ) {
			// I形式 branch (PC相対)
				int c = to - from;
				if ( c < -32768 || 32767 < c ) {
					throw std::string("branch too far");
				}
				
				state.dest [ state.lplaces[i].pnum ] |= (c & 0xFFFF);
			} else if ( state.lplaces[i].type == 1 ) {
			// J形式 jump
				if ( (from&0xFC000000) != (to&0xFC000000) ) {
					throw std::string("jump different segment");
				}
				state.dest [ state.lplaces[i].pnum ] |= (to & 0x3FFFFFF);
			} else if ( state.lplaces[i].type == 2 ) {
			// 絶対アドレス（上位）
				int c = to*4;
				state.dest [ state.lplaces[i].pnum ] |= ((c>>16) & 0xFFFF);
			} else if ( state.lplaces[i].type == 3 ) {
			// 絶対アドレス（下位）
				int c = to*4;
				state.dest [ state.lplaces[i].pnum ] |= (c & 0xFFFF);
			} else {
				throw std::string("Unexpected label type");
			}
			
			
			
		} catch ( std::string excepstr ) {
			std::cerr << "Label Error line " << state.lplaces[i].linenum << " label `" << state.lplaces[i].label << "': " << excepstr << std::endl;
			return 1;
		}
	}
	
	
	FILE *ofp = fopen(outfile, "wb");
	if ( ofp == NULL ) {
		fprintf(stderr, "output error\n");
		return -1;
	}
	
	for(unsigned int i=0; i<state.dest.size(); i++) {
		union {
			inst_t inst;
			unsigned char b[4];
		} b;
		
		b.inst = state.dest[i];
		fwrite(&b.b[3], 1, 1, ofp);
		fwrite(&b.b[2], 1, 1, ofp);
		fwrite(&b.b[1], 1, 1, ofp);
		fwrite(&b.b[0], 1, 1, ofp);
	}
	fclose(ofp);
	
	return 0;

}
