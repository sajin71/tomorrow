library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fmul is

  port (
    a, b : in  std_logic_vector(31 downto 0);
    clk  : in  std_logic;
    q    : out std_logic_vector(31 downto 0));
  
end fmul;


architecture fuml of fmul is

  --stage1
  signal fin_a,fin_b : std_logic_vector(31 downto 0) := (others => '0');
  signal frc_a_h,frc_b_h : std_logic_vector(12 downto 0) := (others => '0');
  signal frc_a_l,frc_b_l : std_logic_vector(10 downto 0) := (others => '0');
  signal exp_a1,exp_b1 : std_logic_vector(8 downto 0);
  signal exp_ans1 : std_logic_vector(8 downto 0) := (others => '0');
  signal sgn_ans1 : std_logic := '0';
  --stage2
  signal frc_a_h2,frc_b_h2 : std_logic_vector(12 downto 0);
  signal frc_a_l2,frc_b_l2 : std_logic_vector(10 downto 0);
  signal exp_ans2 : std_logic_vector(8 downto 0);
  signal sgn_ans2 : std_logic;
  signal frc2_hh : std_logic_vector(25 downto 0);
  signal frc2_hl,frc2_lh : std_logic_vector(23 downto 0);
  signal frc2_ans : std_logic_vector(26 downto 0);
  signal exp_ans2_1 : std_logic_vector(8 downto 0);
  --stage3
  signal frc3 : std_logic_vector(26 downto 0);
  signal exp_ans3,exp_ans3_1 : std_logic_vector(8 downto 0);
  signal sgn_ans3 : std_logic;
  signal exp_ans : std_logic_vector(7 downto 0);
  signal frc_ans : std_logic_vector(22 downto 0);
  
  signal tmp:std_logic_vector(8 downto 0);
  signal tmp2:std_logic_vector(8 downto 0);
    
begin  -- fuml

  fin_a <= a;
  fin_b <= b;
  frc_a_h <= '1' & fin_a(22 downto 11);
  frc_a_l <= fin_a(10 downto 0);
  frc_b_h <= '1' & fin_b(22 downto 11);
  frc_b_l <= fin_b(10 downto 0);
  exp_a1  <= '0' & fin_a(30 downto 23);
  exp_b1  <= '0' & fin_b(30 downto 23);

  exp_ans1 <= exp_a1 + exp_b1 + "010000001";

  sgn_ans1 <= fin_a(31) xor fin_b(31);

  stage1: process (clk)
  begin  -- process stage1
    if rising_edge(clk) then
      frc_a_h2 <= frc_a_h;
      frc_a_l2 <= frc_a_l;
      frc_b_h2 <= frc_b_h;
      frc_b_l2 <= frc_b_l;
      exp_ans2 <= exp_ans1;
      sgn_ans2 <= sgn_ans1;
    end if;
  end process stage1;

  frc2_hh <= frc_a_h2 * frc_b_h2;
  frc2_hl <= frc_a_h2 * frc_b_l2;
  frc2_lh <= frc_a_l2 * frc_b_h2;

  frc2_ans <= '0' & frc2_hh + frc2_hl(23 downto 11) + frc2_lh(23 downto 11) + "10";

  exp_ans2_1 <= exp_ans2 + '1';
  
  stage2: process (clk)
  begin  -- process stage2
    if rising_edge(clk) then
      frc3 <= frc2_ans;
      exp_ans3 <= exp_ans2;
      exp_ans3_1 <= exp_ans2_1;
      sgn_ans3 <= sgn_ans2;
    end if;
  end process stage2;

  exp_ans <= "00000000" when exp_ans3(8) = '0'
             else exp_ans2_1(7 downto 0) when frc3(25) = '1'
             else exp_ans2(7 downto 0);

  frc_ans <= frc3(24 downto 2) when frc3(25) = '1'
             else frc3(23 downto 1);
  

  --if exp_ans3(8) = '0' then
  --  exp_ans <= "0000000";
  --elsif frc3(26) = '1' then
  --  exp_ans <= exp_ans2_1(7 downto 0);
  --  frc_ans <= frc3(25 downto 3);
  --else
  --  exp_ans <= exp_ans2(7 downto 0);
  --  frc_ans <= frc3(24 downto 2);
  --end if;
    
  q <= sgn_ans3 & exp_ans & frc_ans;
  
  tmp2 <= "011111111";
  tmp <= tmp2 + "011111111" + "010000001";

end fuml;
