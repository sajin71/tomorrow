library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

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
      OPER     : in  ALU_OPER);
  end component;

  signal aluzero    : std_logic;
  signal oper       : ALU_OPER;
  signal pc         : std_logic_vector(31 downto 0) := x"000222ac";
  signal write_addr : std_logic_vector(4 downto 0);
  signal write_data : std_logic_vector(31 downto 0);
  signal read_data1 : std_logic_vector(31 downto 0);
  signal read_data2 : std_logic_vector(31 downto 0);
  signal data_in1   : std_logic_vector(31 downto 0);
  signal data_in2   : std_logic_vector(31 downto 0);
  signal data_out   : std_logic_vector(31 downto 0);
  signal aluout     : std_logic_vector(31 downto 0);
  signal next_pc    : std_logic_vector(31 downto 0);
  signal pccont     : std_logic;
  
end component_pack;
