library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsqrt is
  
  port (
    clk : in  std_logic;
    a   : in  std_logic_vector(31 downto 0);
    q   : out std_logic_vector(31 downto 0));

end fsqrt;

architecture RTL of fsqrt is

  component fsqrttable
    port (
      clka  : in  std_logic;
      addra : in  std_logic_vector(9 downto 0);
      douta : out std_logic_vector(35 downto 0));
  end component;

  signal gc_1      : std_logic_vector(35 downto 0);
  signal gtxlong_1 : std_logic_vector(26 downto 0);
  signal e_1       : std_logic_vector(7 downto 0);
  signal a1_1      : std_logic_vector(13 downto 0);

  signal cons_2 : std_logic_vector(22 downto 0);
  signal gtx_2  : std_logic_vector(13 downto 0);
  signal e_2    : std_logic_vector(7 downto 0);

begin  -- RTL

  table_ref : fsqrttable
    port map (
      clka  => clk,
      addra => a(23 downto 14),
      douta => gc_1);

  latch_1 : process (clk)
  begin  -- process latch_1
    if rising_edge(clk) then
      e_1  <= a(30 downto 23);
      a1_1 <= a(13 downto 0);
    end if;
  end process latch_1;

  gtxlong_1 <= std_logic_vector(unsigned(gc_1(35 downto 23)) * unsigned(a1_1));

  latch_2 : process (clk)
  begin  -- process latch_1
    if rising_edge(clk) then
      cons_2 <= gc_1(22 downto 0);
      gtx_2  <= gtxlong_1(26 downto 13);
      e_2    <= e_1;
    end if;
  end process latch_2;

  q <=
    '0' & std_logic_vector(63 + unsigned('0' & e_2(7 downto 1))) & std_logic_vector(unsigned(cons_2) + unsigned(gtx_2)) when e_2(0) = '0' else
    '0' & std_logic_vector(64 + unsigned('0' & e_2(7 downto 1))) & std_logic_vector(unsigned(cons_2) + unsigned(gtx_2));
  
end RTL;
