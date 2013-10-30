library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PriEncoder15 is
  port ( i15  : in  STD_LOGIC_VECTOR (14 downto 0);
         o15  : out STD_LOGIC_VECTOR (3 downto 0));
end PriEncoder15;

architecture RTL of PriEncoder15 is
component PriEncoder7 is
  port ( i  : in  STD_LOGIC_VECTOR (6 downto 0);
         o  : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal omsb : STD_LOGIC_VECTOR (2 downto 0);
signal olsb : STD_LOGIC_VECTOR (2 downto 0);

begin
  msb: PriEncoder7 port map (
    i => i15(14 downto 8),
    o => omsb
  );
  
  lsb: PriEncoder7 port map (
    i => i15(6 downto 0),
    o => olsb
  );
  
  o15 <= '1' & omsb when (omsb(2) or omsb(1) or omsb(0))='1' else
         "1000" when i15(7)='1' else
         '0' & olsb;

end RTL;

