#include "BitShift_L2.h"

BitShift_L2::BitShift_L2(std::bitset<28>& data, std::bitset<3>& shift, std::bitset<28>& q) : m_data(data), m_shift(shift), m_q(q) {
}
template <> void BitShift_L2::fillWithZero<0>(){
    m_q[0] = 0;
}
void BitShift_L2::update(){
    /*
  q <= Data(23 downto 0) & "0000" when Shift = "001"
       else Data(19 downto 0) & "00000000" when Shift = "010"
       else Data(15 downto 0) & "000000000000" when Shift = "011"
       else Data(11 downto 0) & "0000000000000000" when Shift = "100"
       else Data(7  downto 0) & "00000000000000000000" when Shift = "101"
       else Data(3  downto 0) & "000000000000000000000000" when Shift = "110"
       else "0000000000000000000000000000" when Shift = "111"
		 else Data(27 downto 0);
    */
    switch(m_shift.to_ulong()){
    case 1:
	m_q = m_data << (27-23);
	fillWithZero<3>();
	break;
    case 2:
	m_q = m_data << (27-19);
	fillWithZero<7>();
	break;
    case 3:
	m_q = m_data << (27-15);
	fillWithZero<11>();
	break;
    case 4:
	m_q = m_data << (27-11);
	fillWithZero<15>();
	break;
    case 5:
	m_q = m_data << (27-7);
	fillWithZero<19>();
	break;
    case 6:
	m_q = m_data << (27-3);
	fillWithZero<23>();
	break;
    case 7:
	m_q = 0;
	break;
    case 0:
	m_q = m_data;
	break;
    default : throw "Error in __FILE__ __LINE__";
    }
}


