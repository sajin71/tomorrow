library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.VComponents.all;

entity top is
  
  port (
    MCLK1 : in  std_logic;
    RS_TX : out std_logic;
    RS_RX : in  std_logic);

end top;

architecture loopback of top is
  type     t_queue is array (0 to (2**8)-1) of std_logic_vector(7 downto 0);
  signal   queue     : t_queue;
  signal   enq       : std_logic_vector(7 downto 0)  := x"00";
  signal   deq       : std_logic_vector(7 downto 0)  := x"00";
  signal   clk, iclk : std_logic;
  signal   data_in   : std_logic_vector(7 downto 0);
  signal   data_out  : std_logic_vector(7 downto 0);
  signal   fresh     : std_logic;
  signal   go        : std_logic;
  signal   busy      : std_logic;
  constant WTIME     : std_logic_vector(15 downto 0) := x"0091";
  component receiver
    generic (
      WTIME : std_logic_vector(15 downto 0));
    port (
      CLK   : in  std_logic;
      RX    : in  std_logic;
      DATA  : out std_logic_vector(7 downto 0);
      FRESH : out std_logic);
  end component;
  component transmitter
    generic (
      WTIME : std_logic_vector(15 downto 0));
    port (
      CLK  : in  std_logic;
      DATA : in  std_logic_vector(7 downto 0);
      GO   : in  std_logic;
      BUSY : out std_logic;
      TX   : out std_logic);
  end component;
begin  -- loopback
  ib : IBUFG
    port map (
      i => MCLK1,
      o => iclk);
  bg : BUFG
    port map (
      i => iclk,
      o => clk);
  receivemap : receiver
    generic map (
      WTIME => WTIME)
    port map (
      CLK   => clk,
      RX    => RS_RX,
      DATA  => data_in,
      FRESH => fresh);
  sendmap : transmitter
    generic map (
      WTIME => WTIME)
    port map (
      CLK  => clk,
      DATA => data_out,
      GO   => go,
      BUSY => busy,
      TX   => RS_TX);

  sendmsg : process (CLK)
  begin  -- process sendmsg
    if rising_edge(CLK) then
      if fresh = '1' then
        queue(conv_integer(enq)) <= data_in;
        enq                      <= enq + 1;
      else
        enq <= enq;
      end if;
      if busy = '0' and go = '0' and enq /= deq then
        go       <= '1';
        data_out <= queue(conv_integer(deq));
        deq      <= deq + 1;
      else
        go       <= '0';
        data_out <= data_out;
        deq      <= deq;
      end if;
    end if;
  end process sendmsg;
end loopback;
