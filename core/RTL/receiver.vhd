library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity receiver is
  
  generic (
    WTIME : std_logic_vector(15 downto 0) := x"0091");  -- baudrate 460800

  port (
    CLK   : in  std_logic;
    RX    : in  std_logic;
    DATA  : out std_logic_vector(7 downto 0);
    FRESH : out std_logic);

end receiver;

architecture RTL of receiver is
  signal outdatabuf      : std_logic_vector(7 downto 0);
  signal next_outdatabuf : std_logic_vector(7 downto 0);
  signal next_fresh      : std_logic;
  signal recbuf          : std_logic_vector(7 downto 0);
  signal next_recbuf     : std_logic_vector(7 downto 0);
  signal state           : std_logic_vector(1 downto 0);
  signal next_state      : std_logic_vector(1 downto 0);
  signal countdown       : std_logic_vector(15 downto 0);
  signal next_countdown  : std_logic_vector(15 downto 0);
  signal letternum       : std_logic_vector(2 downto 0);
  signal next_letternum  : std_logic_vector(2 downto 0);
  signal arrow           : std_logic_vector(3 downto 0);
  signal t               : std_logic;
  
begin  -- RTL

  arrow <= "0001" when state = "00" and t = '0' else
           "0010" when state = "01" and countdown /= x"0000" else
           "0011" when state = "01" and t = '1'              else
           "0100" when state = "01"                          else
           "0101" when state = "10" and countdown /= x"0000" else
           "0110" when state = "10" and letternum /= "111"   else
           "0111" when state = "10"                          else
           "1000" when state = "11" and countdown /= x"0000" else
           "1001" when state = "11"                          else
           "0000";

  with arrow select
    next_state <=
    "00" when "0000" | "0011" | "1001",
    "01" when "0001" | "0010",
    "11" when "0111" | "1000",
    "10" when others;

  with arrow select
    next_countdown <=
    countdown - 1            when "0010" | "0101" | "1000",
    "0" & WTIME(15 downto 1) when "0001",
    WTIME                    when others;

  with arrow select
    next_letternum <=
    "000"         when "0100",
    letternum + 1 when "0110",
    letternum     when others;

  next_recbuf <= t & recbuf(7 downto 1) when arrow = "0110" or arrow = "0111" else
                 recbuf;

  next_outdatabuf <= recbuf when arrow = "1001" else
                     outdatabuf;

  next_fresh <= '1' when arrow = "1001" else '0';

  DATA <= outdatabuf;

  latch : process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      outdatabuf <= next_outdatabuf;
      recbuf     <= next_recbuf;
      state      <= next_state;
      countdown  <= next_countdown;
      letternum  <= next_letternum;
      FRESH      <= next_fresh;
      t          <= RX;
    end if;
  end process latch;
end RTL;
