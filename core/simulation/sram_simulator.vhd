library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sram_simulator is

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

end sram_simulator;


architecture flowthrough_sram of sram_simulator is
  type   t_regf is array (0 to 31) of std_logic_vector(31 downto 0);
  signal regf     : t_regf := (others => x"00000000");
  signal addr_buf : std_logic_vector(4 downto 0) := "00000";
  signal we_buf   : std_logic := '1';

begin  -- RTL
  latch : process (ZCLKMA(0))
  begin  -- process latch
    if rising_edge(ZCLKMA(0)) then
      if we_buf = '0' then
        regf(conv_integer(addr_buf)) <= ZD;
      end if;
      if XWA = '1' then
        ZD <= regf(conv_integer(ZA(4 downto 0))) after 14 ns;
      end if;
      addr_buf <= ZA(4 downto 0);
      we_buf   <= XWA;
    end if;
  end process latch;
end flowthrough_sram;
