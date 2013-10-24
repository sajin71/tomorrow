library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.controller_pack.all;
use tomorrow_1.alu_pack.all;

entity controller is
  
  port (
    CLK         : in  std_logic;
    OP          : in  std_logic_vector(5 downto 0);
    PCWriteNC   : out std_logic;
    PCWriteCond : out std_logic;
    PCWrite     : out std_logic;
    MemWrite    : out std_logic;
    MemtoReg    : out std_logic;
    IRWrite     : out std_logic;
    RegDst      : out std_logic_vector(1 downto 0);
    RegWrite    : out std_logic;
    ALUSrcA     : out std_logic;
    ALUSrcB     : out std_logic_vector(1 downto 0);
    ALUOp       : out ALU_CTRL;
    PCSource    : out std_logic_vector(1 downto 0)
    );

end controller;


architecture RTL of controller is
  signal phase      : T_PHASE;
  signal outstate   : cont_sigset;
  signal next_phase : T_PHASE;

begin  -- RTL

  outstate <= stateset(phase);

  next_phase <= DECODE when phase = FETCH                           else
                EX_LS  when phase = DECODE and (OP = LW or OP = SW) else
                MEM_LW when phase = EX_LS and OP = LW               else
                WB_LW  when phase = MEM_LW                          else
                MEM_SW when phase = EX_LS and OP = SW               else
                EX_FUN when phase = DECODE and OP = SPEC            else
                WB_FUN when phase = EX_FUN                          else
                EX_BEQ when phase = DECODE and OP = BEQ             else
                EX_J   when phase = DECODE and OP = J               else
                EX_ADDI when phase = DECODE and OP = ADDI else
                EX_ANDI when phase = DECODE and OP = ANDI else
                EX_ORI when phase = DECODE and OP = ORI else
                WB_IMD when phase = EX_ADDI or phase = EX_ANDI or phase = EX_ORI else
                EX_BNE when phase = DECODE and OP = BNE else
                EX_JAL when phase = DECODE and OP = JAL else
                WB_JAL when phase = EX_JAL else
                FETCH;
                
  PCWriteNC   <= outstate.t_pcwritenc;
  PCWriteCond <= outstate.t_pcwritecond;
  PCWrite     <= outstate.t_pcwrite;
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
