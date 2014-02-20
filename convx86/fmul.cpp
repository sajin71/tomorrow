// Thanks to HiroakiMikami


#include <stdint.h>
#include <bitset>

uint32_t fpu_fmul(uint32_t fin_a, uint32_t fin_b);



uint32_t fpu_fmul(uint32_t fin_a, uint32_t fin_b) {
	
	std::bitset<13> frc_a_h, frc_b_h;
	std::bitset<11> frc_a_l, frc_b_l;
	std::bitset<9> exp_a1, exp_b1;
	std::bitset<9> exp_ans1;
	bool sgn_ans1;

	std::bitset<13> frc_a_h2, frc_b_h2;
	std::bitset<11> frc_a_l2, frc_b_l2;
	std::bitset<9> exp_ans2;
	bool sgn_ans2;
	std::bitset<26> frc2_hh;
	std::bitset<24> frc2_hl, frc2_lh;
	std::bitset<27> frc2_ans;
	std::bitset<9> exp_ans2_1;

	std::bitset<27> frc3;
	std::bitset<9> exp_ans3, exp_ans3_1;
	bool sgn_ans3;
	uint8_t exp_ans;
	std::bitset<23> frc_ans;

	
	
	/** Stage 1 **/

	//! \todo ??
	frc_a_h = fin_a >> 11;
	frc_a_h[12] = 1;

	frc_a_l = fin_a;

	frc_b_h = fin_b >> 11;
	frc_b_h[12] = 1;

	frc_b_l = fin_b;
	//! \todo ここまで
	//! \todo ここいらもtodo 
	exp_a1 = fin_a >> 23;
	exp_a1[8] = 0;

	exp_b1 = fin_b >> 23;
	exp_b1[8] = 0;

	exp_ans1 = exp_a1.to_ulong() + exp_b1.to_ulong() + 0x081;

	sgn_ans1 = std::bitset<32>(fin_a)[31] ^ std::bitset<32>(fin_b)[31];
	
	
	
	/* latch */
	frc_a_h2 = frc_a_h;
	frc_a_l2 = frc_a_l;
	frc_b_h2 = frc_b_h;
	frc_b_l2 = frc_b_l;
	exp_ans2 = exp_ans1;
	sgn_ans2 = sgn_ans1;
	
	
	/** Stage 2 **/

	frc2_hh = frc_a_h2.to_ulong() * frc_b_h2.to_ulong();
	frc2_hl = frc_a_h2.to_ulong() * frc_b_l2.to_ulong();
	frc2_lh = frc_a_l2.to_ulong() * frc_b_h2.to_ulong();

	/*!
	* \todo 0&frc2_hhをfrc2_hhにした
	* \todo frc2_hl(23 downto 11)をfrc2_hl >> 11にした。
	*/
	frc2_ans = frc2_hh.to_ulong() + (frc2_hl >> 11).to_ulong() + (frc2_lh >> 11).to_ulong() + 0x2;

	exp_ans2_1 = exp_ans2.to_ulong() + 1;


	// latch
	frc3 = frc2_ans;
	exp_ans3 = exp_ans2;
	exp_ans3_1 = exp_ans2_1;
	sgn_ans3 = sgn_ans2;

	/** Stage 3 **/
	
	if(false){
	}else if(exp_ans3[8] == 0){
		exp_ans = 0;
	}else if(frc3[25] == 1){
		exp_ans = exp_ans2_1.to_ulong();
	}else{
		exp_ans = exp_ans2.to_ulong();
	}

	if(false){
	}else if(frc3[25] == 1){
		frc_ans = (frc3 >> 2).to_ulong();
	}else{
		frc_ans = (frc3 >> 1).to_ulong();
	}

	std::bitset<32> _tmp = frc_ans.to_ulong();
	std::bitset<8> _tmp2(exp_ans);
	_tmp[31] = sgn_ans3;
	for(int i = 0; i < 8; i++){
		_tmp[30-i] = _tmp2[7-i];
	}
	uint32_t q = _tmp.to_ulong();
	
	return q;
}

