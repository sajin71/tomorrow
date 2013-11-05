library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity transmitter is
  
  generic (
    WTIME : std_logic_vector(15 downto 0) := x"0091");  -- baudrate 460800

  port (
    CLK  : in  std_logic;
    DATA : in  std_logic_vector(7 downto 0);
    GO   : in  std_logic;
    BUSY : out std_logic;
    TX   : out std_logic);
end transmitter;

architecture RTL_arr of transmitter is
  signal sendbuf        : std_logic_vector(7 downto 0)  := (others => 'X');
  signal next_sendbuf   : std_logic_vector(7 downto 0);
  signal state          : std_logic_vector(1 downto 0)  := "00";
  signal next_state     : std_logic_vector(1 downto 0);
  signal countdown      : std_logic_vector(15 downto 0) := WTIME;
  signal next_countdown : std_logic_vector(15 downto 0);
  signal letternum      : std_logic_vector(2 downto 0)  := "000";
  signal next_letternum : std_logic_vector(2 downto 0);
  signal arrow          : std_logic_vector(3 downto 0);
  
begin  -- RTL_arr

  arrow <= "0001" when state = "00" and GO = '1' else
           "0010" when state = "01" and countdown /= x"0000" else
           "0011" when state = "01"                          else
           "0100" when state = "10" and countdown /= x"0000" else
           "0101" when state = "10" and letternum /= "111"   else
           "0110" when state = "10"                          else
           "0111" when state = "11" and countdown /= x"0000" else
           "1000" when state = "11"                          else
           "0000";

  with arrow select
    next_state <=
    "00" when "0000" | "1000",
    "01" when "0001" | "0010",
    "11" when "0110" | "0111",
    "10" when others;

  with arrow select
    next_countdown <=
    countdown - 1 when "0010" | "0100" | "0111",
    WTIME         when others;

  with arrow select
    next_letternum <=
    "000"         when "0011",
    letternum + 1 when "0101",
    letternum     when others;

  with arrow select
    next_sendbuf <=
    DATA    when "0001",
    sendbuf when others;

  BUSY <= '0' when state = "00" else '1';

  with state select
    TX <=
    '0'                              when "01",
    sendbuf(conv_integer(letternum)) when "10",
    '1'                              when others;

  latch : process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      state     <= next_state;
      countdown <= next_countdown;
      letternum <= next_letternum;
      sendbuf   <= next_sendbuf;
    end if;
  end process latch;
end RTL_arr;
