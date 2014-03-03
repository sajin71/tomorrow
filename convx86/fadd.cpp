#include "fadd.h"
uint32_t fadd(const uint32_t a, const uint32_t b){
    using namespace std;
    bitset<2> cmp_abs;
    uint32_t fin_a, fin_b, fin_l, fin_s;
    bitset<28> frc_a, frc_b, frc_l, frc_s, frc_ss;
    uint8_t exp_ans1, exp_gap;
    bool sgn_ans1;
    bool op;

    bitset<28> frc_l2, frc_s2;
    uint8_t exp_ans2;
    bool sgn_ans2, op2;
    bitset<28> frc_ans1, frc_ans2, frc2;
    bitset<5> shift;
    bool rounding;
    bool exp_up2 = 0;

    uint8_t exp_ans3, exp_ans;
    bool sgn_ans3;
    bitset<9> ans_head;
    bool rounding3;
    bitset<28> frc_ans, frc_ans3;
    bool exp_up3;
    bitset<5> shift3;
    bitset<28> tmp;
    bitset<9> tmp2;
    { 
	//stage 1
	fin_a = a;
	fin_b = b;

	cmp_abs = ((fin_a & 0x7fffffff) > (fin_b & 0x7fffffff)) ? 0 : ((fin_a&0x7fffffff) == (fin_b&0x7fffffff)) ? 1 : 2;

	frc_a = fin_a << 3; frc_a[27] = 0; frc_a[26] = 1;
	frc_b = fin_b << 3; frc_b[27] = 0; frc_b[26] = 1;

	fin_l = (cmp_abs[1] == 0) ? fin_a : fin_b;
	fin_s = (cmp_abs[1] == 0) ? fin_b : fin_a;
	frc_l = (cmp_abs[1] == 0) ? frc_a : frc_b;
	frc_s = (cmp_abs[1] == 0) ? frc_b : frc_a;

	exp_gap = ((fin_l>>23)&0xff) - ((fin_s>>23)&0xff);
	BitShift_R rs(frc_s, exp_gap, frc_ss);
	rs.update();
	
	exp_ans1 = (fin_l >> 23)&0xff;
	sgn_ans1 = std::bitset<32>(fin_l)[31];

	op = (std::bitset<32>(fin_l)[31] == std::bitset<32>(fin_s)[31]) ? 0 : 1;

	frc_l2 = frc_l;
	frc_s2 = frc_ss;
	exp_ans2 = exp_ans1;
	sgn_ans2 = sgn_ans1;
	op2 = op;
    }

    {
	frc_ans1 = (op2 == 0) ? frc_l2.to_ulong()+frc_s2.to_ulong() : frc_l2.to_ulong()- frc_s2.to_ulong();
	
	zlc(frc_ans1, shift).update();
	
	bool flag = true;
	for(int i = 2; i <= 25; i++){
	    if(frc_ans1[i] == 0) flag = false;
	}
	if(flag && (frc_ans1[26] || frc_ans1[1]) == 1) exp_up2 = 1;
	else exp_up2 = 0;
	
	flag = true;
	for(int i = 2; i <= 26; i++){
	    if(frc_ans1[i] == 0) flag = false;
	}
	if(flag){
	    frc2 = 0;
	    frc2[27] = 1;
	}else{
	    flag = true;
	    for(int i = 0; i <= 25; i++){
		if(frc_ans1[i] == 0) flag = false;
	    }
	    if(flag){
		frc2 = 0;
		frc2[26] = 1;
	    }else{
		frc2 = frc_ans1;
	    }
	}

	bitset<2> t(shift.to_ulong());
	BitShift_L1(frc2, t, frc_ans2).update();
	
	rounding = frc_ans2[3] && (frc_ans2[4] || frc_ans2[2] || frc_ans2[1]);

	exp_ans3 = exp_ans2;
	sgn_ans3 = sgn_ans2;
	rounding3 = rounding;
	frc_ans3 = frc_ans2;
	shift3 = shift;
	exp_up3 = exp_up2;
	rounding3 = rounding;
    }

    {
	bitset<3> t(shift3.to_ulong()>>2);
	BitShift_L2(frc_ans3, t, tmp).update();
	
	frc_ans = (t == 0) ? frc_ans3.to_ulong() + (rounding3 << 4) : tmp;
	
	tmp2 = exp_ans3 + ((exp_up3 << 1) + (!exp_up3)) - shift3.to_ulong();
	
	if(tmp2[8] == 1 || shift3.to_ulong() >= 0x1a || exp_ans3 == 0){
	    ans_head = 0;
	}else{
	    ans_head = tmp2;
	    ans_head[8] = sgn_ans3;
	}
	auto q = frc_ans.to_ulong() >> 4;
	bitset<32> _q(q);
	for(int i = 0; i <= 8; i++){
	    _q[(31-8)+i] = ans_head[i];
	}
	return _q.to_ulong();
    }
}
