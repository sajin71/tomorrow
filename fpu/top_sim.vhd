library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  Port ( clk : in  STD_LOGIC;
         RS_TX : out  STD_LOGIC);
end top;

architecture example of top is
  signal countdown : std_logic_vector(1 downto 0) := (others => '1');
  signal rom_o : std_logic_vector(7 downto 0);
  signal uart_busy : std_logic := '0';
  signal uart_go : std_logic := '0';
  signal counter : std_logic_vector(5 downto 0) := (others => '0');
  signal in_a,in_b,tmp,out_fadd : std_logic_vector(31 downto 0);
  signal ready : std_logic := '0';                    
  
  component u232c
    generic (wtime: std_logic_vector(15 downto 0) := x"1B10");
    Port ( clk  : in  std_logic;
           data : in  std_logic_vector(7 downto 0);
           go   : in  std_logic;
           busy : out std_logic;
           tx   : out std_logic);
  end component;

  component fadd
    port (
      a, b : in  std_logic_vector(31 downto 0);
      clk  : in  std_logic;
      q    : out std_logic_vector(31 downto 0));
  end component;
  
begin
  --ib: IBUFG port map (
  --  i=>MCLK1,
  --  o=>iclk);
  --bg: BUFG port map (
  --  i=>iclk,
  --  o=>clk);
  rs232c: u232c generic map (wtime=>x"1B10")
  port map (
    clk=>clk,
    data=>rom_o,
    go=>uart_go,
    busy=>uart_busy,
    tx=>rs_tx);

  add_float : fadd port map (
    a   => in_a,
    b   => in_b,
    clk => clk,
    q   => out_fadd);

  
  add : process(clk)
  begin
    if rising_edge(clk) then
      if countdown = "00" then
        if ready = '0' then
          tmp <= out_fadd;
          ready <= '1';
        end if;
        
        if uart_busy = '0' and uart_go = '0' then
          if ready = '1' then
            if counter /= "100000" then
              rom_o <= "0011000" & tmp(conv_integer (counter));
              uart_go <= '1';
            end if;
          end if;
		  elsif uart_go = '1' then 
          uart_go <= '0';
			 counter <= counter + 1;
        end if;
        
      elsif countdown = "11" then
        in_a <= "01010101000100100100100100100101";
        in_b <= "10100010101101101001000100101101";
        countdown <= countdown - 1;
        uart_go <= '0';
      else
        countdown <= countdown - 1;
      end if;
    end if;
  end process;

  
end example;
