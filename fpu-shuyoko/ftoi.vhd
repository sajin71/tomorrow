library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ftoi is
  port ( f    :  in STD_LOGIC_VECTOR (31 downto 0);
         round:  in STD_LOGIC_VECTOR (1 downto 0); --00...ROUND,  01...TRUNC,  10...CEIL,  11...FLOOR
         i    : out STD_LOGIC_VECTOR (31 downto 0)
--         clk  : in  STD_LOGIC
       );
end ftoi;

architecture RTL of ftoi is

  
  signal e     : std_logic_vector(7 downto 0);
  signal eoffset : std_logic_vector(7 downto 0);
  signal loffset : std_logic_vector(2 downto 0);
  signal num   : std_logic_vector(30 downto 0);
  signal numx  : std_logic_vector(30 downto 0);
  
  signal frac     : std_logic_vector(23 downto 0);
  signal shostemp : std_logic_vector(22 downto 0); -- shosuu ten ika wo kakunou
  
  signal to_left  : std_logic;
  
  signal signbit : std_logic;
  signal halfbit : std_logic; -- 1/2 no kurai
  signal fracbit : std_logic; -- shosuu ten ika ga aruka?
  
  signal hosei : std_logic;
  
  signal answer : STD_LOGIC_VECTOR (31 downto 0);

begin
  
  signbit <= f(31);
  frac(23) <= '1';
  frac(22 downto 0) <= f(22 downto 0);
  
  e <= f(30 downto 23) - 127;
  
  shostemp <= SHL(frac(22 downto 0), e);
  
  to_left <= '1' when (e(4) and e(3))='1'
           else '0';
			  
  eoffset <= 23-e;
  loffset <= not eoffset(2 downto 0); -- e <= 30, then e-23 < 8
  
  num <= "0000000000000000000000000000000" when e(7)='1'
 --     else SHL(("0000000"&frac), e-23) when to_left='1'
        else SHL(("000000"&frac), loffset)&'0' when to_left='1'
        else SHR(("0000000"&frac), eoffset);
             
  halfbit <= '1' when e="11111111" -- frac is -1 (1/2)+...
           else '0' when (e(7) or to_left)='1'
           else shostemp(22);
             
  fracbit <= '0' when e="10000001" -- frac is 00000000 TODO: Denormalized Number
          else '1' when e(7)='1'
          else '0' when to_left = '1'
          else shostemp(22) or shostemp(21) or shostemp(20) or shostemp(19) or shostemp(18) or shostemp(17) or shostemp(16) or shostemp(15) or 
            shostemp(14) or shostemp(13) or shostemp(12) or shostemp(11) or shostemp(10) or shostemp(9) or shostemp(8) or shostemp(7) or 
            shostemp(6) or shostemp(5) or shostemp(4) or shostemp(3) or shostemp(2) or shostemp(1) or shostemp(0);
  
  

  hosei <= '0' when (signbit='1' and ((round="11" and fracbit='1') or (round="00" and halfbit='1')))
                  or (signbit='0' and not ((round="10" and fracbit='1') or (round="00" and halfbit='1')))
      else '1';
  
  numx <= num when signbit='0'
       else not num;

  answer <= (signbit&numx) + hosei;

  i<=answer;
--  latch: process(clk)
--  begin
--    if rising_edge(clk) then
--      i <= answer;
--    end if;
--  end process;

end RTL;



