#include "BitShift_L1.h"

BitShift_L1::BitShift_L1(std::bitset<28>& data, std::bitset<2>& shift, std::bitset<28>& q) : m_data(data), m_shift(shift), m_q(q) {
}
void BitShift_L1::update(){
    /*
  q <= Data(27 downto 0) when Shift(1 downto 0) = "00"
       else Data(26 downto 0) & '0' when Shift(1 downto 0) = "01"
       else Data(25 downto 0) & "00" when Shift(1 downto 0) = "10"
       else Data(24 downto 0) & "000" when Shift(1 downto 0) = "11";

     */
    switch(m_shift.to_ulong()){
    case 0 :
	m_q = m_data;
	break;
    case 1 :
	m_q = m_data << 1;
	m_q[0] = 0;
	break;
    case 2 :
	m_q = m_data << 2;
	m_q[0] = m_q[1] = 0;
	break;
    case 3 : 
	m_q = m_data << 3;
	m_q[0] = m_q[1] = m_q[2] = 0;
	break;
    default: throw "Error in __FILE__ __LINE__";
    }
    if(m_shift == 0){
	m_q = m_data;
    }
}


