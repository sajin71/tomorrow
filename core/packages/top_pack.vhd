library ieee;
use ieee.std_logic_1164.all;

package top_pack is

  component datapath
    generic (
      BRAMBW : integer);

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
  end component;

  component controller
    port (
      CLK         : in  std_logic;
      OP          : in  std_logic_vector(5 downto 0);
      PCWriteCond : out std_logic;
      PCWrite     : out std_logic;
      MemWrite    : out std_logic;
      MemtoReg    : out std_logic;
      IRWrite     : out std_logic;
      RegDst      : out std_logic;
      RegWrite    : out std_logic;
      ALUSrcA     : out std_logic;
      ALUSrcB     : out std_logic_vector(1 downto 0);
      ALUOp       : out std_logic_vector(1 downto 0);
      PCSource    : out std_logic_vector(1 downto 0)
      );
  end component;
  
end top_pack;
