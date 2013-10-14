library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

entity alu_controller is
  
  port (
    ALUOp : in  std_logic_vector(1 downto 0);
    FUNCT : in  std_logic_vector(5 downto 0);
    OPER  : out std_logic_vector(2 downto 0));

end alu_controller;


architecture RTL of alu_controller is

begin  -- RTL

  OPER <= I_AND when ALUOp(1) = '1' and FUNCT(3 downto 0) = "0100" else
          I_OR when ALUOp(1) = '1' and FUNCT(3 downto 0) = "0101" else
          I_ADD when ALUOp = "00" or (ALUOp(1) = '1' and FUNCT(3 downto 0) = "0000") else
          I_SUB when ALUOp(0) = '1' or (ALUOp(1) = '1' and FUNCT(3 downto 0) = "0010") else
          I_SLT when ALUOp(1) = '1' and FUNCT(3 downto 0) = "1010" else
          (others => 'X');

end RTL;
