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

  component fdiv
    port (
      bunbo, bunsi : in  std_logic_vector(31 downto 0);
      clk          : in  std_logic;
      q            : out std_logic_vector(31 downto 0));
  end component;

  component fsqrt
    port (
      a   : in  std_logic_vector(31 downto 0);
      clk : in  std_logic;
      q   : out std_logic_vector(31 downto 0));
  end component;

  component fround
    port (
      a   : in  std_logic_vector(31 downto 0);
      clk : in  std_logic;
      q   : out std_logic_vector(31 downto 0));
  end component;

  component ffloor
    port (
      a   : in  std_logic_vector(31 downto 0);
      clk : in  std_logic;
      q   : out std_logic_vector(31 downto 0));
  end component;

  component finv
    port (
      a   : in  std_logic_vector(31 downto 0);
      clk : in  std_logic;
      q   : out std_logic_vector(31 downto 0));
  end component;

  component fcvts
    port (
      a   : in  std_logic_vector(31 downto 0);
      clk : in  std_logic;
      q   : out std_logic_vector(31 downto 0));
  end component;

  signal qadd   : std_logic_vector(31 downto 0);
  signal qmul   : std_logic_vector(31 downto 0);
  signal qdiv   : std_logic_vector(31 downto 0);
  signal qsqrt  : std_logic_vector(31 downto 0);
  signal qround : std_logic_vector(31 downto 0);
  signal qfloor : std_logic_vector(31 downto 0);
  signal qinv   : std_logic_vector(31 downto 0);
  signal qcvts  : std_logic_vector(31 downto 0);

  signal a_fadd : std_logic_vector(31 downto 0);
end fpu_pack;
