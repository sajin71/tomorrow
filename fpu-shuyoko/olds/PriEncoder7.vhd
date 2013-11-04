library ieee;
use ieee.std_logic_1164.all;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PriEncoder7 is
  port ( i  : in  STD_LOGIC_VECTOR (6 downto 0);
         o  : out STD_LOGIC_VECTOR (2 downto 0));
end PriEncoder7;

architecture RTL of PriEncoder7 is
begin

  o(2) <= i(6) or i(5) or i(4) or i(3);
  o(1) <= i(6) or i(5) or
          (not i(4) and not i(3) and ( i(2) or i(1)) );
  o(0) <= i(6)
          or ( not i(5) and ( i(4)
          or ( not i(3) and ( i(2)
          or ( not i(1) and ( i(0) ) ) ) ) ) );
end RTL;
