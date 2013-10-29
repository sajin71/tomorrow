library ieee;
use ieee.std_logic_1164.all;

entity top is
end top;


architecture RTL of top is
  
component itof is
  port ( i  : in  STD_LOGIC_VECTOR (31 downto 0);
         f  : out STD_LOGIC_VECTOR (31 downto 0)
--         clk: STD_LOGIC
       );
end component;

  signal fout : STD_LOGIC_VECTOR (31 downto 0);
begin
  
  test: itof port map (
    i => x"0000000F",
    f => fout);
  
end RTL;
