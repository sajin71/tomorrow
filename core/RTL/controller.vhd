library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library tomorrow_1;
use tomorrow_1.controller_pack.all;
use tomorrow_1.alu_pack.all;

entity controller is
  
  port (
    CLK         : in  std_logic;
    IR          : in  std_logic_vector(31 downto 0);
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
    PCSource    : out std_logic_vector(1 downto 0);

    PCWriteBCF : out std_logic;
    PCWriteBCT : out std_logic;
    FCSRW      : out std_logic;
    FPRWrite   : out std_logic
    );

end controller;


architecture RTL of controller is
begin  -- RTL

  outstate <= stateset(phase);

  next_phase <=
    DECODE   when phase = FETCH                                                else
    EX_LS    when phase = DECODE and
    (IR(31 downto 26) = LW or IR(31 downto 26) = SW)                           else
    MEM_LW   when phase = EX_LS and IR(31 downto 26) = LW                      else
    WB_LW    when (phase = MEM_LW or phase = WAIT_LW) and BUSY = '0'           else
    WAIT_LW  when phase = MEM_LW or phase = WAIT_LW                            else
    MEM_SW   when (phase = EX_LS and IR(31 downto 26) = SW) or
    (phase = EX_LSC and IR(31 downto 26) = SWC)                                else
    WAIT_SW  when (phase = MEM_SW or phase = WAIT_SW) and BUSY = '1'           else
    EX_FUN   when phase = DECODE and IR(31 downto 26) = SPEC                   else
    WB_FUN   when phase = EX_FUN or phase = EX_SFT                             else
    EX_BEQ   when phase = DECODE and IR(31 downto 26) = BEQ                    else
    EX_J     when phase = DECODE and IR(31 downto 26) = J                      else
    EX_ADDI  when phase = DECODE and IR(31 downto 26) = ADDI                   else
    EX_ANDI  when phase = DECODE and IR(31 downto 26) = ANDI                   else
    EX_ORI   when phase = DECODE and IR(31 downto 26) = ORI                    else
    WB_IMD   when phase = EX_ADDI or phase = EX_ANDI or phase = EX_ORI         else
    EX_BNE   when phase = DECODE and IR(31 downto 26) = BNE                    else
    EX_JAL   when phase = DECODE and IR(31 downto 26) = JAL                    else
    WB_JAL   when phase = EX_JAL                                               else
    EX_SFT   when phase = DECODE and IR(31 downto 26) = SFT and IR(2) = '0'    else
    EX_SFTV  when phase = DECODE and IR(31 downto 26) = SFT                    else
    EX_JR    when phase = DECODE and IR(31 downto 26) = JR                     else
    WB_LUI   when phase = DECODE and IR(31 downto 26) = LUI                    else
    WB_MFC   when phase = DECODE and IR(31 downto 26) = COP and
    IR(25 downto 21) = "00000"                                                 else
    EX_LSC   when phase = DECODE and
    (IR(31 downto 26) = LWC or IR(31 downto 26) = SWC)                         else
    MEM_LWC  when phase = EX_LSC                                               else
    WB_LWC   when (phase = MEM_LWC or phase = WAIT_LWC) and BUSY = '0'         else
    WAIT_LWC when phase = MEM_LWC or phase = WAIT_LWC                          else
    EX_BCT   when phase = DECODE and IR(31 downto 26) = COP and
    IR(25 downto 24) = "01" and IR(16) = '1'                                   else
    EX_BCF   when phase = DECODE and IR(31 downto 26) = COP and
    IR(25 downto 24) = "01"                                                    else
    EX_CMP   when phase = DECODE and IR(31 downto 26) = COP and
    IR(25 downto 24) = "10" and IR(5 downto 3) = "110"                         else
    EX_FP    when goto_exfp or (phase = EX_FP and count /= "000")              else
    WB_FP    when phase = EX_FP or (phase = DECODE and IR(31 downto 26) = COP) else
    HALT     when (phase = DECODE and IR(31 downto 26) = HLT) or phase = HALT  else
    FETCH;

  goto_exfp <= phase = DECODE and IR(31 downto 26) = COP and
               IR(25 downto 24) = "10" and IR(2 downto 0) /= "110";

  next_count <= D_INV when goto_exfp and IR(5 downto 3) = "010" else
                D_CVTS    when goto_exfp and IR(5 downto 3) = "100"    else
                D_ROUND   when goto_exfp and IR(5 downto 0) = "001100" else
                D_FLOOR   when goto_exfp and IR(5 downto 3) = "001"    else
                D_ADD     when goto_exfp and IR(2 downto 1) = "00"     else
                D_MUL     when goto_exfp and IR(2 downto 0) = "010"    else
                D_DIV     when goto_exfp and IR(2 downto 0) = "011"    else
                D_SQRT    when goto_exfp and IR(1 downto 0) = "00"     else
                "000"     when goto_exfp                               else
                count - 1 when count /= "000"                          else
                "000";

  with phase select
    FPRWrite <=
    '1' when WB_LWC | WB_FP,
    '0' when others;

  PCWriteBCT <= '1' when phase = EX_BCT else '0';

  PCWriteBCF <= '1' when phase = EX_BCF else '0';

  FCSRW <= '1' when phase = EX_CMP else '0';

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
      count <= next_count;
    end if;
  end process latch;
  
end RTL;
