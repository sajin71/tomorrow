library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BitShift_L1 is
  
  port (
    Data  : in  std_logic_vector(27 downto 0);
    Shift : in  std_logic_vector(1 downto 0);
    q     : out std_logic_vector(27 downto 0));

end BitShift_L1;


architecture RTL of BitShift_L1 is

begin  -- RTL

  q <= Data(27 downto 0) when Shift(1 downto 0) = "00"
       else Data(26 downto 0) & '0' when Shift(1 downto 0) = "01"
       else Data(25 downto 0) & "00" when Shift(1 downto 0) = "10"
       else Data(24 downto 0) & "000" when Shift(1 downto 0) = "11";

end RTL;