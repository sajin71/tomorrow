library ieee;
use ieee.std_logic_1164.all;

entity ram_input_control is

  generic (
    BRAMBW : integer := 15);
  
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

end ram_input_control;


architecture RTL of ram_input_control is
  
begin  -- RTL

  ADDRA <= FROMALU(BRAMBW+1 downto 2);
  ADDRB <= PC(BRAMBW+1 downto 2);
  ENB <= IRWRITE;
  WEA <= '1' when MEMWRITE = '1' and FROMALU(31) = '0' else
         '0';
  DIA <= DATA_WRITE;
  SADDR <= FROMALU(21 downto 2);
  SW <= '0' when MEMWRITE = '1' and FROMALU(31) = '1' else
        '1';

end RTL;
