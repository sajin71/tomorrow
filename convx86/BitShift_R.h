#pragma once

#include "Entity.h"
#include <bitset>

class BitShift_R : public Entity {
public:
    BitShift_R(std::bitset<28>& data, uint8_t& shift, std::bitset<28>& q);
    virtual void update();
private:
    std::bitset<28> m_Parameter1;
    std::bitset<28> m_Parameter2;
    std::bitset<5> m_Round;

    std::bitset<28>& m_data;
    uint8_t& m_shift;
    std::bitset<28>& m_q;
};
