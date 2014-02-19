library ieee;
use ieee.std_logic_1164.all;

package fpu_pack is

  component fadd
    port (
      a, b : in  std_logic_vector(31 downto 0);
      clk  : in  std_logic;
      q    : out std_logic_vector(31 downto 0));
  end component;

  component fmul
    port (
      a, b : in  std_logic_vector(31 downto 0);
      clk  : in  std_logic;
      q    : out std_logic_vector(31 downto 0));
  end component;

  component ftoi
    port (f     : in  std_logic_vector (31 downto 0);
          round : in  std_logic_vector (1 downto 0);  --00...ROUND,  01...TRUNC,  10...CEIL,  11...FLOOR
          i     : out std_logic_vector (31 downto 0)
--         clk  : in  STD_LOGIC
          );
  end component;

  component sitof
    port (i   : in  std_logic_vector (31 downto 0);
          f   : out std_logic_vector (31 downto 0);
          clk : in  std_logic
          );
  end component;

  component finv
    port (
      clk : in  std_logic;
      a   : in  std_logic_vector(31 downto 0);
      q   : out std_logic_vector(31 downto 0));
  end component;

  component fsqrt
    port (
      clk : in  std_logic;
      a   : in  std_logic_vector(31 downto 0);
      q   : out std_logic_vector(31 downto 0));
  end component;

  signal qadd   : std_logic_vector(31 downto 0);
  signal qmul   : std_logic_vector(31 downto 0);
  signal qdiv   : std_logic_vector(31 downto 0);
  signal qsqrt  : std_logic_vector(31 downto 0);
  signal qinv   : std_logic_vector(31 downto 0);
  signal qftoi  : std_logic_vector(31 downto 0);
  signal qsitof : std_logic_vector(31 downto 0);

  signal a_fadd   : std_logic_vector(31 downto 0);
  signal round_op : std_logic_vector(1 downto 0);

  signal t_inv  : std_logic_vector(31 downto 0);
  signal t_inv2 : std_logic_vector(31 downto 0);
end fpu_pack;
