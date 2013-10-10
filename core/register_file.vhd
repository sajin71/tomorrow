library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity register_file is
  
  port (
    CLK, RST   : in  std_logic;
    READ_ADDR1 : in  std_logic_vector(4 downto 0);
    READ_ADDR2 : in  std_logic_vector(4 downto 0);
    WRITE_ADDR : in  std_logic_vector(4 downto 0);
    WRITE_DATA : in  std_logic_vector(31 downto 0);
    READ_DATA1 : out std_logic_vector(31 downto 0);
    READ_DATA2 : out std_logic_vector(31 downto 0);
    REG_WRITE  : in  std_logic);

end register_file;


architecture rtl of register_file is
  type t_regf is array (integer range 0 to 31) of std_logic_vector(31 downto 0);
  signal regf : t_regf;
  
begin  -- rtl
  behav: process (CLK)
  begin  -- process behav
    if rising_edge(CLK) then
      if RST = '0' then
        for i in 0 to 31 loop
          regf(i) <= x"00000000";
        end loop;  -- i
      elsif (REG_WRITE = '1') then
        regf(to_integer(WRITE_ADDR)) <= WRITE_DATA;
      end if;
    end if;
  end process behav;
  READ_DATA1 <= regf(to_integer(READ_ADDR1));
  READ_DATA2 <= regf(to_integer(READ_ADDR2));
end rtl;
