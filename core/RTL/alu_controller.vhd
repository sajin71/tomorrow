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

  OPER <= I_AND when ALUOp = C_AND or (ALUOp = C_FUNCT and FUNCT(3 downto 0) = "0100") else
          I_OR  when ALUOp = C_OR or (ALUOp = C_FUNCT and FUNCT(3 downto 0) = "0101") else
          I_XOR when ALUOp = C_FUNCT and FUNCT(3 downto 0) = "0110"                   else
          I_NOR when ALUOp = C_FUNCT and FUNCT(3 downto 0) = "0111"                   else
          I_ADD when ALUOp = C_ADD or (ALUOp = C_FUNCT and FUNCT = "100000")          else
          I_SUB when ALUOp = C_SUB or (ALUOp = C_FUNCT and FUNCT = "100010")          else
          I_SLT when ALUOp = C_FUNCT and FUNCT = "101010"                             else
          I_ADD;

end RTL;
