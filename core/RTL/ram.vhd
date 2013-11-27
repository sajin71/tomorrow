library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.ram_pack.all;

entity ram is
  
  generic (
    BRAMBW : integer := 15;
    WTIME  : std_logic_vector(15 downto 0));

  port (
    CLK        : in  std_logic;
    PC         : in  std_logic_vector(31 downto 0);
    MEMADDR    : in  std_logic_vector(31 downto 0);
    DATA_WRITE : in  std_logic_vector(31 downto 0);
    IR         : out std_logic_vector(31 downto 0);
    MDR        : out std_logic_vector(31 downto 0);
    MemRead    : in  std_logic;
    MemWrite   : in  std_logic;
    IRWrite    : in  std_logic;
    BUSY       : out std_logic;

    XWA   : out   std_logic;                       -- WRITE ENABLE
    ZA    : out   std_logic_vector (19 downto 0);  -- ADDRESS
    ZD    : inout std_logic_vector (31 downto 0);  -- DATA
    RS_RX : in    std_logic;
    RS_TX : out   std_logic
    );

end ram;


architecture RTL of ram is
begin  -- RTL

  -- io
  ioread <= MemRead when MEMADDR(31 downto 30) = "11" else
            '0';

  iowrite <= MemWrite when MEMADDR(31 downto 30) = "11" else
             '0';

  io_manager_map : io_manager
    port map (
      CLK      => CLK,
      DATA_IN  => DATA_WRITE(7 downto 0),
      DATA_OUT => io_dataout,
      MEMREAD  => ioread,
      MEMWRITE => iowrite,
      SW_BUSY  => sw_busy,
      LW_BUSY  => lw_busy,
      RX_DATA  => rx_data,
      RX_FRESH => rx_fresh,
      TX_DATA  => tx_data,
      TX_GO    => tx_go,
      TX_BUSY  => tx_busy);

  receiver_map : receiver
    generic map (
      WTIME => WTIME)
    port map (
      CLK   => CLK,
      RX    => RS_RX,
      DATA  => rx_data,
      FRESH => rx_fresh);

  transmitter_map : transmitter
    generic map (
      WTIME => WTIME)
    port map (
      CLK  => CLK,
      DATA => tx_data,
      GO   => tx_go,
      BUSY => tx_busy,
      TX   => RS_TX);

  -- blockram
  wea <= MemWrite when MEMADDR(31) = '0' else
         '0';
  
  blockram_map : blockram
    generic map (
      BRAMBW => BRAMBW)
    port map (
      CLK       => CLK,
      ADDRA     => MEMADDR(BRAMBW+1 downto 2),
      ADDRB     => PC(BRAMBW+1 downto 2),
      DATA_INA  => DATA_WRITE,
      DATA_OUTA => doa,
      DATA_OUTB => IR,
      ENB       => IRWrite,
      WEA       => wea);

  -- SRAM
  dq <= data when reg_memwrite = '1' and topbits = "10" else
        (others => 'Z');

  ZA  <= MEMADDR(21 downto 2);
  ZD  <= dq;
  XWA <= not MemWrite when MEMADDR(31 downto 30) = "10" else
         '1';

  -- outputs

  next_mstate <= "01" when busy_sig = '1' else
                 "10" when mstate = "01" and busy_sig = '0' else
                 "00";

  MDR <= (others => 'X') when mstate = "01" else
         io_dataout when mstate = "10" or topbits = "11" else
         doa        when topbits = "00"                  else
         dq;

  next_bstate <= "01" when
                 (bstate = "00" and ioread = '1' and lw_busy = '1') or
                 (bstate = "01" and lw_busy = '1') else
                 "10" when
                 (bstate = "00" and iowrite = '1' and sw_busy = '1') or
                 (bstate = "10" and sw_busy = '1') else
                 "00";

  busy_sig <= lw_busy when (bstate = "00" and ioread = '1') or bstate = "01" else
              sw_busy when (bstate = "00" and iowrite = '1') or bstate = "10" else
              '0';
  
  BUSY <= busy_sig;

  -- latch
  bit_dff : process (CLK)
  begin  -- process memwrite_dff
    if rising_edge(CLK) then
      reg_memwrite <= MemWrite;
      topbits      <= MEMADDR(31 downto 30);
      data         <= DATA_WRITE;
      bstate       <= next_bstate;
      mstate       <= next_mstate;
    end if;
  end process bit_dff;

end RTL;
