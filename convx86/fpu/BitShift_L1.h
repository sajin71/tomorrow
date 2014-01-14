#pragma once

#include "Entity.h"
#include <bitset>

class BitShift_L1 : public Entity {
public:
    BitShift_L1(std::bitset<28>& data, std::bitset<2>& shift, std::bitset<28>& q);
    virtual void update();
private:
    std::bitset<28>& m_data;
    std::bitset<2>& m_shift;
    std::bitset<28>& m_q;
};
