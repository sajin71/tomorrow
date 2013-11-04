library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PriEncoder31 is
  port ( i31  : in  STD_LOGIC_VECTOR (30 downto 0);
         o31  : out STD_LOGIC_VECTOR (4 downto 0));
end PriEncoder31;

architecture RTL of PriEncoder31 is
component PriEncoder15 is
  port ( i15  : in  STD_LOGIC_VECTOR (14 downto 0);
         o15  : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal omsb : STD_LOGIC_VECTOR (3 downto 0);
signal olsb : STD_LOGIC_VECTOR (3 downto 0);

begin
  msb: PriEncoder15 port map (
    i15 => i31(30 downto 16),
    o15 => omsb
  );
  
  lsb: PriEncoder15 port map (
    i15 => i31(14 downto 0),
    o15 => olsb
  );
  
  o31 <= '1' & omsb when (omsb(3) or omsb(2) or omsb(1) or omsb(0))='1' else
         "10000" when i31(15)='1' else
         '0' & olsb;

end RTL;

