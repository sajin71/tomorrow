library ieee;
use ieee.std_logic_1164.all;

entity PriEncoder31 is
  port ( i31  : in  STD_LOGIC_VECTOR (30 downto 0);
         o31  : out STD_LOGIC_VECTOR (4 downto 0));
end PriEncoder31;

architecture RTL of PriEncoder31 is
begin
  
  o31 <= "11111" when i31(30)='1' else
         "11111" when i31(30)='1' else
         "11110" when i31(29)='1' else
         "11101" when i31(28)='1' else
         "11100" when i31(27)='1' else
         "11011" when i31(26)='1' else
         "11010" when i31(25)='1' else
         "11001" when i31(24)='1' else
         "11000" when i31(23)='1' else
         "10111" when i31(22)='1' else
         "10110" when i31(21)='1' else
         "10101" when i31(20)='1' else
         "10100" when i31(19)='1' else
         "10011" when i31(18)='1' else
         "10010" when i31(17)='1' else
         "10001" when i31(16)='1' else
         "10000" when i31(15)='1' else
         "01111" when i31(14)='1' else
         "01110" when i31(13)='1' else
         "01101" when i31(12)='1' else
         "01100" when i31(11)='1' else
         "01011" when i31(10)='1' else
         "01010" when i31(9)='1' else
         "01001" when i31(8)='1' else
         "01000" when i31(7)='1' else
         "00111" when i31(6)='1' else
         "00110" when i31(5)='1' else
         "00101" when i31(4)='1' else
         "00100" when i31(3)='1' else
         "00011" when i31(2)='1' else
         "00010" when i31(1)='1' else
         "00001" when i31(0)='1' else
			"00000";


end RTL;

