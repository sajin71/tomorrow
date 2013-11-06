library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fadd is

  port (
    a, b : in  std_logic_vector(31 downto 0);
    clk  : in  std_logic;
    q    : out std_logic_vector(31 downto 0));
  
end fadd;


architecture fadd of fadd is

  component BitShift_R
    port (
      Data  : in  std_logic_vector(27 downto 0);
      Shift : in  std_logic_vector(7  downto 0);
      q     : out std_logic_vector(27 downto 0));
  end component;

  component zlc
    port (
      frc : in  std_logic_vector(27 downto 0);
      q   : out std_logic_vector(4 downto 0));
  end component;

  component BitShift_L1
    port (
      Data  : in  std_logic_vector(27 downto 0);
      Shift : in  std_logic_vector(1 downto 0);
      q     : out std_logic_vector(27 downto 0));
  end component;

  component BitShift_L2
    port (
      Data  : in  std_logic_vector(27 downto 0);
      Shift : in  std_logic_vector(2 downto 0);
      q     : out std_logic_vector(27 downto 0));
  end component;
  
  -- stage1
  signal cmp_abs : std_logic_vector(1 downto 0);
  signal fin_a,fin_b,fin_l,fin_s : std_logic_vector(31 downto 0);
  signal frc_a,frc_b,frc_l,frc_s,frc_ss : std_logic_vector(27 downto 0);
  signal exp_ans1,exp_gap : std_logic_vector(7 downto 0);
  signal sgn_ans1 : std_logic;
  signal op : std_logic;
  -- stage2
  signal frc_l2,frc_s2 : std_logic_vector(27 downto 0);
  signal exp_ans2 : std_logic_vector(7 downto 0);
  signal sgn_ans2,op2 : std_logic;
  signal frc_ans1,frc_ans2,frc2 : std_logic_vector(27 downto 0);
  signal shift : std_logic_vector(4 downto 0);
  signal rounding : std_logic;
  signal exp_up2 : std_logic := '0';
  -- stage3
  signal exp_ans3,exp_ans : std_logic_vector(7 downto 0);
  signal sgn_ans3 : std_logic;
  signal rounding3 : std_logic;
  signal frc_ans,frc_ans3 : std_logic_vector(27 downto 0);
  signal exp_up3 : std_logic;
  signal shift3 : std_logic_vector(4 downto 0);
  signal tmp : std_logic_vector(27 downto 0);
  signal tmp2 : std_logic_vector(7 downto 0);
  
begin  

  fin_a <= a;
  fin_b <= b;
  
  cmp_abs <= "00" when fin_a(30 downto 0) > fin_b(30 downto 0)
             else "01" when fin_a(30 downto 0) = fin_b(30 downto 0)
             else "10";

  frc_a <= "01" & fin_a(22 downto 0) & "000";
  frc_b <= "01" & fin_b(22 downto 0) & "000";

  fin_l <= fin_a when cmp_abs(1) = '0' else fin_b;
  fin_s <= fin_b when cmp_abs(1) = '0' else fin_a;
  frc_l <= frc_a when cmp_abs(1) = '0' else frc_b;
  frc_s <= frc_b when cmp_abs(1) = '0' else frc_a;
  
  exp_gap <= fin_l(30 downto 23) - fin_s(30 downto 23);

  rs: BitShift_R
    port map(frc_s,exp_gap,frc_ss);

  exp_ans1 <= fin_l(30 downto 23);
  sgn_ans1 <= fin_l(31);

  op <= '0' when fin_l(31) = fin_s(31) else '1';

  stage1: process (clk)
  begin  -- process stage1
    if rising_edge(clk) then
      frc_l2   <= frc_l;
      frc_s2   <= frc_ss;
      exp_ans2 <= exp_ans1;
      sgn_ans2 <= sgn_ans1;
      op2      <= op;
    end if;
  end process stage1;
  
  frc_ans1 <= frc_l2 + frc_s2 when op2 = '0'
             else frc_l2 - frc_s2;

  pr: zlc
    port map(frc_ans1,shift);
  
  exp_up2 <= '1' when frc_ans1(26 downto 2) = "1111111111111111111111111" or 
                      frc_ans1(25 downto 1) = "1111111111111111111111111";
  frc2 <= "1000000000000000000000000000"
          when frc_ans1(26 downto 2) = "1111111111111111111111111"
          else "0100000000000000000000000000"
          when frc_ans1(25 downto 1) = "1111111111111111111111111"
          else frc_ans1;
--  if
--   frc_ans1(26 downto 2) = "1111111111111111111111111" then frc_ans1(25 downto 1) = "1111111111111111111111111"
--    
--    exp_up2 <= '1';
--    frc_ans1 <= "1000000000000000000000000000";
--  elsif frc_ans1(25 downto 1) = "1111111111111111111111111" then
--    exp_up2 <= '1';
--    frc_ans1 <= "0100000000000000000000000000";
--  end if;
  
  ls: BitShift_L1
    port map (frc2,shift(1 downto 0),frc_ans2);
  
  rounding <= frc_ans2(3) and (frc_ans2(4) or frc_ans2(2) or frc_ans2(1));

  --rounding <= frc_ans(3) and (frc_ans2(4) or frc_ans2(2))
  --            when shift(1 downto 0) = "00" 
  --            else frc_ans2(1) and (frc_ans2(2) or frc_ans2(0))
  --            when shift(1 downto 0) = "10"
  --            else frc_ans2(0) and frc_ans2(1)
  --            when shift(1 downto 0) = "10"
  --            else '0';


  stage2: process (clk)
  begin  -- process stage2
    if rising_edge(clk) then
      exp_ans3 <= exp_ans2;
      sgn_ans3 <= sgn_ans2;
      rounding3 <= rounding;
      frc_ans3 <= frc_ans2;
      shift3 <= shift;
      exp_up3 <= exp_up2;
      rounding3 <= rounding;
    end if;
  end process stage2;

  ls2: BitShift_L2
      port map (frc_ans3,shift3(4 downto 2),tmp);
  
  frc_ans <= frc_ans3 + (rounding3 & "0000") when shift3(4 downto 2) = "000" 
             else tmp;
  
  tmp2 <= exp_ans3 + exp_up3 + 1 - shift3;
  
  exp_ans <= "00000000" when tmp2 < 0 or shift3 >= "11010"
             else tmp2;

  q <= sgn_ans3 & exp_ans & frc_ans(26 downto 4);
               
end fadd;
