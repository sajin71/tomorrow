library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.component_pack.all;
use tomorrow_1.alu_pack.all;

entity datapath is

  port (
    CLK         : in std_logic;
    PCWriteNC   : in std_logic;
    PCWriteCond : in std_logic;
    PCWrite     : in std_logic;
    MemtoReg    : in std_logic_vector(1 downto 0);
    RegDst      : in std_logic_vector(1 downto 0);
    RegWrite    : in std_logic;
    ALUSrcA     : in std_logic_vector(1 downto 0);
    ALUSrcB     : in std_logic_vector(1 downto 0);
    ALUOp       : in ALU_CTRL;
    PCSource    : in std_logic_vector(1 downto 0);

    IR         : in  std_logic_vector(31 downto 0);
    MDR        : in  std_logic_vector(31 downto 0);
    PC_OUT     : out std_logic_vector(31 downto 0);
    MEMADDR    : out std_logic_vector(31 downto 0);
    DATA_WRITE : out std_logic_vector(31 downto 0)
    );

end datapath;


architecture RTL of datapath is
begin  -- RTL

  pc_latch : process (CLK)
  begin  -- process pc_latch
    if rising_edge(CLK) then
      if pccont = '1' then
        pc <= next_pc;
      end if;
    end if;
  end process pc_latch;

  register_file_map : register_file
    port map (
      CLK        => CLK,
      READ_ADDR1 => IR(25 downto 21),
      READ_ADDR2 => IR(20 downto 16),
      WRITE_ADDR => write_addr,
      WRITE_DATA => write_data,
      READ_DATA1 => read_data1,
      READ_DATA2 => read_data2,
      REG_WRITE  => RegWrite);

  alu_map : alu
    port map (
      DATA_IN1 => data_in1,
      DATA_IN2 => data_in2,
      DATA_OUT => data_out,
      OPER     => oper);

  aluout_latch : process (CLK)
  begin  -- process aluout_latch
    if rising_edge(CLK) then
      aluout <= data_out;
    end if;
  end process aluout_latch;

  aluzero <= '1' when data_out = x"00000000" else
             '0';

  pccont <= (aluzero and PCWriteCond) or PCWrite or ((not aluzero) and PCWriteNC);

  with RegDst select
    write_addr <=
    IR(20 downto 16) when "00",
    IR(15 downto 11) when "01",
    "11111"          when others;

  with MemtoReg select
    write_data <=
    aluout                    when "00",
    MDR                       when "01",
    IR(15 downto 0) & x"0000" when others;

  with ALUSrcA select
    data_in1 <=
    pc                                     when "00",
    read_data1                             when "01",
    (26 downto 0 => '0') & IR(10 downto 6) when others;

  with ALUSrcB select
    data_in2 <=
    read_data2                                       when "00",
    (2           => '1', others => '0')              when "01",
    (15 downto 0 => IR(15)) & IR(15 downto 0)        when "10",
    (13 downto 0 => IR(15)) & IR(15 downto 0) & "00" when others;

  with PCSource select
    next_pc <=
    data_out                                  when "00",
    aluout                                    when "01",
    pc(31 downto 28) & IR(25 downto 0) & "00" when "10",
    read_data1                                when others;

  PC_OUT <= pc;

  MEMADDR <= aluout;

  DATA_WRITE <= read_data2;

  oper <=
    I_AND when ALUOp = C_AND or (ALUOp = C_FUNCT and IR(3 downto 0) = "0100")   else
    I_OR  when ALUOp = C_OR or (ALUOp = C_FUNCT and IR(3 downto 0) = "0101")    else
    I_XOR when ALUOp = C_FUNCT and IR(3 downto 0) = "0110"                      else
    I_NOR when ALUOp = C_FUNCT and IR(3 downto 0) = "0111"                      else
    I_ADD when ALUOp = C_ADD or (ALUOp = C_FUNCT and IR(5 downto 0) = "100000") else
    I_SUB when ALUOp = C_SUB or (ALUOp = C_FUNCT and IR(5 downto 0) = "100010") else
    I_SLT when ALUOp = C_FUNCT and IR(5 downto 0) = "101010"                    else
    I_SLL when ALUOp = C_SFT and IR(5 downto 0) = "000000"                      else
    I_SRL when ALUOp = C_SFT and IR(5 downto 0) = "000010"                      else
    I_SRA when ALUOp = C_SFT and IR(5 downto 0) = "000011"                      else
    I_ADD;
  
end RTL;
