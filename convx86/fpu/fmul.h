#pragma once

#include "Entity.h"
#include "zlc.h"
#include "BitShift_R.h"
#include "BitShift_L1.h"
#include "BitShift_L2.h"
#include <bitset>

class fmul : public Entity {
public:
    fmul(uint32_t& a, uint32_t&b, uint32_t& q);
    virtual ~fmul();
    virtual void update();
    void clockUpdate();
private:
    uint32_t &a, &b, &q;
    uint32_t fin_a, fin_b;
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

    std::bitset<9> tmp, tmp2;
};
