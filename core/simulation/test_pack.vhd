library ieee;
use ieee.std_logic_1164.all;

package test_pack is

  component top_sim
    port (
      MCLK1 : in  std_logic;
      RS_RX : in  std_logic;
      RS_TX : out std_logic;

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

  component sram_simulator
    port (
      XE1    : in    std_logic;                       -- E1 ignore
      E2A    : in    std_logic;                       -- E2 ignore
      XE3    : in    std_logic;                       -- E3 ignore
      XGA    : in    std_logic;                       -- G  ignore
      XZCKE  : in    std_logic;                       -- CKEignore
      ADVA   : in    std_logic;                       -- ADVignore
      XLBO   : in    std_logic;                       -- LBOignore
      ZZA    : in    std_logic;                       -- ZZ ignore
      XFT    : in    std_logic;                       -- FT
      XZBE   : in    std_logic_vector (0 to 3);       -- BA, BBignore
      ZCLKMA : in    std_logic_vector (0 to 1);       -- GIVE CLOCK
      XWA    : in    std_logic;                       -- WRITE ENABLE
      ZA     : in    std_logic_vector (19 downto 0);  -- ADDRESS
      ZD     : inout std_logic_vector (31 downto 0);  -- DATA
      ZDP    : inout std_logic_vector (3 downto 0)    -- PARITYignore
      );
  end component;
end test_pack;
