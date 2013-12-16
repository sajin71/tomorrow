library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BitShift_L2 is
  
  port (
    Data  : in  std_logic_vector(27 downto 0);
    Shift : in  std_logic_vector(2 downto 0);
    q     : out std_logic_vector(27 downto 0));

end BitShift_L2;


architecture RTL of BitShift_L2 is

begin  -- RTL

  q <= Data(23 downto 0) & "0000" when Shift = "001"
       else Data(19 downto 0) & "00000000" when Shift = "010"
       else Data(15 downto 0) & "000000000000" when Shift = "011"
       else Data(11 downto 0) & "0000000000000000" when Shift = "100"
       else Data(7  downto 0) & "00000000000000000000" when Shift = "101"
       else Data(3  downto 0) & "000000000000000000000000" when Shift = "110"
       else "0000000000000000000000000000" when Shift = "111"
		 else Data(27 downto 0);

end RTL;
