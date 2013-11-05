library ieee;
use ieee.std_logic_1164.all;

package ram_pack is

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

  component blockram
    generic (
      BRAMBW : integer);

    port (
      CLK       : in  std_logic;
      ADDRA     : in  std_logic_vector(BRAMBW-1 downto 0);
      ADDRB     : in  std_logic_vector(BRAMBW-1 downto 0);
      DATA_INA  : in  std_logic_vector(31 downto 0);
      DATA_OUTA : out std_logic_vector(31 downto 0);
      DATA_OUTB : out std_logic_vector(31 downto 0);
      ENB       : in  std_logic;
      WEA       : in  std_logic);
  end component;

  component io_manager
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
  end component;

  signal reg_memwrite : std_logic;
  signal topbits      : std_logic_vector(1 downto 0);
  signal data         : std_logic_vector(31 downto 0);
  signal doa          : std_logic_vector(31 downto 0);
  signal dq           : std_logic_vector(31 downto 0);
  signal wea          : std_logic;
  signal io_dataout   : std_logic_vector(31 downto 0);
  signal ioread       : std_logic;
  signal iowrite      : std_logic;
  signal sw_busy      : std_logic;
  signal lw_busy      : std_logic;
  signal rx_data      : std_logic_vector(7 downto 0);
  signal rx_fresh     : std_logic;
  signal tx_data      : std_logic_vector(7 downto 0);
  signal tx_go        : std_logic;
  signal tx_busy      : std_logic;
  signal busy_sig     : std_logic;

  signal bstate      : std_logic_vector(1 downto 0) := "00";
  signal next_bstate : std_logic_vector(1 downto 0);
  signal mstate      : std_logic_vector(1 downto 0) := "00";
  signal next_mstate : std_logic_vector(1 downto 0);
end ram_pack;
