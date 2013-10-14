library ieee;
use ieee.std_logic_1164.all;

package controller_pack is
  type cont_sigset is record            -- output signal set record
    t_pcwritecond : std_logic;
    t_pcwrite     : std_logic;
    t_memwrite    : std_logic;
    t_memtoreg    : std_logic;
    t_irwrite     : std_logic;
    t_regdst      : std_logic;
    t_regwrite    : std_logic;
    t_alusrca     : std_logic;
    t_alusrcb     : std_logic_vector(1 downto 0);
    t_aluop       : std_logic_vector(1 downto 0);
    t_pcsource    : std_logic_vector(1 downto 0);
  end record;

  type t_stateset is array (0 to 9) of cont_sigset;  -- stateset type

  constant stateset : t_stateset := (
    (t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '1',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "01",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "11",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "10",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '1',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '1',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "00",
     t_aluop       => "10",
     t_pcsource    => "00"),
    (t_pcwritecond => '0',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '1',
     t_regwrite    => '1',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => "00",
     t_pcsource    => "00"),
    (t_pcwritecond => '1',
     t_pcwrite     => '0',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '1',
     t_alusrcb     => "00",
     t_aluop       => "01",
     t_pcsource    => "01"),
    (t_pcwritecond => '0',
     t_pcwrite     => '1',
     t_memwrite    => '0',
     t_memtoreg    => '0',
     t_irwrite     => '0',
     t_regdst      => '0',
     t_regwrite    => '0',
     t_alusrca     => '0',
     t_alusrcb     => "00",
     t_aluop       => "00",
     t_pcsource    => "10"));

  constant SPEC : std_logic_vector(5 downto 0) := "000000";
  constant J    : std_logic_vector(5 downto 0) := "000010";
  constant BEQ  : std_logic_vector(5 downto 0) := "000100";
  constant LW   : std_logic_vector(5 downto 0) := "100011";
  constant SW   : std_logic_vector(5 downto 0) := "101011";

end controller_pack;
