library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.component_pack.all;


entity datapath is

  generic (
    BRAMBW : integer := 15);

  port (
    CLK         : in  std_logic;
    PCWriteCond : in  std_logic;
    PCWrite     : in  std_logic;
    MemWrite    : in  std_logic;
    MemtoReg    : in  std_logic;
    IRWrite     : in  std_logic;
    RegDst      : in  std_logic;
    RegWrite    : in  std_logic;
    ALUSrcA     : in  std_logic;
    ALUSrcB     : in  std_logic_vector(1 downto 0);
    ALUOp       : in  std_logic_vector(1 downto 0);
    PCSource    : in  std_logic_vector(1 downto 0);
    OP          : out std_logic_vector(5 downto 0);

    XE1    : out   std_logic;                       -- E1
    E2A    : out   std_logic;                       -- E2
    XE3    : out   std_logic;                       -- E3
    XGA    : out   std_logic;                       -- G
    XZCKE  : out   std_logic;                       -- CKE
    ADVA   : out   std_logic;                       -- ADV
    XLBO   : out   std_logic;                       -- LBO
    ZZA    : out   std_logic;                       -- ZZ
    XFT    : out   std_logic;                       -- FT
    XZBE   : out   std_logic_vector (0 to 3);       -- BA, BB
    ZCLKMA : out   std_logic_vector (0 to 1);       -- GIVE CLOCK
    XWA    : out   std_logic;                       -- WRITE ENABLE
    ZA     : out   std_logic_vector (19 downto 0);  -- ADDRESS
    ZD     : inout std_logic_vector (31 downto 0);  -- DATA
    ZDP    : inout std_logic_vector (3 downto 0)    -- PARITY
    );

end datapath;


architecture RTL of datapath is

  signal aluzero    : std_logic;
  signal pc         : std_logic_vector(31 downto 0);
  signal ir         : std_logic_vector(31 downto 0);
  signal mdr        : std_logic_vector(31 downto 0);
  signal write_addr : std_logic_vector(4 downto 0);
  signal write_data : std_logic_vector(31 downto 0);
  signal read_data1 : std_logic_vector(31 downto 0);
  signal read_data2 : std_logic_vector(31 downto 0);
  signal data_in1   : std_logic_vector(31 downto 0);
  signal data_in2   : std_logic_vector(31 downto 0);
  signal oper       : std_logic_vector(2 downto 0);
  signal data_out   : std_logic_vector(31 downto 0);
  signal aluout     : std_logic_vector(31 downto 0);
  signal next_pc    : std_logic_vector(31 downto 0);
  signal pccont     : std_logic;
  
begin  -- RTL

  pc_map : d_ff
    generic map (
      WIDTH => 32)

    port map (
      CLK      => CLK,
      DATA_IN  => next_pc,
      DATA_OUT => pc,
      WE       => pccont);

  memory_map : ram
    generic map (
      BRAMBW => BRAMBW)

    port map (
      CLK        => CLK,
      PC         => pc,
      FROMALU    => aluout,
      DATA_WRITE => read_data2,
      IR         => ir,
      MDR        => mdr,
      MemWrite   => MemWrite,
      IRWrite    => IRWrite,

      XE1    => XE1,
      E2A    => E2A,
      XE3    => XE3,
      XGA    => XGA,
      XZCKE  => XZCKE,
      ADVA   => ADVA,
      XLBO   => XLBO,
      ZZA    => ZZA,
      XFT    => XFT,
      XZBE   => XZBE,
      ZCLKMA => ZCLKMA,
      XWA    => XWA,
      ZA     => ZA,
      ZD     => ZD,
      ZDP    => ZDP);

  register_file_map : register_file
    port map (
      CLK        => CLK,
      READ_ADDR1 => ir(25 downto 21),
      READ_ADDR2 => ir(20 downto 16),
      WRITE_ADDR => write_addr,
      WRITE_DATA => write_data,
      READ_DATA1 => read_data1,
      READ_DATA2 => read_data2,
      REG_WRITE  => RegWrite);

  alu_map : alu
    port map (
      DATA_IN1 => data_in1,
      DATA_IN2 => data_in2,
      DATA_OUT => data_out,
      OPER     => oper);

  ALUOut_map : d_ff
    generic map (
      WIDTH => 32)

    port map (
      CLK      => CLK,
      DATA_IN  => data_out,
      DATA_OUT => aluout,
      WE       => '1');

  alu_control_map : alu_controller
    port map (
      ALUOp => ALUOp,
      FUNCT => ir(5 downto 0),
      OPER  => oper);

  
  OP <= ir(31 downto 26);
  
  aluzero <= '1' when data_out = x"00000000" else
             '0';

  pccont <= (aluzero and PCWriteCond) or PCWrite;

  write_addr <= ir(20 downto 16) when RegDst = '0' else
                ir(15 downto 11);

  write_data <= aluout when MemtoReg = '0' else
                mdr;

  data_in1 <= pc when ALUSrcA = '0' else
              read_data1;

  data_in2 <= read_data2 when ALUSrcB = "00" else
              (2 => '1',others => '0') when ALUSrcB = "01" else
              x"0000" & ir(15 downto 0) when ALUSrcB = "10" else
              "00000000000000" & ir(15 downto 0) & "00";

  next_pc <= data_out when PCSource = "00" else
             aluout when PCSource = "01" else
             pc(31 downto 28) & ir(25 downto 0) & "00";

end RTL;
