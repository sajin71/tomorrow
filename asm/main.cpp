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
{ "SLLV",   0x18, 0x04, 3, {2,1,0}, false },
{ "SRLV",   0x18, 0x06, 3, {2,1,0}, false },
{ "SRAV",   0x18, 0x07, 3, {2,1,0}, false },

{ "JR",     0x1B, 0x00, 1, {0,3,3}, false },
{ "HALT",   0x3c, 0x00, 0, {3,3,3}, false },

// Tommorow legacy extension
{ "OUTPUT", 0x3f, 0x00, 1, {0,1,2} },
{ "INPUT",  0x3e, 0x00, 1, {0,1,2} },
};


struct tInstI {
public:
	enum EInstIType { T_Arith, T_Branch, T_Mem, T_MemCo, T_SetL, T_Set, T_SetLV, T_SetCLV};
	
	const char *mnemonic;
	unsigned char opcode;
	int opercnt; //オペランドで指定するレジスタの数
	EInstIType type; //即値の形式 0...ふつう 1...PC相対 2...メモリオフセット 3...メモリオフセット(fp)
	           //           4...SETL命令（絶対ポインタ） 5...SET命令（即値代入）
	int oporder[2]; //ふつう形式: 0...sに対応するのはアセンブラコードでいうと何番目？ 1...t  (2を指定すると0固定)
};
const unsigned char opcode_LUI = 0x0F;
const tInstI InstI[] = {
{ "ADDI",   0x08, 2, tInstI::T_Arith, {1,0}},
{ "ANDI",   0x0C, 2, tInstI::T_Arith, {1,0}},
{ "SLTI",   0x0A, 2, tInstI::T_Arith, {1,0}},
{ "ORI",    0x0D, 2, tInstI::T_Arith, {1,0}},
{ "LW",     0x23, 2, tInstI::T_Mem  , {}   },
{ "SW",     0x2B, 2, tInstI::T_Mem  , {}   },

{ "LWC",    0x31, 2, tInstI::T_MemCo, {}   },
{ "LWC1",   0x31, 2, tInstI::T_MemCo, {}   },
{ "SWC",    0x39, 2, tInstI::T_MemCo, {}   },
{ "SWC1",   0x39, 2, tInstI::T_MemCo, {}   },

{ "SETL",   0x0D, 1, tInstI::T_SetL , {}   }, //pseudo, load absolute address imm. expand 2-ops LUIを別途先に入れておく
{ "SET",    0x0D, 1, tInstI::T_Set  , {}   }, //pseudo, load 32bit imm. expand 2-ops LUIを別途先に入れておく
{ "SETLV",  0x23, 1, tInstI::T_SetLV, {}   }, //pseudo, LW from label(0x000-0x7fff)
{ "SETCLV", 0x31, 1, tInstI::T_SetCLV,{}   }, //pseudo, LWC1 from label (0x000-0x7fff)

{ "LLI",    0x0D, 1, tInstI::T_Arith, {2,0}}, //pseudo ORI
{ "LUI",    opcode_LUI, 1, tInstI::T_Arith, {2,0}},
{ "BEQ",    0x04, 2, tInstI::T_Branch, {0,1}},
{ "BNE",    0x05, 2, tInstI::T_Branch, {0,1}},
};


struct tInstJ {
	const char *mnemonic;
	unsigned char opcode;
};
const tInstJ InstJ[] = {
{ "J",      0x02},
{ "JAL",    0x03},
};


const unsigned char opcode_COP1 = 0x11;
struct tInstFPComp {
	const char *mnemonic;
	const char fmt;
	unsigned char cond;
};
const tInstFPComp InstFPComp[] = {
{ "C.UN.S",    0x10, 0x01},
{ "C.EQ.S",    0x10, 0x02},
{ "C.OLT.S",   0x10, 0x04},
};

struct tInstFPArith {
	const char *mnemonic;
	unsigned char fmt;
	unsigned char funct;
	int opercnt;
	int oporder[3]; //0...ftに対応するのはアセンブラコードでいうと何番目？ 1...fs 2...fd  (3を指定すると0固定)
};
const tInstFPArith InstFPArith[] = {
{ "ADD.S",    0x10, 0x00, 3, {2,1,0}},
{ "SUB.S",    0x10, 0x01, 3, {2,1,0}},
{ "MUL.S",    0x10, 0x02, 3, {2,1,0}},
{ "DIV.S",    0x10, 0x03, 3, {2,1,0}},
{ "SQRT.S",   0x10, 0x04, 2, {3,1,0}},
{ "ABS.S",    0x10, 0x05, 2, {3,1,0}},
{ "MOV.S",    0x10, 0x06, 2, {3,1,0}},
{ "NEG.S",    0x10, 0x07, 2, {3,1,0}},
{ "ROUND.W.S",0x10, 0x0C, 2, {3,1,0}},
{ "TRUNC.W.S",0x10, 0x0D, 2, {3,1,0}},
{ "CEIL.W.S" ,0x10, 0x0E, 2, {3,1,0}},
{ "FLOOR.W.S",0x10, 0x0F, 2, {3,1,0}},
{ "RECIP.S",  0x10, 0x15, 2, {3,1,0}},

{ "_SIN.S",  0x10, 0x16, 2, {3,1,0}},
{ "_COS.S",  0x10, 0x17, 2, {3,1,0}},
{ "_ATAN.S",  0x10, 0x18, 2, {3,1,0}},


{ "CVT.S.W",  0x14, 0x20, 2, {3,1,0}},
};


// ラベルが使用されているところの情報
struct tLabelPoint {
public:
	enum ElabelType { T_Branch, T_Jump, T_AddrUpp, T_AddrLow, T_AddrZero };
	unsigned int pnum;
	std::string label;
	ElabelType type; //0...I 1...J 2...即値上位 3...即値下位 4...$0+disp
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
const char *fregname[32][1] = {
{ "f0"}, { "f1"}, { "f2"}, { "f3"}, { "f4"}, { "f5"}, { "f6"}, { "f7"},
{ "f8"}, { "f9"}, {"f10"}, {"f11"}, {"f12"}, {"f13"}, {"f14"}, {"f15"},
{"f16"}, {"f17"}, {"f18"}, {"f19"}, {"f20"}, {"f21"}, {"f22"}, {"f23"},
{"f24"}, {"f25"}, {"f26"}, {"f27"}, {"f28"}, {"f29"}, {"f30"}, {"f31"}
};

// 整数レジスタ名をレジスタ番号に変換する
short numreg(char* op) {
	op++;
	if ( op[-1] == '$' ) {
		
		for(int i=0; i<32; i++) {
			if ( strcasecmp(nregname[i][0], op) == 0 ||
			     strcasecmp(nregname[i][1], op) == 0 ) {
				return i;
			}
		}
	}
	
	throw std::string("Invalid int register operand `") + std::string(--op) + std::string("'");
}
// 浮動小数点レジスタ名をレジスタ番号に変換する
short numfreg(char* op) {
	op++;
	if ( op[-1] == '$' ) {
		
		for(int i=0; i<32; i++) {
			if ( strcasecmp(fregname[i][0], op) == 0 ) {
				return i;
			}
		}
	}
	
	throw std::string("Invalid fp register operand `") + std::string(--op) + std::string("'");
}

short str2cc(char* op) {
	if( op[1] != '\0' || op[0] < '0' || op[0] > '7' ) {
		throw std::string("Invalid condition register operand `") + std::string(op) + std::string("'");
	}
	
	return op[0] - '0';
}


// 文字列を整数に変換
long str2long(char* op) {
	
	char *endptr = NULL;
	long ret = strtol(op, &endptr, 0);
	if ( op[0] == '\0' || *endptr != '\0' ) {
		throw std::string("Invalid numeric constant `") + std::string(op) + std::string("'");
	}
	
	return ret;
}
unsigned long str2ulong(char* op) {
	
	char *endptr = NULL;
	unsigned long ret = strtoul(op, &endptr, 0);
	if ( op[0] == '\0' || *endptr != '\0' ) {
		throw std::string("Invalid numeric constant `") + std::string(op) + std::string("'");
	}
	
	return ret;
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



// **** 処理関数たち **** //

bool proc_dot(char* mnemonic, char** op, int opcnt, tState *state) {
	if ( strcasecmp(".long", mnemonic) == 0 ) {
		if ( opcnt != 1 ) {
			throw std::string("Operand count not match");
		}
		inst_t data = (inst_t)str2ulong(trim(op[0]));
		state->dest.push_back(data);
		return true;
	} else if ( strcasecmp(".skip", mnemonic) == 0 ) {
		if ( opcnt != 1 ) {
			throw std::string("Operand count not match");
		}
		long size = str2long(trim(op[0]));
		if ( size%4 != 0 ) {
			throw std::string(".skip must be multiples of 4");
		}
		
		for(int skcnt=0; skcnt<(size/4); skcnt++) {
			state->dest.push_back(0x00000000);
		}
		
		return true;
		
	} else {
		//TODO 今のところlong以外は放置
		return true;
	}
}

bool proc_instR(char* mnemonic, char** op, int opcnt, tState *state) {

	const tInstR *ir = NULL;
	for (unsigned int i=0; i< ARRSIZE(InstR); i++) {
		if ( strcasecmp(InstR[i].mnemonic, mnemonic) == 0 ) {
			ir = &InstR[i];
			break;
		}
	}
	
	if ( !ir ) {
		return false;
	}
	
	
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
	
	return true;
}


bool proc_instI(char* mnemonic, char** op, int opcnt, tState *state) {
	const tInstI *ii = NULL;
	for (unsigned int i=0; i< ARRSIZE(InstI); i++) {
		if ( strcasecmp(InstI[i].mnemonic, mnemonic) == 0 ) {
			ii = &InstI[i];
			break;
		}
	}
	
	if ( !ii ) {
		return false;
	}
	
	
	char rs, rt;
	imm_t con; //16bit
	
	
	if ( ii->type == tInstI::T_Arith || ii->type == tInstI::T_Branch ) {
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
		
		if ( ii->type == tInstI::T_Arith ) {
			// 定数を読み取る
			con = (imm_t)str2long(opcon);
		} else {
			if ( is_labelhead(opcon[0]) ) {
				con = 0;
				// ラベル位置を登録
				tLabelPoint tlp;
				tlp.pnum = state->getPnum();
				tlp.label = std::string(opcon);
				tlp.type = tLabelPoint::T_Branch;
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
	} else if ( ii->type == tInstI::T_Mem || ii->type == tInstI::T_MemCo ) {
	// メモリアドレスのオフセットを指定してるやつ
		
		if ( opcnt != ii->opercnt ) {
			throw std::string("Operand count not match");
		}
		
		if ( ii->type == tInstI::T_Mem ) { //整数
			rt = numreg(trim(op[0]));
		} else { //浮動小数点数
			rt = numfreg(trim(op[0]));
		}
		
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
	} else if ( ii->type == tInstI::T_SetL ) {
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
		tlpup.type = tLabelPoint::T_AddrUpp;
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
		tlp.type = tLabelPoint::T_AddrLow;
		tlp.linenum = state->linenum;
		
		state->lplaces.push_back(tlp);
	} else if ( ii->type == tInstI::T_Set ) {
	// 特殊処理
	// 32ビットの即値を2命令で代入する
		if ( opcnt != (ii->opercnt+1) ) {
			throw std::string("Operand count not match");
		}
		rs = 0;
		rt = numreg(trim(op[0]));
		
		char *opcon = trim(op[ii->opercnt]);
		long longimm = str2long(opcon);
		
		imm_t upimm = (imm_t)((longimm>>16) & 0xFFFF);
		
		if ( upimm != 0 ) {
			// 命令を組み立てて追加（上位）LUIを入れちゃう
			inst_t inst;
			inst = (opcode_LUI<<26)
			     | (rs<<21)
			     | (rt<<16)
			     | (upimm & 0xFFFF);
			dprintf("0x%x\n", inst);
		
			state->dest.push_back(inst);
			
			// ORI $rs, $rs, [下位] で下位を入れる
			rs = rt;
		}
		
		con = (imm_t)(longimm&0xFFFF);
	} else if ( ii->type == tInstI::T_SetLV || ii->type == tInstI::T_SetCLV ) {
		
		if ( opcnt != (ii->opercnt+1) ) {
			throw std::string("Operand count not match");
		}
		
		if ( ii->type == tInstI::T_SetLV ) { //整数
			rt = numreg(trim(op[0]));
		} else { //浮動小数点数
			rt = numfreg(trim(op[0]));
		}
		rs = 0; //zero register
		con = 0;
		
		char *opcon = trim(op[ii->opercnt]);
		if ( !is_labelhead(opcon[0]) ) {
			throw std::string("Invalid label identifier `") + std::string(opcon) + std::string("'");
		}
		
		
		// ラベル位置を登録
		tLabelPoint tlp;
		tlp.pnum = state->getPnum();
		tlp.label = std::string(opcon);
		tlp.type = tLabelPoint::T_AddrZero;
		tlp.linenum = state->linenum;
		
		state->lplaces.push_back(tlp);
		
	} else {
		throw std::string("(internal) Unknown InstI type");
	}
	
	
	// 命令を組み立てて追加
	inst_t inst;
	inst = (ii->opcode<<26)
	     | (rs<<21)
	     | (rt<<16)
	     | (con & 0xFFFF);
	dprintf("0x%x\n", inst);
	
	state->dest.push_back(inst);
	return true;
}


bool proc_instJ(char* mnemonic, char** op, int opcnt, tState *state) {
	const tInstJ *ij = NULL;
	for (unsigned int i=0; i< ARRSIZE(InstJ); i++) {
		if ( strcasecmp(InstJ[i].mnemonic, mnemonic) == 0 ) {
			ij = &InstJ[i];
			break;
		}
	}
	if ( !ij ) {
		return false;
	}
	
	
	if ( opcnt != 1 ) {
		throw std::string("Operand count not match");
	}
	
	unsigned long con;
	
	char *opcon = trim(op[0]);
	if ( is_labelhead(opcon[0]) ) {
		con = 0;
		// ラベル位置を登録
		tLabelPoint tlp;
		tlp.pnum = state->getPnum();
		tlp.label = std::string(opcon);
		tlp.type = tLabelPoint::T_Jump;
		tlp.linenum = state->linenum;
		
		state->lplaces.push_back(tlp);
	} else {
		unsigned long lc = str2ulong(opcon);
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
	
	return true;
}



bool proc_instFP(char* mnemonic, char** op, int opcnt, tState *state) {
	
	unsigned char fmt;
	unsigned char ft;
	unsigned char fs;
	unsigned char fd;
	unsigned char tail;
	
	do {
		bool isMFC = ( strcasecmp("MFC", mnemonic) == 0 || strcasecmp("MFC1", mnemonic) == 0 );
		bool isMTC = ( strcasecmp("MTC", mnemonic) == 0 || strcasecmp("MTC1", mnemonic) == 0 );
		if ( isMFC || isMTC ) {
			if(isMFC) { fmt = 0; /*MF*/ }
			else      { fmt = 4; /*MT*/ }
			
			if ( opcnt != 2 ) {
				throw std::string("Operand count not match");
			}
			
			ft = numreg(trim(op[0]));  //整数レジスタ
			fs = numfreg(trim(op[1])); //浮動小数点レジスタ
			
			fd = 0;
			tail = 0;
			
			break; //break do-while
		}
		
		
		bool isBCF = ( strcasecmp("BCF", mnemonic) == 0 || strcasecmp("BC1F", mnemonic) == 0 );
		bool isBCT = ( strcasecmp("BCT", mnemonic) == 0 || strcasecmp("BC1T", mnemonic) == 0 );
		if ( isBCF || isBCT ) {
			fmt = 8; //BC
			
			char *opcon;
			if ( opcnt == 2 ) {
				opcon = trim(op[1]);
				ft = str2cc(trim(op[0])) <<2;
			} else if ( opcnt == 1 ) {
				opcon = trim(op[0]);
				ft = 0;
			} else {
				throw std::string("Operand count not match");
			}
			
			
			if(isBCT) { ft |= 0x1; }
			
			// ブランチ先
			if ( is_labelhead(opcon[0]) ) {
				
				// ラベル位置を登録
				tLabelPoint tlp;
				tlp.pnum = state->getPnum();
				tlp.label = std::string(opcon);
				tlp.type = tLabelPoint::T_Branch;
				tlp.linenum = state->linenum;
				
				state->lplaces.push_back(tlp);
				
				fs = 0;
				fd = 0;
				tail = 0;
			} else {
				long lc = str2long(opcon);
				if ( lc%4 != 0 ) {
					throw std::string("branch address must be multiples of 4");
				}
				imm_t con = (imm_t)(lc/4);
				
				fs = (con >>11) & 0x1f;
				fd = (con >> 6) & 0x1f;
				tail = con & 0x3f;
			}
			
			break; //break do-while
		}
		
		
		// 比較命令
		const tInstFPComp *co = NULL;
		for (unsigned int i=0; i< ARRSIZE(InstFPComp); i++) {
			if ( strcasecmp(InstFPComp[i].mnemonic, mnemonic) == 0 ) {
				co = &InstFPComp[i];
				break;
			}
		}
		if ( co != NULL ) {
			
			if ( opcnt == 3 ) {
				ft = numfreg(trim(op[2]));
				fs = numfreg(trim(op[1]));
				fd = str2cc(trim(op[0])) <<2;
			} else if ( opcnt == 2 ) {
				ft = numfreg(trim(op[1]));
				fs = numfreg(trim(op[0]));
				fd = 0;
			} else {
				throw std::string("Operand count not match");
			}
			
			fmt = co->fmt;
			tail = 0x30 | co->cond;
			break; //break do-while
		}
		
		
		// 算術系
		const tInstFPArith *ar = NULL;
		for (unsigned int i=0; i< ARRSIZE(InstFPArith); i++) {
			if ( strcasecmp(InstFPArith[i].mnemonic, mnemonic) == 0 ) {
				ar = &InstFPArith[i];
				break;
			}
		}
		if ( ar != NULL ) {
			if ( opcnt != ar->opercnt ) {
				throw std::string("Operand count not match");
			}
			// オペランドのレジスタを読み取る
			short opn[3+1] = {0,0,0,0};
			for(int o=0; o< ar->opercnt; o++) {
				opn[o] = numfreg(trim(op[o]));
			}
			
			fmt = ar->fmt;
			ft = opn[ ar->oporder[0] ];
			fs = opn[ ar->oporder[1] ];
			fd = opn[ ar->oporder[2] ];
			tail = ar->funct;
			
			break; //break do-while
		}
		
		
		// 該当する命令がなかった
		return false;
		
	} while(false);
	
	
	// 命令を組み立てて追加
	inst_t inst;
	inst = (opcode_COP1<<26)
	     | (fmt<<21)
	     | (ft<<16)
	     | (fs<<11)
	     | (fd<<6)
	     | (tail & 0x3f);
	dprintf("0x%x\n", inst);
	
	state->dest.push_back(inst);
	
	return true;
}



// operandはNULLかも
void proc(char* mnemonic, char* operand, tState *state) {
	
	char *end = &mnemonic[ strlen(mnemonic) -1];
	if ( *end == ':' ) {
		//ラベルだ
		*end = '\0';
		char *label = trim(mnemonic);
		
		if ( label[0] == '\0' ) {
			throw std::string("Unexpected label delimiter `:'");
		}
		if ( !is_labelhead(label[0]) ) {
			throw std::string("Invalid label name `") + label + std::string("'");
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
	
	// TODO: なんか制御とかするんだろうけど
	// .longだけ処理する
	if ( mnemonic[0] == '.' ) {
		if ( proc_dot(mnemonic, op, opcnt, state) ) {
			return;
		}
	}
	
	// *** R形式をチェック ***
	if ( proc_instR(mnemonic, op, opcnt, state) ) {
		return;
	}
	
	
	// *** I形式をチェック ***
	if ( proc_instI(mnemonic, op, opcnt, state) ) {
		return;
	}
	
	
	// *** J形式をチェック ***
	if ( proc_instJ(mnemonic, op, opcnt, state) ) {
		return;
	}
	
	// *** 浮動小数点命令をチェック ***
	if ( proc_instFP(mnemonic, op, opcnt, state) ) {
		return;
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
	}
	if ( argc >= 2 ) {
		ifp = fopen(argv[1], "r");
		if ( ifp == NULL ) {
			fprintf(stderr, "input error\n");
			return 1;
		}
	}
	/* else {
		fprintf(stderr, "Usage: %s [input asm [output bin]]\n", argv[0]);
		return 1;
	}
	*/
	
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
			
			if ( state.lplaces[i].type == tLabelPoint::T_Branch ) {
			// I形式 branch (PC相対)
				int c = to - from;
				if ( c < -32768 || 32767 < c ) {
					throw std::string("branch too far");
				}
				
				state.dest [ state.lplaces[i].pnum ] |= (c & 0xFFFF);
			} else if ( state.lplaces[i].type == tLabelPoint::T_Jump ) {
			// J形式 jump
				if ( (from&0xFC000000) != (to&0xFC000000) ) {
					throw std::string("jump different segment");
				}
				state.dest [ state.lplaces[i].pnum ] |= (to & 0x3FFFFFF);
			} else if ( state.lplaces[i].type == tLabelPoint::T_AddrUpp ) {
			// 絶対アドレス（上位）
				int c = to*4;
				state.dest [ state.lplaces[i].pnum ] |= ((c>>16) & 0xFFFF);
			} else if ( state.lplaces[i].type == tLabelPoint::T_AddrLow ) {
			// 絶対アドレス（下位）
				int c = to*4;
				state.dest [ state.lplaces[i].pnum ] |= (c & 0xFFFF);
			} else if ( state.lplaces[i].type == tLabelPoint::T_AddrZero ) {
			// $0+disp形式（基本的にはT_AddrLowと同じ）
				int c = to*4;
				if ( c > 0x7FFF ) {
					throw std::string("SETLV label must be placed to 0x0000-0x7fff");
				}
				state.dest [ state.lplaces[i].pnum ] |= (c & 0xFFFF);
			} else {
				throw std::string("(internal) Unexpected label type");
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
