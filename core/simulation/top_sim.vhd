library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.top_pack.all;
use tomorrow_1.alu_pack.all;

--library unisim;
--use unisim.VComponents.all;

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
begin  -- RTL
--  ib : IBUFG port map (
--    i => MCLK1,
--    o => iclk);
--  bg : BUFG port map (
--    i => iclk,
--    o => clk);
  clk <= MCLK1;
  
  datapath_map : datapath
    port map (
      CLK         => clk,
      PCWriteNC   => PCWriteNC,
      PCWriteCond => PCWriteCond,
      PCWrite     => PCWrite,
      MemtoReg    => MemtoReg,
      RegDst      => RegDst,
      RegWrite    => RegWrite,
      ALUSrcA     => ALUSrcA,
      ALUSrcB     => ALUSrcB,
      ALUOp       => ALUOp,
      PCSource    => PCSource,

      IR         => IR,
      MDR        => MDR,
      PC_OUT     => PC,
      MEMADDR    => MEMADDR,
      DATA_WRITE => DATA_WRITE
      );

  controller_map : controller
    port map (
      CLK         => clk,
      OP          => IR(31 downto 26),
      FUNCT       => IR(5 downto 0),
      BUSY        => BUSY,
      PCWriteNC   => PCWriteNC,
      PCWriteCond => PCWriteCond,
      PCWrite     => PCWrite,
      MemRead     => MemRead,
      MemWrite    => MemWrite,
      MemtoReg    => MemtoReg,
      IRWrite     => IRWrite,
      RegDst      => RegDst,
      RegWrite    => RegWrite,
      ALUSrcA     => ALUSrcA,
      ALUSrcB     => ALUSrcB,
      ALUOp       => ALUOp,
      PCSource    => PCSource);

  ram_map : ram
    generic map (
      BRAMBW => 15,
      WTIME  => x"0091")
    port map (
      CLK        => clk,
      PC         => PC,
      MEMADDR    => MEMADDR,
      DATA_WRITE => DATA_WRITE,
      IR         => IR,
      MDR        => MDR,
      MemRead    => MemRead,
      MemWrite   => MemWrite,
      IRWrite    => IRWrite,
      BUSY       => BUSY,

      XWA   => XWA,
      ZA    => ZA,
      ZD    => ZD,
      RS_RX => RS_RX,
      RS_TX => RS_TX);

  XE1    <= '0';
  E2A    <= '1';
  XE3    <= '0';
  XGA    <= '0';
  XZCKE  <= '0';
  ADVA   <= '0';
  XLBO   <= '1';
  ZZA    <= '0';
  XFT    <= '0';                        -- flow through mode
  XZBE   <= "0000";
  ZDP    <= "0000";
  ZCLKMA <= (clk, clk);
  
end RTL;
