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
    MemtoReg    : in std_logic;
    RegDst      : in std_logic_vector(1 downto 0);
    RegWrite    : in std_logic;
    ALUSrcA     : in std_logic;
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

  pc_latch: process (CLK)
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

  aluout_latch: process (CLK)
  begin  -- process aluout_latch
    if rising_edge(CLK) then
      aluout <= data_out;
    end if;
  end process aluout_latch;

  alu_control_map : alu_controller
    port map (
      ALUOp => ALUOp,
      FUNCT => IR(5 downto 0),
      OPER  => oper);


  aluzero <= '1' when data_out = x"00000000" else
             '0';

  pccont <= (aluzero and PCWriteCond) or PCWrite or ((not aluzero) and PCWriteNC);

  write_addr <= IR(20 downto 16) when RegDst = "00" else
                IR(15 downto 11) when RegDst = "01" else
                "11111";

  write_data <= aluout when MemtoReg = '0' else
                MDR;

  data_in1 <= pc when ALUSrcA = '0' else
              read_data1;

  data_in2 <= read_data2 when ALUSrcB = "00" else
              (2 => '1', others => '0') when ALUSrcB = "01" else
              (15 downto 0 => IR(15)) & IR(15 downto 0) when ALUSrcB = "10" else
              (13 downto 0 => IR(15)) & IR(15 downto 0) & "00";

  next_pc <= data_out when PCSource = "00" else
             aluout when PCSource = "01" else
             pc(31 downto 28) & IR(25 downto 0) & "00";

  PC_OUT <= pc;

  MEMADDR <= aluout;

  DATA_WRITE <= read_data2;
  
end RTL;
