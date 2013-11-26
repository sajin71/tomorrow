LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
-- USE ieee.numeric_std.ALL;

ENTITY top_tb IS
END top_tb;

ARCHITECTURE behavior OF top_tb IS 


  component fmul
    port (
      a, b : in  std_logic_vector(31 downto 0);
      clk  : in  std_logic;
      q    : out std_logic_vector(31 downto 0));
  end component;

  signal CLK : std_logic := '0';

  -- test
  file  READ_FILE : text open read_mode is "in.dat"; 
  file WRITE_FILE : text open write_mode is "out_sim_mul.dat";

  signal count : std_logic_vector(1 downto 0) := "00";
  signal in_a,in_b,out_c : std_logic_vector(31 downto 0);
  signal ready : std_logic := '0';

begin

    clkgen: process
    begin  -- process clkgen
      CLK <= '0';
      wait for 7 ns;
      CLK <= '1';
      wait for 7 ns;
    end process clkgen;

    test: process(CLK,ready)
    variable lin,lout : line;
    variable var_a,var_b :std_logic_vector(31 downto 0);    
    begin  -- process test
      if rising_edge(CLK) then
        if count = "00" then
          
          if ready = '1' then
            write(lout,out_c,right,32);
            writeline(WRITE_FILE,lout);
          end if;
          
          ready <= '1';
          readline(READ_FILE,lin);
          read(lin,var_a);
          readline(READ_FILE,lin);     
          read(lin,var_b);
          in_a <= var_a;
          in_b <= var_b;
          count <= "11";
        else
          count <= count -1;
        end if;
      end if;
          
    end process test;

    mul: fmul port map (in_a,in_b,CLK,out_c);

end;
