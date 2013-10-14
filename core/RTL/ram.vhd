library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.ram_component_pack.all;

entity ram is
  
  generic (
    BRAMBW : integer := 15);

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

end ram;


architecture RTL of ram is
  signal addra : std_logic_vector(BRAMBW-1 downto 0);
  signal addrb : std_logic_vector(BRAMBW-1 downto 0);
  signal enb   : std_logic;
  signal wea   : std_logic;
  signal dia   : std_logic_vector(31 downto 0);
  signal saddr : std_logic_vector(19 downto 0);
  signal sw    : std_logic;

  signal reg_memwrite : std_logic;
  signal topbit       : std_logic;
  signal data         : std_logic_vector(31 downto 0);
  signal doa          : std_logic_vector(31 downto 0);
  signal dq           : std_logic_vector(31 downto 0);

begin  -- RTL

  input_map : ram_input_control
    generic map (
      BRAMBW => BRAMBW)
    port map (
      PC         => PC,
      FROMALU    => FROMALU,
      DATA_WRITE => DATA_WRITE,
      MEMWRITE   => MemWrite,
      IRWRITE    => IRWrite,
      ADDRA      => addra,
      ADDRB      => addrb,
      ENB        => enb,
      WEA        => wea,
      DIA        => dia,
      SADDR      => saddr,
      SW         => sw);

  input_blockram_map : blockram
    generic map (
      BRAMBW => BRAMBW)
    port map (
      CLK       => CLK,
      ADDRA     => addra,
      ADDRB     => addrb,
      DATA_INA  => dia,
      DATA_OUTA => doa,
      DATA_OUTB => IR,
      ENB       => enb,
      WEA       => wea);

  ZCLKMA(0) <= CLK;
  ZCLKMA(1) <= CLK;
  ZA        <= saddr;
  ZD        <= dq;
  XWA       <= sw;

  XE1   <= '0';
  E2A   <= '1';
  XE3   <= '0';
  XGA   <= '0';
  XZCKE <= '0';
  ADVA  <= '0';
  XLBO  <= '1';
  ZZA   <= '0';
  XFT   <= '0';                         -- flow through mode
  XZBE  <= "0000";
  ZDP   <= "0000";

  memwrite_dff : process (CLK)
  begin  -- process memwrite_dff
    if rising_edge(CLK) then
      reg_memwrite <= MemWrite;
    end if;
  end process memwrite_dff;

  topbit_dff : process (CLK)
  begin  -- process topbit_dff
    if rising_edge(CLK) then
      topbit <= FROMALU(31);
    end if;
  end process topbit_dff;

  data_dff : d_ff
    generic map (
      WIDTH => 32)
    port map (
      CLK      => CLK,
      DATA_IN  => DATA_WRITE,
      DATA_OUT => data,
      WE       => '1');

  output_map : ram_output_control
    port map (
      MEMWRITE => reg_memwrite,
      TOPBIT   => topbit,
      DATA     => data,
      DOA      => doa,
      DQ       => dq,
      MDR      => MDR);

end RTL;
