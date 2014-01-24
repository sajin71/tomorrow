library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

package top_pack is

  component datapath
    port (
      CLK         : in std_logic;
      PCWriteNC   : in std_logic;
      PCWriteCond : in std_logic;
      PCWrite     : in std_logic;
      MemtoReg    : in std_logic_vector(1 downto 0);
      RegDst      : in std_logic_vector(1 downto 0);
      RegWrite    : in std_logic;
      ALUSrcA     : in std_logic_vector(1 downto 0);
      ALUSrcB     : in std_logic_vector(2 downto 0);
      ALUOp       : in ALU_CTRL;
      PCSource    : in std_logic_vector(1 downto 0);

      PCWriteBCF : in std_logic;
      PCWriteBCT : in std_logic;
      FCSRW      : in std_logic;
      FPRWrite   : in std_logic;

      IR         : in  std_logic_vector(31 downto 0);
      MDR        : in  std_logic_vector(31 downto 0);
      PC_OUT     : out std_logic_vector(31 downto 0);
      MEMADDR    : out std_logic_vector(31 downto 0);
      DATA_WRITE : out std_logic_vector(31 downto 0)
      );
  end component;

  component controller
    port (
      CLK         : in  std_logic;
      IR          : in  std_logic_vector(31 downto 0);
      BUSY        : in  std_logic;
      PCWriteNC   : out std_logic;
      PCWriteCond : out std_logic;
      PCWrite     : out std_logic;
      MemRead     : out std_logic;
      MemWrite    : out std_logic;
      MemtoReg    : out std_logic_vector(1 downto 0);
      IRWrite     : out std_logic;
      RegDst      : out std_logic_vector(1 downto 0);
      RegWrite    : out std_logic;
      ALUSrcA     : out std_logic_vector(1 downto 0);
      ALUSrcB     : out std_logic_vector(2 downto 0);
      ALUOp       : out ALU_CTRL;
      PCSource    : out std_logic_vector(1 downto 0);

      StepCount   : out std_logic_vector(31 downto 0);
      XRST        : in  std_logic;

      PCWriteBCF : out std_logic;
      PCWriteBCT : out std_logic;
      FCSRW      : out std_logic;
      FPRWrite   : out std_logic
      );
  end component;

  component ram
    generic (
      BRAMBW : integer;
      WTIME  : std_logic_vector(15 downto 0));

    port (
      CLK        : in  std_logic;
      PC         : in  std_logic_vector(31 downto 0);
      MEMADDR    : in  std_logic_vector(31 downto 0);
      DATA_WRITE : in  std_logic_vector(31 downto 0);
      IR         : out std_logic_vector(31 downto 0);
      MDR        : out std_logic_vector(31 downto 0);
      MemRead    : in  std_logic;
      MemWrite   : in  std_logic;
      IRWrite    : in  std_logic;
      BUSY       : out std_logic;

      XWA   : out   std_logic;                       -- WRITE ENABLE
      ZA    : out   std_logic_vector (19 downto 0);  -- ADDRESS
      ZD    : inout std_logic_vector (31 downto 0);  -- DATA
      RS_RX : in    std_logic;
      RS_TX : out   std_logic
      );  
  end component;

  component c_led7seg
    port (
      clk      : in  STD_LOGIC;
      data     : in  STD_LOGIC_VECTOR(15 downto 0);
      dp       : in  STD_LOGIC_VECTOR(3 downto 0);
      LED7SEG  : out STD_LOGIC_VECTOR(0 to 7);
      LEDDYN   : out STD_LOGIC_VECTOR(3 downto 0)
      );  
  end component;

  signal clk, iclk : std_logic;

  signal PCWriteNC   : std_logic;
  signal PCWriteCond : std_logic;
  signal PCWrite     : std_logic;
  signal MemRead     : std_logic;
  signal MemWrite    : std_logic;
  signal MemtoReg    : std_logic_vector(1 downto 0);
  signal IRWrite     : std_logic;
  signal RegDst      : std_logic_vector(1 downto 0);
  signal RegWrite    : std_logic;
  signal ALUSrcA     : std_logic_vector(1 downto 0);
  signal ALUSrcB     : std_logic_vector(2 downto 0);
  signal ALUOp       : ALU_CTRL;
  signal PCSource    : std_logic_vector(1 downto 0);

  signal IR         : std_logic_vector(31 downto 0);
  signal MDR        : std_logic_vector(31 downto 0);
  signal PC         : std_logic_vector(31 downto 0);
  signal MEMADDR    : std_logic_vector(31 downto 0);
  signal DATA_WRITE : std_logic_vector(31 downto 0);
  signal BUSY       : std_logic;

  signal PCWriteBCF : std_logic;
  signal PCWriteBCT : std_logic;
  signal FCSRW      : std_logic;
  signal FPRWrite   : std_logic;

  signal StepCount  : std_logic_vector(31 downto 0);
  signal LEDData    : std_logic_vector(15 downto 0);
end top_pack;
