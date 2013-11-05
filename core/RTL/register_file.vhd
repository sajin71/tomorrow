library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_file is
  
  port (
    CLK        : in  std_logic;
    READ_ADDR1 : in  std_logic_vector(4 downto 0);
    READ_ADDR2 : in  std_logic_vector(4 downto 0);
    WRITE_ADDR : in  std_logic_vector(4 downto 0);
    WRITE_DATA : in  std_logic_vector(31 downto 0);
    READ_DATA1 : out std_logic_vector(31 downto 0);  -- syncronous
    READ_DATA2 : out std_logic_vector(31 downto 0);
    REG_WRITE  : in  std_logic);

end register_file;


architecture rtl of register_file is
  type   t_regf is array (0 to 31) of std_logic_vector(31 downto 0);
  signal regf                 : t_regf := (others => x"00000000");
  signal addr_reg1, addr_reg2 : std_logic_vector(4 downto 0);
  
begin  -- rtl
  latch : process (CLK)
  begin  -- process behav
    if rising_edge(CLK) then
      if (REG_WRITE = '1') then
        regf(conv_integer(WRITE_ADDR)) <= WRITE_DATA;
      end if;
      addr_reg1 <= READ_ADDR1;
      addr_reg2 <= READ_ADDR2;
    end if;
  end process latch;
  READ_DATA1 <= regf(conv_integer(addr_reg1));
  READ_DATA2 <= regf(conv_integer(addr_reg2));
end rtl;

-- read operation is syncronized for using blockram. differs from pathenne.
