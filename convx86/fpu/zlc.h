#pragma once

#include "Entity.h"
#include <bitset>

class zlc : public Entity {
public:
    zlc(std::bitset<28>& frc, std::bitset<5>& q);
    virtual void update();
private:
    template <int N>
    uint8_t _update(const std::bitset<28>& frc){
	return (frc[N] == 1) ? (27-N): _update<N-1>(frc);
    }
    std::bitset<28>& m_frc;
    std::bitset<5>& m_q;
};

template <> uint8_t zlc::_update<0>(const std::bitset<28>& frc);

