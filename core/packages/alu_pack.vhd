library ieee;
use ieee.std_logic_1164.all;

package alu_pack is
  constant I_AND : std_logic_vector(2 downto 0) := "000";
  constant I_OR  : std_logic_vector(2 downto 0) := "001";
  constant I_ADD : std_logic_vector(2 downto 0) := "010";
  constant I_SUB : std_logic_vector(2 downto 0) := "011";
  constant I_SLT : std_logic_vector(2 downto 0) := "100";
  constant I_NOR : std_logic_vector(2 downto 0) := "101";
  
end alu_pack;
