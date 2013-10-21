library ieee;
use ieee.std_logic_1164.all;

entity d_ff is

  generic (
    WIDTH : integer := 32);

  port (
    CLK      : in  std_logic;
    DATA_IN  : in  std_logic_vector(WIDTH-1 downto 0);
    DATA_OUT : out std_logic_vector(WIDTH-1 downto 0);
    WE       : in  std_logic);

end d_ff;

architecture RTL of d_ff is
  signal data_reg : std_logic_vector(WIDTH-1 downto 0);
  
begin  -- RTL
  latch : process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      if WE = '1' then
        data_reg <= DATA_IN;
      end if;
    end if;
  end process latch;
  DATA_OUT <= data_reg;
end RTL;
