library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity blockram is

  generic (
    BRAMBW : integer := 15);

  port (
    CLK       : in  std_logic;
    ADDRA     : in  std_logic_vector(BRAMBW-1 downto 0);
    ADDRB     : in  std_logic_vector(BRAMBW-1 downto 0);
    DATA_INA  : in  std_logic_vector(31 downto 0);
    DATA_OUTA : out std_logic_vector(31 downto 0);
    DATA_OUTB : out std_logic_vector(31 downto 0);
    ENB       : in  std_logic;
    WEA       : in  std_logic);

end blockram;


architecture RTL of blockram is
  type   t_ram is array ((2 ** BRAMBW)-1 downto 0) of std_logic_vector(31 downto 0);
  signal ram : t_ram :=
    (x"6c000000",
     x"1000fffa",
     x"2063fffc",
     x"20420004",
     x"ac440000",
     x"8c04ffff",
     x"10600005",
     x"8c03ffff",
     x"ac04ffff",
     x"2004004b",
     x"ac04ffff",
     x"2004004f",
     x"20020000",
     others => x"00000000");

  signal reg_addra : std_logic_vector(BRAMBW-1 downto 0) := (others => '0');
  signal reg_addrb : std_logic_vector(BRAMBW-1 downto 0) := (others => '0');
  
begin  -- RTL

  latch : process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      if WEA = '1' then
        ram(conv_integer(ADDRA)) <= DATA_INA;
      end if;
      reg_addra <= ADDRA;

      if ENB = '1' then
        reg_addrb <= ADDRB;
      end if;
    end if;
  end process latch;

  DATA_OUTA <= ram(conv_integer(reg_addra));
  DATA_OUTB <= ram(conv_integer(reg_addrb));
end RTL;
