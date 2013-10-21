library ieee;
use ieee.std_logic_1164.all;

library tomorrow_1;
use tomorrow_1.controller_pack.all;

entity controller is
  
  port (
    CLK         : in  std_logic;
    OP          : in  std_logic_vector(5 downto 0);
    PCWriteCond : out std_logic;
    PCWrite     : out std_logic;
    MemWrite    : out std_logic;
    MemtoReg    : out std_logic;
    IRWrite     : out std_logic;
    RegDst      : out std_logic;
    RegWrite    : out std_logic;
    ALUSrcA     : out std_logic;
    ALUSrcB     : out std_logic_vector(1 downto 0);
    ALUOp       : out std_logic_vector(1 downto 0);
    PCSource    : out std_logic_vector(1 downto 0)
    );

end controller;


architecture RTL of controller is
  signal statenum      : integer := 0;
  signal outstate      : cont_sigset;
  signal next_statenum : integer;

begin  -- RTL

  outstate <= stateset(statenum);

  next_statenum <= 0 when statenum = 4 or statenum = 5 or statenum = 7 or statenum = 8 or statenum = 9 else
                   1 when statenum = 0                          else
                   2 when statenum = 1 and (OP = LW or OP = SW) else
                   3 when statenum = 2 and OP = LW              else
                   4 when statenum = 3                          else
                   5 when statenum = 2 and OP = SW              else
                   6 when statenum = 1 and OP = SPEC            else
                   7 when statenum = 6                          else
                   8 when statenum = 1 and OP = BEQ             else
                   9 when statenum = 1 and OP = J               else
                   0;

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

  latch: process (CLK)
  begin  -- process latch
    if rising_edge(CLK) then
      statenum <= next_statenum;
    end if;
  end process latch;
  
end RTL;
