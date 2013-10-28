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
      MemtoReg    : in std_logic;
      RegDst      : in std_logic_vector(1 downto 0);
      RegWrite    : in std_logic;
      ALUSrcA     : in std_logic;
      ALUSrcB     : in std_logic_vector(1 downto 0);
      ALUOp       : in ALU_CTRL;
      PCSource    : in std_logic_vector(1 downto 0);

      IR         : in  std_logic_vector(31 downto 0);
      MDR        : in  std_logic_vector(31 downto 0);
      PC_OUT     : out std_logic_vector(31 downto 0);
      FROMALU    : out std_logic_vector(31 downto 0);
      DATA_WRITE : out std_logic_vector(31 downto 0)
      );
  end component;

  component controller
    port (
      CLK         : in  std_logic;
      OP          : in  std_logic_vector(5 downto 0);
      PCWriteNC   : out std_logic;
      PCWriteCond : out std_logic;
      PCWrite     : out std_logic;
      MemWrite    : out std_logic;
      MemtoReg    : out std_logic;
      IRWrite     : out std_logic;
      RegDst      : out std_logic_vector(1 downto 0);
      RegWrite    : out std_logic;
      ALUSrcA     : out std_logic;
      ALUSrcB     : out std_logic_vector(1 downto 0);
      ALUOp       : out ALU_CTRL;
      PCSource    : out std_logic_vector(1 downto 0)
      );
  end component;

  component ram
    generic (
      BRAMBW : integer);

    port (
      CLK        : in  std_logic;
      PC         : in  std_logic_vector(31 downto 0);
      FROMALU    : in  std_logic_vector(31 downto 0);
      DATA_WRITE : in  std_logic_vector(31 downto 0);
      IR         : out std_logic_vector(31 downto 0);
      MDR        : out std_logic_vector(31 downto 0);
      MemWrite   : in  std_logic;
      IRWrite    : in  std_logic;

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
  end component;


  
end top_pack;
