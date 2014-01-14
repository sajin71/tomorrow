#include "fadd.h"

/*
  rs: BitShift_R
    port map(frc_s,exp_gap,frc_ss);
  ls: BitShift_L1
    port map (frc2,shift(1 downto 0),frc_ans2);
  pr: zlc
    port map(frc_ans1,shift);
  ls2: BitShift_L2
      port map (frc_ans3,shift3(4 downto 2),tmp);
*/
fadd::fadd(uint32_t& a, uint32_t& b, uint32_t& q) : a(a), b(b), q(q)
						  , __tmp(shift.to_ulong() & 0x3)
						  , __tmp2((shift3.to_ulong()>>2) & 0x7)
						  , rs(frc_s, exp_gap, frc_ss)
						  , ls(frc2, __tmp, frc_ans2)
						  , pr(frc_ans1, shift)
						  , ls2(frc_ans3, __tmp2, tmp){
    exp_up2 = 0;
}
fadd::~fadd(){
}
void fadd::update(){
    __tmp = std::bitset<2>(shift.to_ulong() & 0x3);
    __tmp2 = std::bitset<3>((shift3.to_ulong()>>2) & 0x7);

    // メモ。プロセス文以外の部分は多分逐次処理としても問題ないんじゃないか。
    fin_a = a;
    fin_b = b;

    if((fin_a & 0x7fffffff) > (fin_b & 0x7fffffff)){
	cmp_abs = 0x0;
    }else if((fin_a & 0x7fffffff) == (fin_b & 0x7fffffff)){
	cmp_abs = 0x1;
    }else{
	cmp_abs = 0x2;
    }

    frc_a = fin_a << 3;
    frc_a[27] = 0;
    frc_a[26] = 1;

    frc_b = fin_b << 3;
    frc_a[27] = 0;
    frc_a[26] = 1;

    fin_l = (cmp_abs[1] == 0) ? fin_a : fin_b;
    fin_s = (cmp_abs[1] == 0) ? fin_b : fin_a;
    frc_l = (cmp_abs[1] == 0) ? frc_a : frc_b;
    frc_s = (cmp_abs[1] == 0) ? frc_b : frc_a;

    uint8_t _tmp1 = fin_l >> 23;//!< \todo 自信がない
    uint8_t _tmp2 = fin_s >> 23;
    exp_gap = _tmp1 - _tmp2;
    
    rs.update();

    exp_ans1 = fin_l >> 23;
    sgn_ans1 = std::bitset<32>(fin_l)[31];

    op = (std::bitset<32>(fin_l)[31] == std::bitset<32>(fin_s)[31]) ? 0 : 1;

    frc_ans1 = (op) ? frc_l2.to_ulong() + frc_s2.to_ulong() : frc_l2.to_ulong() - frc_s2.to_ulong();

    pr.update();

    bool flag = true;
    for(int i = 2; i <= 25; i++){
	if(!frc_ans1[i]){
	    flag = false;
	    break;
	}
    }
    if(flag && ((frc_ans[26] || frc_ans[1]) == 1)){
	exp_up2 = 1;
    }else{
	exp_up2 = 0;
    }

    bool _flag1 = true, _flag2 = true;
    for(int i = 1; i <= 26; i++){
	    if(!frc_ans1[i]){
		if(i == 1){
		    _flag2 = false;
		}else if(i == 26){
		    _flag1 = false;
		}else{
		    _flag1 = _flag2 = false;
		}
	    }
    }
    if(_flag1){
	frc2 = 0;
	frc2[27] = 1;
    }else if(_flag2){
	frc2 = 0;
	frc2[26] = 1;
    }else{
	frc2 = frc_ans1;
    }

    ls.update();

    rounding = frc_ans2[3] && (frc_ans2[4] || frc_ans2[2] || frc_ans2[1]);

    ls2.update();

    if(__tmp2.to_ulong() == 0){
	frc_ans = frc_ans3.to_ulong() + (rounding3 << 4);
    }else{
	frc_ans = tmp;
    }

    tmp2 = exp_ans3 + (exp_up3 << 1 + (!exp_up3)) - shift3.to_ulong();
    
    if(tmp2[8] == 1 || shift3.to_ulong() >= 0x1a || exp_ans3 == 0){
	ans_head = 0;
    }else{
	ans_head = tmp2;
	ans_head[8] = sgn_ans3;
    }

    q = frc_ans.to_ulong() >> 4;
    for(int i = 0; i < 9; i++){
	q |= (frc_ans[i] << (31-i));
    }
}
void fadd::clockUpdate(){
    update();
    {
	// stage1
	frc_l2 = frc_l;
	frc_s2 = frc_ss;
	exp_ans2 = exp_ans1;
	sgn_ans2 = sgn_ans1;
	op2 = op;
    }
    {
	// stage2
	exp_ans3 = exp_ans2;
	sgn_ans3 = sgn_ans2;
	rounding3 = rounding;
	frc_ans3 = frc_ans2;
	shift3 = shift;
	exp_up3 = exp_up2;
    }
    update();
}
    /*
    */

