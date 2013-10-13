library ieee;
use ieee.std_logic_1164.all;
use tomorrow_1.ram_component_pack.all;

entity ram is
  
  generic (
    BRAMBW : integer := 15);

  port (
    CLK        : in  std_logic;
    PC         : in  std_logic_vector(31 downto 0);
    FROMALU    : in  std_logic_vector(31 downto 0);
    DATA_WRITE : in  std_logic_vector(31 downto 0);
    IR         : out std_logic_vector(31 downto 0);
    MDR        : out std_logic_vector(31 downto 0);
    MemWrite   : in  std_logic;
    IRWrite    : in  std_logic);

end ram;


architecture RTL of ram is
  signal addra : std_logic_vector(BRAMBW-1 downto 0);
  signal addrb : std_logic_vector(BRAMBW-1 downto 0);
  signal enb : std_logic;
  signal wea : std_logic;
  signal dia : std_logic_vector(31 downto 0);
  signal saddr : std_logic_vector(19 downto 0);
  signal sw : std_logic;

  signal memwrite : std_logic;
  signal topbit : std_logic;
  signal data : std_logic_vector(31 downto 0);
  signal doa : std_logic_vector(31 downto 0);
  signal dq : std_logic_vector(31 downto 0);
  
begin  -- RTL

  input_map : ram_input_control
    generic map (
      BRAMBW => BRAMBW)
    port map (
      PC         => PC,
      FROMALU    => FROMALU,
      DATA_WRITE => DATA_WRITE,
      MEMWRITE   => MemWrite,
      IRWRITE    => IRWrite,
      ADDRA      => addra,
      ADDRB      => addrb,
      ENB        => enb,
      WEA        => wea,
      DIA        => dia,
      SADDR      => saddr,
      SW         => sw);

  input_blockram_map : blockram
    generic map (
      BRAMBW => BRAMBW)
    port map (
      CLK       => CLK,
      ADDRA     => addra,
      ADDRB     => addrb,
      DATA_INA  => dia,
      DATA_OUTA => doa,
      DATA_OUTB => IR,
      ENB       => enb,
      WEA       => wea);

end RTL;
