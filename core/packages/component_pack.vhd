library ieee;
use ieee.std_logic_1164.all;

package component_pack is
  component register_file
    port (
      CLK        : in  std_logic;
      READ_ADDR1 : in  std_logic_vector(4 downto 0);
      READ_ADDR2 : in  std_logic_vector(4 downto 0);
      WRITE_ADDR : in  std_logic_vector(4 downto 0);
      WRITE_DATA : in  std_logic_vector(31 downto 0);
      READ_DATA1 : out std_logic_vector(31 downto 0);  -- NOT SYNCRONIZED
      READ_DATA2 : out std_logic_vector(31 downto 0);
      RST        : in  std_logic;
      REG_WRITE  : in  std_logic);
  end component;

  component alu
    port (
      DATA_IN1 : in  std_logic_vector(31 downto 0);
      DATA_IN2 : in  std_logic_vector(31 downto 0);
      DATA_OUT : out std_logic_vector(31 downto 0);
      OPER     : in  std_logic_vector(2 downto 0));
  end component;

end component_pack;