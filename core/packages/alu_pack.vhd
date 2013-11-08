library ieee;
use ieee.std_logic_1164.all;

package alu_pack is
  type ALU_OPER is (I_AND,I_OR,I_XOR,I_NOR,I_ADD,I_SUB,I_SLT,I_SLL,I_SRL,I_SRA);
  type ALU_CTRL is (C_ADD,C_SUB,C_AND,C_OR,C_FUNCT,C_SFT);
end alu_pack;
