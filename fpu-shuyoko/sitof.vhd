-- convert signed int(32bit) to float(32bit)

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity sitof is
  port ( i  : in  STD_LOGIC_VECTOR (31 downto 0);
         f  : out STD_LOGIC_VECTOR (31 downto 0)
--         clk: STD_LOGIC
       );
end sitof;

architecture RTL of sitof is
  
component PriEncoder31 is
  port ( i31  : in  STD_LOGIC_VECTOR (30 downto 0);
         o31  : out STD_LOGIC_VECTOR (4 downto 0));
end component;
  
  signal inabs    : std_logic_vector(30 downto 0);
  signal expo     : std_logic_vector(4 downto 0);
  signal shifted  : std_logic_vector(30 downto 0);
  signal rounded  : std_logic_vector(23 downto 0);
  
  signal expoiszero: std_logic;
  signal expocarry : std_logic;
  
begin
  
  inabs <= i(30 downto 0) when i(31)='0' else
           (not i(30 downto 0)) + 1;

  prien: PriEncoder31 port map (
    i31 => inabs,
    o31 => expo
  );
  
  shifted(30) <= '0';
  shifted(29 downto 0) <= SHL(inabs(29 downto 0), not expo); -- "not expo" means 31-expo; MSB always '1', push out
  
  expocarry <= shifted(6) and (shifted(7) or shifted(5) or shifted(4) or shifted(3) 
                                                    or shifted(2) or shifted(1) or shifted(0));
  rounded <= shifted(30 downto 7) + expocarry;
  
  
  expoiszero <= '1' when expo(4 downto 0)="00000" else '0';
  
  f(31) <= i(31); -- sign
  f(30 downto 23) <= "00000000" when i(31)='0' and expoiszero='1' else
                     "10011110" when expoiszero='1' else
                     expo + ("0111111" & rounded(23)); -- expo: frac carried: +127, otherwise: +126
  f(22 downto 0) <= rounded(22 downto 0); --frac

end RTL;

