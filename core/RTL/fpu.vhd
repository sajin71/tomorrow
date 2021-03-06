library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.fpu_pack.all;
use tomorrow_1.fpu_misc.all;

entity fpu is
  
  port (
    CLK  : in  std_logic;
    D1   : in  std_logic_vector(31 downto 0);
    D2   : in  std_logic_vector(31 downto 0);
    R    : out std_logic_vector(31 downto 0);
    OPER : in  FPU_OPER);

end fpu;


architecture RTL of fpu is
begin  -- RTL
  
  with OPER select
    R <=
    qadd                           when O_FADD | O_FSUB,
    qmul                           when O_FMUL,
    qdiv                           when O_FDIV,
    qsqrt                          when O_FSQRT,
    '0' & D2(30 downto 0)          when O_FABS,
    (not D2(31)) & D2(30 downto 0) when O_FNEG,
    qftoi                          when O_FROUND | O_FFLOOR,
    qinv                           when O_FRECIP,
    qsitof                         when others;

  with OPER select
    a_fadd <=
    (not D1(31)) & D1(30 downto 0) when O_FSUB,
    D1                             when others;

  with OPER select
    round_op <=
    "00" when O_FROUND,
    "11" when others;
  
  fadd_map : fadd
    port map (
      a   => a_fadd,
      b   => D2,
      clk => CLK,
      q   => qadd);

  fmul_map : fmul
    port map (
      a   => D1,
      b   => D2,
      clk => CLK,
      q   => qmul);

  ftoi_map : ftoi
    port map (
      f     => D2,
      round => round_op,
      i     => qftoi);

  sitof_map : sitof
    port map (
      i   => D2,
      f   => qsitof,
      clk => CLK);

  finv_map : finv
    port map (
      clk => CLK,
      a   => D2,
      q   => qinv);

  fsqrt_map : fsqrt
    port map (
      clk => CLK,
      a   => D2,
      q   => qsqrt);


  -- for fdiv
  
  fdiv_finv : finv
    port map (
      clk => CLK,
      a   => D1,
      q   => t_inv);

  tinvlatch : process (CLK)
  begin  -- process tinvlatch
    if rising_edge(CLK) then
      t_inv2 <= t_inv;
    end if;
  end process tinvlatch;

  fdiv_fmul : fmul
    port map (
      a   => D2,
      b   => t_inv2,
      clk => CLK,
      q   => qdiv);

end RTL;
