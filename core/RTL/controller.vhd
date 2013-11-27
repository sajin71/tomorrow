library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.controller_pack.all;
use tomorrow_1.alu_pack.all;

entity controller is
  
  port (
    CLK         : in  std_logic;
    OP          : in  std_logic_vector(5 downto 0);
    FUNCT       : in  std_logic_vector(5 downto 0);
    BUSY        : in  std_logic;
    PCWriteNC   : out std_logic;
    PCWriteCond : out std_logic;
    PCWrite     : out std_logic;
    MemRead     : out std_logic;
    MemWrite    : out std_logic;
    MemtoReg    : out std_logic_vector(1 downto 0);
    IRWrite     : out std_logic;
    RegDst      : out std_logic_vector(1 downto 0);
    RegWrite    : out std_logic;
    ALUSrcA     : out std_logic_vector(1 downto 0);
    ALUSrcB     : out std_logic_vector(1 downto 0);
    ALUOp       : out ALU_CTRL;
    PCSource    : out std_logic_vector(1 downto 0)
    );

end controller;


architecture RTL of controller is
begin  -- RTL

  outstate <= stateset(phase);

  next_phase <=
    DECODE  when phase = FETCH                                        else
    EX_LS   when phase = DECODE and (OP = LW or OP = SW)              else
    MEM_LW  when phase = EX_LS and OP = LW                            else
    WB_LW   when (phase = MEM_LW or phase = WAIT_LW) and BUSY = '0'   else
    WAIT_LW when phase = MEM_LW or phase = WAIT_LW                    else
    MEM_SW  when phase = EX_LS and OP = SW                            else
    WAIT_SW when (phase = MEM_SW or phase = WAIT_SW) and BUSY = '1'   else
    EX_FUN  when phase = DECODE and OP = SPEC                         else
    WB_FUN  when phase = EX_FUN or phase = EX_SFT or phase = EX_SFTV  else
    EX_BEQ  when phase = DECODE and OP = BEQ                          else
    EX_J    when phase = DECODE and OP = J                            else
    EX_ADDI when phase = DECODE and OP = ADDI                         else
    EX_ANDI when phase = DECODE and OP = ANDI                         else
    EX_ORI  when phase = DECODE and OP = ORI                          else
    WB_IMD  when phase = EX_ADDI or phase = EX_ANDI or phase = EX_ORI else
    EX_BNE  when phase = DECODE and OP = BNE                          else
    EX_JAL  when phase = DECODE and OP = JAL                          else
    WB_JAL  when phase = EX_JAL                                       else
    EX_SFT  when phase = DECODE and OP = SFT and FUNCT(2) = '0'       else
    EX_SFTV when phase = DECODE and OP = SFT                          else
    EX_JR   when phase = DECODE and OP = JR                           else
    WB_LUI  when phase = DECODE and OP = LUI                          else
    HALT    when (phase = DECODE and OP = HLT) or phase = HALT        else
    FETCH;
  
  PCWriteNC   <= outstate.t_pcwritenc;
  PCWriteCond <= outstate.t_pcwritecond;
  PCWrite     <= outstate.t_pcwrite;
  MemRead     <= outstate.t_memread;
  MemWrite    <= outstate.t_memwrite;
  MemtoReg    <= outstate.t_memtoreg;
  IRWrite     <= outstate.t_irwrite;
  RegDst      <= outstate.t_regdst;
  RegWrite    <= outstate.t_regwrite;
  ALUSrcA     <= outstate.t_alusrca;
  ALUSrcB     <= outstate.t_alusrcb;
  ALUOp       <= outstate.t_aluop;
  PCSource    <= outstate.t_pcsource;

  latch : process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      phase <= next_phase;
    end if;
  end process latch;
  
end RTL;
