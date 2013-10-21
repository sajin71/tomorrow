library ieee;
use ieee.std_logic_1164.all;

package ram_component_pack is

  component ram_input_control
    generic (
      BRAMBW : integer);

    port (
      PC         : in  std_logic_vector(31 downto 0);
      FROMALU    : in  std_logic_vector(31 downto 0);
      DATA_WRITE : in  std_logic_vector(31 downto 0);
      MEMWRITE   : in  std_logic;
      IRWRITE    : in  std_logic;
      ADDRA      : out std_logic_vector(BRAMBW-1 downto 0);
      ADDRB      : out std_logic_vector(BRAMBW-1 downto 0);
      ENB        : out std_logic;
      WEA        : out std_logic;
      DIA        : out std_logic_vector(31 downto 0);
      SADDR      : out std_logic_vector(19 downto 0);
      SW         : out std_logic);
  end component;

  component ram_output_control
    port (
      MEMWRITE : in    std_logic;
      TOPBIT   : in    std_logic;
      DATA     : in    std_logic_vector(31 downto 0);
      DOA      : in    std_logic_vector(31 downto 0);
      DQ       : inout std_logic_vector(31 downto 0);
      MDR      : out   std_logic_vector(31 downto 0));
  end component;

  component blockram
    generic (
      BRAMBW : integer);

    port (
      CLK       : in  std_logic;
      ADDRA     : in  std_logic_vector(BRAMBW-1 downto 0);
      ADDRB     : in  std_logic_vector(BRAMBW-1 downto 0);
      DATA_INA  : in  std_logic_vector(31 downto 0);
      DATA_OUTA : out std_logic_vector(31 downto 0);
      DATA_OUTB : out std_logic_vector(31 downto 0);
      ENB       : in  std_logic;
      WEA       : in  std_logic);
  end component;

  component d_ff
    generic (
      WIDTH : integer);

    port (
      CLK      : in  std_logic;
      DATA_IN  : in  std_logic_vector(WIDTH-1 downto 0);
      DATA_OUT : out std_logic_vector(WIDTH-1 downto 0);
      WE       : in  std_logic);
  end component;
end ram_component_pack;
