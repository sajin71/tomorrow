library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.top_pack.all;

library unisim;
use unisim.VComponents.all;

entity top is
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
end top;


architecture RTL of top is

  signal clk, iclk : std_logic;

  signal PCWriteCond : std_logic;
  signal PCWrite     : std_logic;
  signal MemWrite    : std_logic;
  signal MemtoReg    : std_logic;
  signal IRWrite     : std_logic;
  signal RegDst      : std_logic;
  signal RegWrite    : std_logic;
  signal ALUSrcA     : std_logic;
  signal ALUSrcB     : std_logic_vector(1 downto 0);
  signal ALUOp       : std_logic_vector(1 downto 0);
  signal PCSource    : std_logic_vector(1 downto 0);
  signal OP          : std_logic_vector(5 downto 0);

begin  -- RTL
  ib : IBUFG port map (
    i => MCLK1,
    o => iclk);
  bg : BUFG port map (
    i => iclk,
    o => clk);

  datapath_map : datapath
    generic map (
      BRAMBW => 15)
    port map (
      CLK         => clk,
      PCWriteCond => PCWriteCond,
      PCWrite     => PCWrite,
      MemWrite    => MemWrite,
      MemtoReg    => MemtoReg,
      IRWrite     => IRWrite,
      RegDst      => RegDst,
      RegWrite    => RegWrite,
      ALUSrcA     => ALUSrcA,
      ALUSrcB     => ALUSrcB,
      ALUOp       => ALUOp,
      PCSource    => PCSource,
      OP          => OP,

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

  controller_map : controller
    port map (
      CLK         => clk,
      OP          => OP,
      PCWriteCond => PCWriteCond,
      PCWrite     => PCWrite,
      MemWrite    => MemWrite,
      MemtoReg    => MemtoReg,
      IRWrite     => IRWrite,
      RegDst      => RegDst,
      RegWrite    => RegWrite,
      ALUSrcA     => ALUSrcA,
      ALUSrcB     => ALUSrcB,
      ALUOp       => ALUOp,
      PCSource    => PCSource);

end RTL;
