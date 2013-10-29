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
  signal expo     : std_logic_vector(7 downto 0);
  signal shifted  : std_logic_vector(31 downto 0);
  signal rounded  : std_logic_vector(23 downto 0);
  
begin
  
  inabs <= i(30 downto 0) when i(31)='0' else
           (not i(30 downto 0)) + 1;
  expo(7 downto 5) <= "000";

  prien: PriEncoder31 port map (
    i31 => inabs,
    o31 => expo(4 downto 0)
  );
  
  shifted(31) <= '0';
  shifted(30 downto 0) <= SHL(inabs(30 downto 0), 32 - expo(4 downto 0)); -- ???????????
  
  rounded <= shifted(31 downto 8) + 1 when shifted(7)='1' and
                                         (shifted(8) or shifted(6) or shifted(5) or shifted(4) or shifted(3) 
                                                                  or shifted(2) or shifted(1) or shifted(0))='1' else
                    shifted(31 downto 8);
  
  
  f(31) <= i(31);
  f(30 downto 23) <= "00000000" when expo(4 downto 0)="00000" else
                     expo + 127 when rounded(23)='1' else
                     expo + 126;
  f(22 downto 0) <= rounded(22 downto 0);
  --shifted(30 downto 8) + 1 when shifted(7)='1' and (shifted(8)='1' or shifted(6)='1') else
  --                  shifted(30 downto 8);
end RTL;

