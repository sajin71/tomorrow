library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

entity alu is
  
  port (
    DATA_IN1 : in  std_logic_vector(31 downto 0);
    DATA_IN2 : in  std_logic_vector(31 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0);
    OPER     : in  ALU_OPER);

end alu;


architecture RTL of alu is

begin  -- RTL
  DATA_OUT <=
    DATA_IN1 and DATA_IN2                                 when OPER = I_AND else
    DATA_IN1 or DATA_IN2                                  when OPER = I_OR  else
    DATA_IN1 xor DATA_IN2                                 when OPER = I_XOR else
    DATA_IN1 nor DATA_IN2                                 when OPER = I_NOR else
    std_logic_vector(signed(DATA_IN1) + signed(DATA_IN2)) when OPER = I_ADD else
    std_logic_vector(signed(DATA_IN1) - signed(DATA_IN2)) when OPER = I_SUB else
    (0      => '1', others => '0')                        when OPER = I_SLT
    and signed(DATA_IN1) < signed(DATA_IN2)                                 else
    (others => '0')                                       when OPER = I_SLT else
    std_logic_vector(SHIFT_LEFT(unsigned(DATA_IN2), to_integer(unsigned(DATA_IN1))))
    when OPER = I_SLL                                                       else
    std_logic_vector(SHIFT_RIGHT(unsigned(DATA_IN2), to_integer(unsigned(DATA_IN1))))
    when OPER = I_SRL                                                       else
    std_logic_vector(SHIFT_RIGHT(signed(DATA_IN2), to_integer(unsigned(DATA_IN1))))
    when OPER = I_SRA                                                       else
    (others => 'X');
  
end RTL;
