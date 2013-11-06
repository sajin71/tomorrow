library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BitShift_R is
  
  port (
    Data  : in  std_logic_vector(27 downto 0);
    Shift : in  std_logic_vector(7  downto 0);
    q     : out std_logic_vector(27 downto 0));

end BitShift_R;



architecture RTL of BitShift_R is

  signal Parameter1 : std_logic_vector(27 downto 0);
  signal Parameter2 : std_logic_vector(27 downto 0);
  signal Round : std_logic_vector(4 downto 0);
    
  
begin  -- RTL

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

end RTL;
