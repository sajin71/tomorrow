library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;
use tomorrow_1.fpu_misc.all;

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

  component fpu
    port (
      CLK  : in  std_logic;
      D1   : in  std_logic_vector(31 downto 0);
      D2   : in  std_logic_vector(31 downto 0);
      R    : out std_logic_vector(31 downto 0);
      OPER : in  FPU_OPER);
  end component;

  signal aluzero    : std_logic;
  signal oper       : ALU_OPER;
  signal pc         : std_logic_vector(31 downto 0) := x"0001ffcc";
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

  signal fwaddr     : std_logic_vector(4 downto 0);
  signal fwdata     : std_logic_vector(31 downto 0);
  signal ft_out     : std_logic_vector(31 downto 0);
  signal fs_out     : std_logic_vector(31 downto 0);
  signal fdata_out  : std_logic_vector(31 downto 0);
  signal fpuout     : std_logic_vector(31 downto 0);
  signal fpu_oper_s : FPU_OPER;
  signal comp_op    : std_logic;
  signal cond_data  : std_logic;
  signal fcsraddr   : std_logic_vector(2 downto 0);
  signal fcsrout    : std_logic;

  signal fcsr_inner : std_logic_vector(2 downto 0);
  type   t_file is array (0 to 7) of std_logic;
  signal fcsr_file  : t_file := (others => '0');

  signal is_equal     : boolean;
  signal is_less_than : boolean;
end component_pack;
