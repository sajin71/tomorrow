library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity finv is
  
  port (
    clk : in  std_logic;
    a   : in  std_logic_vector(31 downto 0);
    q   : out std_logic_vector(31 downto 0));

end finv;

architecture RTL of finv is

  component finvtable
    port (
      clka  : in  std_logic;
      addra : in  std_logic_vector(9 downto 0);
      douta : out std_logic_vector(35 downto 0));
  end component;

  signal gc_1      : std_logic_vector(35 downto 0);
  signal gtxlong_1 : std_logic_vector(25 downto 0);
  signal s_1       : std_logic;
  signal e_1       : std_logic_vector(7 downto 0);
  signal a0_1      : std_logic_vector(9 downto 0);
  signal a1_1      : std_logic_vector(12 downto 0);
  signal is0_1     : boolean;

  signal cons_2 : std_logic_vector(22 downto 0);
  signal gtx_2  : std_logic_vector(13 downto 0);
  signal s_2    : std_logic;
  signal e_2    : std_logic_vector(7 downto 0);
  signal is0_2  : boolean;

begin  -- RTL

  table_ref : finvtable
    port map (
      clka  => clk,
      addra => a(22 downto 13),
      douta => gc_1);

  latch_1 : process (clk)
  begin  -- process latch_1
    if rising_edge(clk) then
      s_1  <= a(31);
      e_1  <= a(30 downto 23);
      a0_1 <= a(22 downto 13);
      a1_1 <= a(12 downto 0);
    end if;
  end process latch_1;

  gtxlong_1 <= std_logic_vector(unsigned(gc_1(35 downto 23)) * unsigned(a1_1));
  is0_1     <= a0_1 = (9 downto 0 => '0') and a1_1 = (12 downto 0 => '0');

  latch_2 : process (clk)
  begin  -- process latch_1
    if rising_edge(clk) then
      cons_2 <= gc_1(22 downto 0);
      gtx_2  <= gtxlong_1(25 downto 12);
      s_2    <= s_1;
      e_2    <= e_1;
      is0_2  <= is0_1;
    end if;
  end process latch_2;

  q <=
    s_2 & std_logic_vector(254 - unsigned(e_2)) & (22 downto 0 => '0') when is0_2 else
    s_2 & std_logic_vector(253 - unsigned(e_2)) & std_logic_vector(unsigned(cons_2) - unsigned(gtx_2));
  
end RTL;
