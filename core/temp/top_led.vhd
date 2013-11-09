library ieee;
use ieee.std_logic_1164.all;

entity top is
  
  port (
    LED   : out std_logic_vector(7 downto 0));

end top;

architecture rtl of top is

begin  -- rtl
  LED <= "01001101";
  
end rtl;
