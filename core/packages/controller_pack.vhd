library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.alu_pack.all;

package controller_pack is
  type cont_sigset is record            -- output signal set record
    t_pcwritenc   : std_logic;
    t_pcwritecond : std_logic;
    t_pcwrite     : std_logic;
    t_memwrite    : std_logic;
    t_memtoreg    : std_logic;
    t_irwrite     : std_logic;
    t_regdst      : std_logic_vector(1 downto 0);
    t_regwrite    : std_logic;
    t_alusrca     : std_logic;
    t_alusrcb     : std_logic_vector(1 downto 0);
    t_aluop       : ALU_CTRL;
    t_pcsource    : std_logic_vector(1 downto 0);
  end record;

  constant S_FETCH : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '1',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "01",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_DECODE : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "11",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_LS : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "10",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_MEM_LW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_WB_LW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '1',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_MEM_SW : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '1',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_FUN : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "00",
     t_aluop       => C_FUNCT,
     t_pcsource    => "00");

  constant S_WB_FUN : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "01",
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_BEQ : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '1',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "00",
     t_aluop       => C_SUB,
     t_pcsource    => "01");

  constant S_EX_J : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "10");

  constant S_EX_ADDI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "10",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_ANDI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "10",
     t_aluop       => C_AND,
     t_pcsource    => "00");

  constant S_EX_ORI : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "10",
     t_aluop       => C_OR,
     t_pcsource    => "00");

  constant S_WB_IMD : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  constant S_EX_BNE : cont_sigset :=
    (t_pcwritenc   => '1',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "00",
     t_aluop       => C_SUB,
     t_pcsource    => "01");

  constant S_EX_JAL : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "00",
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "01",
     t_aluop       => C_ADD,
     t_pcsource    => "10");

  constant S_WB_JAL : cont_sigset :=
    (t_pcwritenc   => '0',
     t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => "10",
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => C_ADD,
     t_pcsource    => "00");

  
  type T_PHASE is (FETCH, DECODE, EX_LS, MEM_LW, WB_LW, MEM_SW, EX_FUN, WB_FUN, EX_BEQ, EX_J, EX_ADDI, EX_ANDI, EX_ORI, WB_IMD, EX_BNE, EX_JAL, WB_JAL);  --
  -- phase types

  type T_STATESET is array (T_PHASE range <>) of cont_sigset;

  constant stateset : T_STATESET(FETCH to WB_JAL) := (S_FETCH, S_DECODE, S_EX_LS, S_MEM_LW, S_WB_LW, S_MEM_SW, S_EX_FUN, S_WB_FUN, S_EX_BEQ, S_EX_J, S_EX_ADDI, S_EX_ANDI, S_EX_ORI, S_WB_IMD, S_EX_BNE, S_EX_JAL, S_WB_JAL);

  constant SPEC : std_logic_vector(5 downto 0) := "000000";
  constant J    : std_logic_vector(5 downto 0) := "000010";
  constant JAL  : std_logic_vector(5 downto 0) := "000011";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";
  constant BNE  : std_logic_vector(5 downto 0) := "000101";
  constant ADDI : std_logic_vector(5 downto 0) := "001000";
  constant ANDI : std_logic_vector(5 downto 0) := "001100";
  constant ORI  : std_logic_vector(5 downto 0) := "001101";
  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";

end controller_pack;
