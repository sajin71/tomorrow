library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity zlc is
  
  port (
    frc : in  std_logic_vector(27 downto 0);
    q   : out std_logic_vector(4 downto 0));

end zlc;


architecture behavior of zlc is
  
begin  -- behavior
  process (frc)
  begin  -- process
    
    if frc(27) = '1' then q <= "00000";
    elsif frc(26) = '1' then q <= "00001";
    elsif frc(25) = '1' then q <= "00010";           
    elsif frc(24) = '1' then q <= "00011";
    elsif frc(23) = '1' then q <= "00100";
    elsif frc(22) = '1' then q <= "00101";      
    elsif frc(21) = '1' then q <= "00110";
    elsif frc(20) = '1' then q <= "00111";
    elsif frc(19) = '1' then q <= "01000";
    elsif frc(18) = '1' then q <= "01001";
    elsif frc(17) = '1' then q <= "01010";
    elsif frc(16) = '1' then q <= "01011";
    elsif frc(15) = '1' then q <= "01100";
    elsif frc(14) = '1' then q <= "01101";
    elsif frc(13) = '1' then q <= "01110";
    elsif frc(12) = '1' then q <= "01111";
    elsif frc(11) = '1' then q <= "10000";
    elsif frc(10) = '1' then q <= "10001";
    elsif frc(9)  = '1' then q <= "10010";
    elsif frc(8)  = '1' then q <= "10011";
    elsif frc(7)  = '1' then q <= "10100";
    elsif frc(6)  = '1' then q <= "10101";
    elsif frc(5)  = '1' then q <= "10110";
    elsif frc(4)  = '1' then q <= "10111";
    elsif frc(3)  = '1' then q <= "11000";
    elsif frc(2)  = '1' then q <= "11001";
    elsif frc(1)  = '1' then q <= "11010";
    elsif frc(0)  = '1' then q <= "11011";

                           
    end if;
  end process;
end behavior;
