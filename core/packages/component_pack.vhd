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
      REG_WRITE  : in  std_logic);
  end component;

  component alu
    port (
      DATA_IN1 : in  std_logic_vector(31 downto 0);
      DATA_IN2 : in  std_logic_vector(31 downto 0);
      DATA_OUT : out std_logic_vector(31 downto 0);
      OPER     : in  std_logic_vector(2 downto 0));
  end component;

  component alu_controller
    port (
      ALUOp : in  std_logic_vector(1 downto 0);
      FUNCT : in  std_logic_vector(5 downto 0);
      OPER  : out std_logic_vector(2 downto 0));
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
  
end component_pack;
