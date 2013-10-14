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
