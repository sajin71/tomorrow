-- convert signed int(32bit) to float(32bit)

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity sitof is
  port ( i  : in  STD_LOGIC_VECTOR (31 downto 0);
         f  : out STD_LOGIC_VECTOR (31 downto 0);
         clk: STD_LOGIC
       );
end sitof;

architecture RTL of sitof is
  
component PriEncoder31 is
  port ( i31  : in  STD_LOGIC_VECTOR (30 downto 0);
         o31  : out STD_LOGIC_VECTOR (4 downto 0));
end component;
  
  signal inabs    : std_logic_vector(30 downto 0);
  signal expo     : std_logic_vector(4 downto 0);
  signal shifted  : std_logic_vector(29 downto 0);
  signal fraccarry: std_logic;
  
  
-- for stage2
  signal signbit2   : std_logic;
  signal expo2      : std_logic_vector(4 downto 0);
  signal shifted2   : std_logic_vector(22 downto 0);
  
  signal rounded2   : std_logic_vector(23 downto 0);
  signal expoiszero2: std_logic;
  signal fraccarry2 : std_logic;
  
begin
  
  inabs <= i(30 downto 0) when i(31)='0' else
           (not i(30 downto 0)) + 1;

  prien: PriEncoder31 port map (
    i31 => inabs,
    o31 => expo
  );
  
  shifted(29 downto 0) <= SHL(inabs(29 downto 0), not expo); -- "not expo" means 31-expo; MSB always '1', push out
  
  fraccarry <= shifted(6) and (shifted(7) or shifted(5) or shifted(4) or shifted(3) 
                                                    or shifted(2) or shifted(1) or shifted(0));

  latch: process (clk)
  begin
    if rising_edge(clk) then
      signbit2   <= i(31);
      fraccarry2 <= fraccarry;
      expo2      <= expo;
      shifted2   <= shifted(29 downto 7);
    end if;
  end process latch;

  rounded2 <= ('0'&shifted2) + fraccarry2;
  expoiszero2 <= '1' when expo2="00000" else '0';
  
  f(31) <= signbit2; -- sign
  f(30 downto 23) <= "00000000" when signbit2='0' and expoiszero2='1' else
                     "10011110" when expoiszero2='1' else
                     ("000"&expo2) + ("0111111" & rounded2(23)); -- expo: frac carried: +127, otherwise: +126
  f(22 downto 0) <= rounded2(22 downto 0); --frac

end RTL;

