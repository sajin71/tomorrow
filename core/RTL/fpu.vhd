library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.fpu_pack.all;

entity fpu is
  
  port (
    CLK  : in  std_logic;
    OPER : in  FPU_OPER;
    D1   : in  std_logic_vector(31 downto 0);
    D2   : in  std_logic_vector(31 downto 0);
    R    : out std_logic_vector(31 downto 0));

end fpu;


architecture RTL of fpu is
begin  -- RTL
  
  with OPER select
    R <=
    qadd                           when FADD,
    qadd                           when FSUB,
    qmul                           when FMUL,
    qdiv                           when FDIV,
    qsqrt                          when FSQRT,
    '0' & D2(30 downto 0)          when FABS,
    (not D2(31)) & D2(30 downto 0) when FNEG,
    qround                         when FROUND,
    qfloor                         when FFLOOR,
    qinv                           when FRECIP,
    qcvts                          when others;

  with OPER select
    a_fadd <=
    (not D1(31)) & D1(30 downto 0) when FSUB,
    D1                             when others;

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

  fdiv_map : fdiv
    port map (
      bunbo => D1,
      bunsi => D2,
      clk   => CLK,
      q     => qdiv);

  fsqrt_map : fsqrt
    port map (
      a   => D2,
      clk => CLK,
      q   => qsqrt);

  fround_map : fround
    port map (
      a   => D2,
      clk => CLK,
      q   => qround);

  ffloor_map : ffloor
    port map (
      a   => D2,
      clk => CLK,
      q   => qfloor);

  finv_map : finv
    port map (
      a   => D2,
      clk => CLK,
      q   => qinv);

  fcvts_map : fcvts
    port map (
      a   => D2,
      clk => CLK,
      q   => qcvts);

end RTL;
