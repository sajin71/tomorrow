#include "BitShift_R.h"

BitShift_R::BitShift_R(std::bitset<28>& data, uint8_t& shift, std::bitset<28>& q) : m_data(data), m_shift(shift), m_q(q) {
}
void BitShift_R::update(){
    /*
  Parameter1 <= Data when Shift(1 downto 0) = "00"
                else '0' & Data(27 downto 1) when Shift(1 downto 0) = "01"
                else "00" & Data(27 downto 2) when Shift(1 downto 0) = "10"
                else "000" & Data(27 downto 3);

  Round(0) <= '1' when Parameter1(4 downto 0) /= "00000" else '0';

  Parameter2 <= Parameter1 when Shift(2) = '0'
                else "0000" & Parameter1(27 downto 5) & Round(0);
                
  Round(1) <= '1' when Parameter1(8 downto 0)  = "000000000"
              else '1';
  Round(2) <= '1' when Parameter1(16 downto 0) = "00000000000000000"
              else '1';
  Round(3) <= '1' when Parameter1(24 downto 0) = "0000000000000000000000000"
              else '1';
  Round(4) <= '1' when Parameter1(27 downto 0) = "000000000000000000000000000"
              else '1';
  
  q <= "000000000000000000000000000" & Round(4) when Shift(7 downto 5) /= "000"
       else Parameter2 when Shift(4 downto 3) = "00"
       else "00000000"
            & Parameter2(27 downto 9) & Round(1) when Shift(4 downto 3) = "01"
       else "0000000000000000"
            & Parameter2(27 downto 17) & Round(2) when Shift(4 downto 3) = "10"
       else "000000000000000000000000"
            & Parameter2(27 downto 25) & Round(3) when Shift(4 downto 3) = "11";
*/
    auto tmp1 = m_shift & 0x3;
    switch(tmp1){
    case 0:
	m_Parameter1 = m_data;
	break;
    case 1:
	m_Parameter1 = m_data >> 1;
	m_Parameter1[27] = 0;
	break;
    case 2:
	m_Parameter1 = m_data >> 2;
	m_Parameter1[27] = m_Parameter1[26] = 0;
	break;
    case 3:
	m_Parameter1 = m_data >> 3;
	m_Parameter1[27] = m_Parameter1[26] = m_Parameter1[25] = 0;
	break;
    }

    m_Round[0] = ((m_Parameter1.to_ulong() & 0x1f) != 0) ? 1 : 0; //!< \todo 5bitあたりにあるとあやしくなってくるのでテストしておきたい。
    if(std::bitset<8>(m_shift)[2] == 0){
	m_Parameter2 = m_Parameter1;
    }else{
	m_Parameter2 = m_Parameter1 >> 4;
	m_Parameter2[0] = m_Round[0];
	m_Parameter1[27] = m_Parameter1[26] = m_Parameter1[25] = m_Parameter1[24] = 0;
    }

    //! \todo よくわからないのだが、ここの条件分岐なんのためにあるの？
    m_Round[1] = ((m_Parameter1.to_ulong() & 0x1ff) == 0) ? 1 : 1;
    m_Round[2] = ((m_Parameter1.to_ulong() & 0x1ffff) == 0) ? 1 : 1;
    m_Round[3] = ((m_Parameter1.to_ulong() & 0x1ffffff) == 0) ? 1 : 1;
    m_Round[4] = ((m_Parameter1.to_ulong()) == 0) ? 1 : 1;

    auto tmp2 = (m_shift & 0x1f) >> 3;//!< \todo ここのロジックも怪しいShift(4 downto 3)のところ
    if(false){
    }else if((m_shift & 0xe0) != 0){
	m_q = std::bitset<28>(0);
	m_q[0] = m_Round[4];
    }else if(tmp2 == 0){
	m_q = m_Parameter2;
    
	/*!
	 * \todo ここから先、面倒くさくて零で埋める作業を省略している。
	 */
    }else if(tmp2 == 1){
	m_q = m_Parameter2 >> 8;
	m_q[0] = m_Round[1];
    }else if(tmp2 == 2){
	m_q = m_Parameter2 >> 16;
	m_q[0] = m_Round[2];
    }else if(tmp2 == 3){
	m_q = m_Parameter2 >> 24;
	m_q[0] = m_Round[3];
    }else{
	throw "Error __FILE__ __LINE__";
    }
}
