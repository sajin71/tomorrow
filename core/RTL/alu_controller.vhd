library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

entity alu_controller is
  
  port (
    ALUOp : in  ALU_CTRL;
    FUNCT : in  std_logic_vector(5 downto 0);
    OPER  : out ALU_OPER);

end alu_controller;


architecture RTL of alu_controller is

begin  -- RTL

end RTL;
