library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.test_pack.all;

entity testbench is
end testbench;

architecture tb of testbench is
  signal XE1    : std_logic;                       -- E1
  signal E2A    : std_logic;                       -- E2
  signal XE3    : std_logic;                       -- E3
  signal XGA    : std_logic;                       -- G
  signal XZCKE  : std_logic;                       -- CKE
  signal ADVA   : std_logic;                       -- ADV
  signal XLBO   : std_logic;                       -- LBO
  signal ZZA    : std_logic;                       -- ZZ
  signal XFT    : std_logic;                       -- FT
  signal XZBE   : std_logic_vector (0 to 3);       -- BA, BB
  signal ZCLKMA : std_logic_vector (0 to 1);       -- GIVE CLOCK
  signal XWA    : std_logic;                       -- WRITE ENABLE
  signal ZA     : std_logic_vector (19 downto 0);  -- ADDRESS
  signal ZD     : std_logic_vector (31 downto 0);  -- DATA
  signal ZDP    : std_logic_vector (3 downto 0);   -- PARITY

  signal clk   : std_logic;
  signal rs_rx : std_logic := '1';
  signal rs_tx : std_logic;
  signal data  : std_logic_vector(7 downto 0);
  signal fresh : std_logic;
  
begin  -- tb

  top_map : top
    port map (
      MCLK1 => clk,
      RS_RX => rs_rx,
      RS_TX => rs_tx,

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

  sram_map : sram_simulator
    port map (
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

  receiver_map : receiver
    generic map (
      WTIME => x"0091")
    port map (
      CLK   => clk,
      RX    => rs_tx,
      DATA  => data,
      FRESH => fresh);

  clockgen : process
  begin  -- process clockgen
    clk <= '0';
    wait for 7 ns;
    clk <= '1';
    wait for 7 ns;
  end process clockgen;
end tb;
