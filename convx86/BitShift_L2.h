#pragma once

#include "Entity.h"
#include <bitset>

class BitShift_L2 : public Entity {
public:
    BitShift_L2(std::bitset<28>& data, std::bitset<3>& shift, std::bitset<28>& q);
    virtual void update();
private:
    template <int N>
    inline void fillWithZero(){
	m_q[N] = 0;
	fillWithZero<N-1>();
    }
    std::bitset<28>& m_data;
    std::bitset<3>& m_shift;
    std::bitset<28>& m_q;
};

template <> void BitShift_L2::fillWithZero<0>();
