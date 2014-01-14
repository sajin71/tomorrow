#pragma once

#include "Entity.h"
#include "zlc.h"
#include "BitShift_R.h"
#include "BitShift_L1.h"
#include "BitShift_L2.h"
#include <bitset>

class fadd : public Entity {
public:
    fadd(uint32_t& a, uint32_t& b, uint32_t& q);
    virtual ~fadd();
    virtual void update();
    virtual void clockUpdate();
private:
    uint32_t &a, &b, &q;
    std::bitset<2> cmp_abs;
    uint32_t fin_a, fin_b, fin_l, fin_s;
    std::bitset<28> frc_a, frc_b, frc_l, frc_s, frc_ss;
    uint8_t exp_ans1, exp_gap;
    bool sgn_ans1;
    bool op;

    std::bitset<28> frc_l2, frc_s2;
    uint8_t exp_ans2;
    bool sgn_ans2, op2;
    std::bitset<28> frc_ans1, frc_ans2, frc2;
    std::bitset<5> shift;
    bool rounding;
    bool exp_up2;

    uint8_t exp_ans3, exp_ans;
    bool sgn_ans3;
    std::bitset<9> ans_head;
    bool rounding3;
    std::bitset<28> frc_ans, frc_ans3;
    bool exp_up3;
    std::bitset<5> shift3;
    std::bitset<28> tmp;
    std::bitset<9> tmp2;
    BitShift_R rs;
    BitShift_L1 ls;
    BitShift_L2 ls2;
    zlc pr;
    
    std::bitset<2> __tmp;
    std::bitset<3> __tmp2;
};
