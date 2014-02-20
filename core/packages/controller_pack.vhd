library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

package controller_pack is
  type cont_sigset is record            -- output signal set record
    t_pcwritenc   : std_logic;
    t_pcwritecond : std_logic;
    t_pcwrite     : std_logic;
    t_memread     : std_logic;
    t_memwrite    : std_logic;
    t_memtoreg    : std_logic_vector(1 downto 0);
    t_irwrite     : std_logic;
    t_regdst      : std_logic_vector(1 downto 0);
    t_regwrite    : std_logic;
    t_alusrca     : std_logic_vector(1 downto 0);
    t_alusrcb     : std_logic_vector(2 downto 0);
    t_aluop       : ALU_CTRL;
    t_pcsource    : std_logic_vector(1 downto 0);
  end record;

  constant S_FETCH : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '1',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "001",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_DECODE : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "011",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_LS : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "010",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_MEM_LW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '1',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_WB_LW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "01",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_MEM_SW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '1',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_FUN : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "000",
     t_aluop       => C_FUNCT,
     t_pcsource    => "00");

  constant S_WB_FUN : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "01",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_BEQ : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '1',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "000",
     t_aluop       => C_SUB,
     t_pcsource    => "01");

  constant S_EX_J : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "10");

  constant S_EX_ADDI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "010",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_ANDI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "100",
     t_aluop       => C_AND,
     t_pcsource    => "00");

  constant S_EX_ORI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "100",
     t_aluop       => C_OR,
     t_pcsource    => "00");

  constant S_WB_IMD : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_BNE : cont_sigset :=
    (t_pcwritenc   => '1',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "01",
     t_alusrcb     => "000",
     t_aluop       => C_SUB,
     t_pcsource    => "01");

  constant S_EX_JAL : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "001",
     t_aluop       => C_ADD,
     t_pcsource    => "10");

  constant S_WB_JAL : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "10",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_SFT : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "10",
     t_alusrcb     => "000",
     t_aluop       => C_SFT,
     t_pcsource    => "00");

  constant S_EX_SFTV : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "11",
     t_alusrcb     => "000",
     t_aluop       => C_SFT,
     t_pcsource    => "00");

  constant S_EX_JR : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "11");

  constant S_WB_LUI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "10",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_WB_MFC : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "11",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_B : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "01");

  constant S_HALT : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memread     => '0',
     t_memwrite    => '0',
     t_memtoreg    => "00",
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => "00",
     t_alusrcb     => "000",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  type T_PHASE is (FETCH, DECODE, EX_LS, MEM_LW, WAIT_LW, WB_LW, MEM_SW, WAIT_SW, EX_FUN, WB_FUN, EX_BEQ, EX_J, EX_ADDI, EX_ANDI, EX_ORI, WB_IMD, EX_BNE, EX_JAL, WB_JAL, EX_SFT, EX_SFTV, EX_JR, WB_LUI, WB_MFC, EX_LSC, MEM_LWC, WAIT_LWC, WB_LWC, EX_FP, WB_FP, EX_BCT, EX_BCF, EX_CMP, HALT);  -- phase types

  type T_STATESET is array (T_PHASE range <>) of cont_sigset;

  constant stateset : T_STATESET(FETCH to HALT) := (S_FETCH, S_DECODE, S_EX_LS, S_MEM_LW, S_HALT, S_WB_LW, S_MEM_SW, S_HALT, S_EX_FUN, S_WB_FUN, S_EX_BEQ, S_EX_J, S_EX_ADDI, S_EX_ANDI, S_EX_ORI, S_WB_IMD, S_EX_BNE, S_EX_JAL, S_WB_JAL, S_EX_SFT, S_EX_SFTV, S_EX_JR, S_WB_LUI, S_WB_MFC, S_EX_LS, S_MEM_LW, S_HALT, S_HALT, S_HALT, S_HALT, S_EX_B, S_EX_B, S_HALT, S_HALT);

  constant SPEC : std_logic_vector(5 downto 0) := "000000";
  constant J    : std_logic_vector(5 downto 0) := "000010";
  constant JAL  : std_logic_vector(5 downto 0) := "000011";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";
  constant BNE  : std_logic_vector(5 downto 0) := "000101";
  constant ADDI : std_logic_vector(5 downto 0) := "001000";
  constant ANDI : std_logic_vector(5 downto 0) := "001100";
  constant ORI  : std_logic_vector(5 downto 0) := "001101";
  constant LUI  : std_logic_vector(5 downto 0) := "001111";
  constant COP  : std_logic_vector(5 downto 0) := "010001";
  constant SFT  : std_logic_vector(5 downto 0) := "011000";
  constant JR   : std_logic_vector(5 downto 0) := "011011";
  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";
  constant LWC  : std_logic_vector(5 downto 0) := "110001";
  constant SWC  : std_logic_vector(5 downto 0) := "111001";
  constant HLT  : std_logic_vector(5 downto 0) := "111100";

  signal phase      : T_PHASE := FETCH;
  signal outstate   : cont_sigset;
  signal next_phase : T_PHASE;

  signal count      : std_logic_vector(4 downto 0) := "00000";
  signal next_count : std_logic_vector(4 downto 0);
  signal goto_exfp  : boolean                      := false;

  constant D_ADD   : std_logic_vector(4 downto 0) := "00010";
  constant D_MUL   : std_logic_vector(4 downto 0) := "00010";
  constant D_DIV   : std_logic_vector(4 downto 0) := "00101";
  constant D_SQRT  : std_logic_vector(4 downto 0) := "00010";
  constant D_ROUND : std_logic_vector(4 downto 0) := "00000";
  constant D_FLOOR : std_logic_vector(4 downto 0) := "00000";
  constant D_RECIP : std_logic_vector(4 downto 0) := "00010";
  constant D_CVTS  : std_logic_vector(4 downto 0) := "00001";
  
end controller_pack;
