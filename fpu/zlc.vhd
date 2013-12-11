library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity zlc is
  
  port (
    frc : in  std_logic_vector(27 downto 0);
    q   : out std_logic_vector(4 downto 0));

end zlc;


architecture RTL of zlc is
  
begin  -- behavior
  
    q <=
"00000" when frc(27) = '1' else
"00001" when frc(26) = '1' else
"00010" when frc(25) = '1' else
"00011" when frc(24) = '1' else
"00100" when frc(23) = '1' else
"00101" when frc(22) = '1' else
"00110" when frc(21) = '1' else
"00111" when frc(20) = '1' else
"01000" when frc(19) = '1' else
"01001" when frc(18) = '1' else
"01010" when frc(17) = '1' else
"01011" when frc(16) = '1' else
"01100" when frc(15) = '1' else
"01101" when frc(14) = '1' else
"01110" when frc(13) = '1' else
"01111" when frc(12) = '1' else
"10000" when frc(11) = '1' else
"10001" when frc(10) = '1' else
"10010" when frc(9)  = '1' else
"10011" when frc(8)  = '1' else
"10100" when frc(7)  = '1' else
"10101" when frc(6)  = '1' else
"10110" when frc(5)  = '1' else
"10111" when frc(4)  = '1' else
"11000" when frc(3)  = '1' else
"11001" when frc(2)  = '1' else
"11010" when frc(1)  = '1' else
"11011" when frc(0)  = '1' else
"11100";

end RTL;
