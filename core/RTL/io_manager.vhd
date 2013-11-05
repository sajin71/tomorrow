library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity io_manager is
  
  port (
    CLK      : in  std_logic;
    DATA_IN  : in  std_logic_vector(7 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0);
    MEMREAD  : in  std_logic;
    MEMWRITE : in  std_logic;
    SW_BUSY  : out std_logic;
    LW_BUSY  : out std_logic;
    RX_DATA  : in  std_logic_vector(7 downto 0);
    RX_FRESH : in  std_logic;
    TX_DATA  : out std_logic_vector(7 downto 0);
    TX_GO    : out std_logic;
    TX_BUSY  : in  std_logic
    );

end io_manager;

architecture RTL of io_manager is
  type   t_recvbuf is array (0 to 31) of std_logic_vector(31 downto 0);
  type   t_sendbuf is array (0 to 31) of std_logic_vector(7 downto 0);
  signal recvbuf     : t_recvbuf                    := (others => x"00000000");
  signal sendbuf     : t_sendbuf                    := (others => x"00");
  signal s_enq       : std_logic_vector(4 downto 0) := "00000";
  signal next_s_enq  : std_logic_vector(4 downto 0);
  signal s_deq       : std_logic_vector(4 downto 0) := "00000";
  signal r_enq       : std_logic_vector(4 downto 0) := "00000";
  signal r_deq       : std_logic_vector(4 downto 0) := "00000";
  signal next_r_deq  : std_logic_vector(4 downto 0);
  signal sw_busy_sig : std_logic;
  signal lw_busy_sig : std_logic;
  signal tx_go_sig   : std_logic                    := '0';
  signal tx_data_sig : std_logic_vector(7 downto 0) := x"00";

  signal count        : std_logic_vector(1 downto 0)  := "11";
  signal next_count   : std_logic_vector(1 downto 0);
  signal rxbuf        : std_logic_vector(23 downto 0) := (others => '0');
  signal next_rxbuf   : std_logic_vector(23 downto 0);
  signal rxtrain      : std_logic_vector(31 downto 0) := (others => '0');
  signal next_rxtrain : std_logic_vector(31 downto 0);
  signal rfresh       : std_logic                     := '0';
  signal next_rfresh  : std_logic;
  signal b_arrow      : std_logic_vector(1 downto 0);

  type   IOSTATE is (IO_READY, L_WAIT, L_WB, S_WAIT);
  type   IOARROW is (MYSELF, READY_LWAIT, LLOOP, LWAIT_LWB, LWB_READY, READY_LWB, READY_SWAIT, SLOOP, SWAIT_READY, RLOOP);
  signal state      : IOSTATE := IO_READY;
  signal next_state : IOSTATE;
  signal arrow      : IOARROW := MYSELF;
  
begin  -- RTL
  
  arrow <=
    MYSELF      when state = IO_READY and MEMREAD = '0' and MEMWRITE = '0'    else
    READY_LWAIT when state = IO_READY and MEMREAD = '1' and lw_busy_sig = '1' else
    LLOOP       when state = L_WAIT and lw_busy_sig = '1'                     else
    LWAIT_LWB   when state = L_WAIT                                           else
    LWB_READY   when state = L_WB                                             else
    READY_LWB   when state = IO_READY and MEMREAD = '1'                       else
    READY_SWAIT when state = IO_READY and sw_busy_sig = '1'                   else
    SLOOP       when state = S_WAIT and sw_busy_sig = '1'                     else
    SWAIT_READY when state = S_WAIT                                           else
    RLOOP       when state = IO_READY                                         else
    MYSELF;

  with arrow select
    next_state <=
    L_WAIT   when READY_LWAIT | LLOOP,
    L_WB     when LWAIT_LWB | READY_LWB,
    S_WAIT   when READY_SWAIT | SLOOP,
    IO_READY when others;

  next_s_enq <= s_enq + 1 when arrow = SWAIT_READY or arrow = RLOOP else
                s_enq;

  next_r_deq <= r_deq + 1 when arrow = LWB_READY else
                r_deq;

  DATA_OUT <= recvbuf(conv_integer(r_deq));

  SW_BUSY <= sw_busy_sig;
  LW_BUSY <= lw_busy_sig;

  sw_busy_sig <= '1' when s_enq + 1 = s_deq else
                 '0';

  lw_busy_sig <= '1' when r_enq = r_deq else
                 '0';

  TX_GO   <= tx_go_sig;
  TX_DATA <= tx_data_sig;


  b_arrow <= "01" when RX_FRESH = '1' and count /= "00" else
             "10" when RX_FRESH = '1' else
             "00";

  with b_arrow select
    next_count <=
    count - 1 when "01",
    "11"      when "10",
    count     when others;

  next_rxbuf <= rxbuf(15 downto 0) & RX_DATA when b_arrow = "01" else
                rxbuf;

  next_rxtrain <= rxbuf & RX_DATA when b_arrow = "10" else
                  rxtrain;

  next_rfresh <= '1' when b_arrow = "10" else
                 '0';

  queue_manage : process (CLK)
  begin  -- process queue_manage
    if rising_edge(CLK) then
      -- receiving manage
      if rfresh = '1'then
        recvbuf(conv_integer(r_enq)) <= rxtrain;
        r_enq                        <= r_enq + 1;
      end if;

      -- sending manage
      if TX_BUSY = '0' and tx_go_sig = '0' and s_enq /= s_deq then
        tx_go_sig   <= '1';
        tx_data_sig <= sendbuf(conv_integer(s_deq));
        s_deq       <= s_deq + 1;
      else
        tx_go_sig <= '0';
      end if;

      -- latches
      if arrow = READY_SWAIT or arrow = RLOOP then
        sendbuf(conv_integer(s_enq)) <= DATA_IN;
      end if;
      state <= next_state;
      s_enq <= next_s_enq;
      r_deq <= next_r_deq;

      count   <= next_count;
      rxbuf   <= next_rxbuf;
      rxtrain <= next_rxtrain;
      rfresh  <= next_rfresh;
    end if;
  end process queue_manage;
end RTL;
