library ieee;
use ieee.std_logic_1164.all;

entity ram_output_control is
  
  port (
    MEMWRITE : in    std_logic;
    TOPBIT   : in    std_logic;
    DATA     : in    std_logic_vector(31 downto 0);
    DOA      : in    std_logic_vector(31 downto 0);
    DQ       : inout std_logic_vector(31 downto 0);
    MDR      : out   std_logic_vector(31 downto 0));

end ram_output_control;

architecture RTL of ram_output_control is

begin  -- RTL

  MDR <= DOA when MEMWRITE = '0' and TOPBIT = '0' else
         DQ when MEMWRITE = '0' and TOPBIT = '1' else
         DATA;

  DQ <= DATA when MEMWRITE = '1' and TOPBIT = '1' else
        (others => 'Z');

end RTL;
