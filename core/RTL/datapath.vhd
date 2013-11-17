library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library tomorrow_1;
use tomorrow_1.component_pack.all;
use tomorrow_1.alu_pack.all;
use tomorrow_1.fpu_misc.all;

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

    PCWriteBCF : in std_logic;
    PCWriteBCT : in std_logic;
    FCSRW      : in std_logic;
    FPRWrite   : in std_logic;

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

  pccont <= (aluzero and PCWriteCond) or PCWrite or ((not aluzero) and PCWriteNC)
            or (fcsrout and PCWriteBCT) or ((not fcsrout) and PCWriteBCF);

  with RegDst select
    write_addr <=
    IR(20 downto 16) when "00",
    IR(15 downto 11) when "01",
    "11111"          when others;

  with MemtoReg select
    write_data <=
    aluout                    when "00",
    MDR                       when "01",
    IR(15 downto 0) & x"0000" when "10",
    fs_out                    when others;

  with ALUSrcA select
    data_in1 <=
    pc                                            when "00",
    read_data1                                    when "01",
    (26 downto 0 => '0') & IR(10 downto 6)        when "10",
    (26 downto 0 => '0') & read_data1(4 downto 0) when others;

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

  DATA_WRITE <= ft_out when IR(28 downto 26) = "001" else
                read_data2;

  oper <=
    I_AND when ALUOp = C_AND or (ALUOp = C_FUNCT and IR(2 downto 0) = "100") else
    I_OR  when ALUOp = C_OR or (ALUOp = C_FUNCT and IR(1 downto 0) = "01")   else
    I_XOR when ALUOp = C_FUNCT and IR(2 downto 0) = "110"                    else
    I_NOR when ALUOp = C_FUNCT and IR(1 downto 0) = "11"                     else
    I_SLT when ALUOp = C_FUNCT and IR(3) = '1'                               else
    I_SUB when ALUOp = C_SUB or (ALUOp = C_FUNCT and IR(1) = '1')            else
    I_SLL when ALUOp = C_SFT and IR(1) = '0'                                 else
    I_SRL when ALUOp = C_SFT and IR(0) = '0'                                 else
    I_SRA when ALUOp = C_SFT                                                 else
    I_ADD;



  -- fpu datapath

  fpr_map : register_file
    port map (
      CLK        => CLK,
      READ_ADDR1 => IR(20 downto 16),
      READ_ADDR2 => IR(15 downto 11),
      WRITE_ADDR => fwaddr,
      WRITE_DATA => fwdata,
      READ_DATA1 => ft_out,
      READ_DATA2 => fs_out,
      REG_WRITE  => FPRWrite);

  fpu_map : fpu
    port map (
      CLK  => CLK,
      D1   => ft_out,
      D2   => fs_out,
      R    => fdata_out,
      OPER => fpu_oper_s);

  fpu_latch : process (CLK)
  begin  -- process fpu_latch
    if rising_edge(CLK) then
      fpuout <= fdata_out;
    end if;
  end process fpu_latch;

  fcsraddr <= IR(20 downto 18) when IR(25) = '0' else
              IR(10 downto 8);

  fwdata <=
    MDR        when IR(31) = '1'              else
    read_data2 when IR(25 downto 24) = "00"   else
    fs_out     when IR(5 downto 0) = "000110" else
    fpuout;

  fwaddr <=
    IR(20 downto 16) when IR(31) = '1'            else
    IR(15 downto 11) when IR(25 downto 24) = "00" else
    IR(10 downto 6);

  comp_op <=
    '0' when IR(1) = '1' else
    '1';

  fcsr_latch : process (CLK)
  begin  -- process fcsr_latch
    if rising_edge(CLK) then
      if FCSRW = '1' then
        fcsr_file(to_integer(unsigned(fcsraddr))) <= cond_data;
      end if;
      fcsr_inner <= fcsraddr;
    end if;
  end process fcsr_latch;
  fcsrout <= fcsr_file(to_integer(unsigned(fcsr_inner)));

  with IR(5 downto 0) select
    fpu_oper_s <=
    O_FSUB   when "000001",
    O_FMUL   when "000010",
    O_FDIV   when "000011",
    O_FSQRT  when "000100",
    O_FABS   when "000101",
    O_FNEG   when "000111",
    O_FROUND when "001100",
    O_FFLOOR when "001111",
    O_FRECIP when "010101",
    O_FCVTS  when "100000",
    O_FADD   when others;
  
  is_equal <=
    true when ft_out(30 downto 0) = (30 downto 0 => '0')
    and fs_out(30 downto 0) = (30 downto 0       => '0') else
    fs_out = ft_out;

  is_less_than <=
    unsigned(fs_out(22 downto 0)) < unsigned(ft_out(22 downto 0))   when
    fs_out(31) = '0' and fs_out(31 downto 23) = ft_out(31 downto 23)           else
    unsigned(fs_out(22 downto 0)) > unsigned(ft_out(22 downto 0))   when
    fs_out(31 downto 23) = ft_out(31 downto 23)                                else
    unsigned(fs_out(30 downto 23)) < unsigned(ft_out(30 downto 23)) when
    fs_out(31) = ft_out(31) and fs_out(31) = '0'                               else
    unsigned(fs_out(30 downto 23)) > unsigned(ft_out(30 downto 23)) when
    fs_out(31) = ft_out(31)                                                    else
    false                                                           when
    fs_out = (31 => '1', 30 downto 0 => '0') and ft_out = (31 downto 0 => '0') else
    fs_out(31) = '1';

  cond_data <=
    not comp_op when is_equal     else
    comp_op     when is_less_than else
    '0';

  
end RTL;
