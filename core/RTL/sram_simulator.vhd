library ieee;
use ieee.std_logic_1164.all;

entity sram_simulator is

  port (
    XE1    : in   std_logic;                       -- E1 ignore
    E2A    : in   std_logic;                       -- E2 ignore
    XE3    : in   std_logic;                       -- E3 ignore
    XGA    : in   std_logic;                       -- G  ignore
    XZCKE  : in   std_logic;                       -- CKEignore
    ADVA   : in   std_logic;                       -- ADVignore
    XLBO   : in   std_logic;                       -- LBOignore
    ZZA    : in   std_logic;                       -- ZZ ignore
    XFT    : in   std_logic;                       -- FT
    XZBE   : in   std_logic_vector (0 to 3);       -- BA, BBignore
    ZCLKMA : in   std_logic_vector (0 to 1);       -- GIVE CLOCK
    XWA    : in   std_logic;                       -- WRITE ENABLE
    ZA     : in   std_logic_vector (19 downto 0);  -- ADDRESS
    ZD     : inout std_logic_vector (31 downto 0);  -- DATA
    ZDP    : inout std_logic_vector (3 downto 0)    -- PARITYignore
    );

end sram_simulator;


architecture RTL of sram_simulator is

begin  -- RTL

  

end RTL;
