library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity transmitter is
  
  generic (
    WTIME : std_logic_vector(15 downto 0) := x"0243");  -- baudrate 115200

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

  next_state <= "00" when arrow = "0000" or arrow = "1000" else
                "01" when arrow = "0001" or arrow = "0010" else
                "11" when arrow = "0110" or arrow = "0111" else
                "10";

  next_countdown <= countdown - 1 when arrow = "0010" or arrow = "0100" or arrow = "0111" else
                    WTIME;
  
  next_letternum <= "000" when arrow = "0011" else
                    letternum + 1 when arrow = "0101" else
                    letternum;

  next_sendbuf <= DATA when arrow = "0001" else
                  sendbuf;

  BUSY <= '0' when state = "00" else '1';

  TX <= '0' when state = "01" else
        sendbuf(conv_integer(letternum)) when state = "10" else
        '1';

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
