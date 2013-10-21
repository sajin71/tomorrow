library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

entity alu is
  
  port (
    DATA_IN1 : in  std_logic_vector(31 downto 0);
    DATA_IN2 : in  std_logic_vector(31 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0);
    OPER     : in  std_logic_vector(2 downto 0));

end alu;


architecture RTL of alu is

begin  -- RTL
  DATA_OUT <= DATA_IN1 and DATA_IN2 when OPER = I_AND else
              DATA_IN1 or DATA_IN2           when OPER = I_OR  else
              DATA_IN1 + DATA_IN2            when OPER = I_ADD else
              DATA_IN1 - DATA_IN2            when OPER = I_SUB else
              (0      => '1', others => '0') when OPER = I_SLT
              and DATA_IN1 < DATA_IN2                          else
              (others => '0')                when OPER = I_SLT else
              DATA_IN1 nor DATA_IN2          when OPER = I_NOR else
              (others => 'X');
  
end RTL;
