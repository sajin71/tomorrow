library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_tb is
	PORT ( MCLK1    : in  STD_LOGIC;
	       LED7SEG  : out STD_LOGIC_VECTOR(0 to 7);
			 LEDDYN   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end top_tb;

architecture top of top_tb is
component c_led7seg is
	PORT ( clk      : in  STD_LOGIC;
	       data     : in  STD_LOGIC_VECTOR(15 downto 0);
			 dp       : in  STD_LOGIC_VECTOR(3 downto 0);
	       LED7SEG  : out STD_LOGIC_VECTOR(0 to 7);
			 LEDDYN   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end component;

	signal counter : STD_LOGIC_VECTOR(39 downto 0) := x"0000000000";

begin

	led: c_led7seg port map (
		clk => MCLK1,
		LED7SEG => LED7SEG,
		LEDDYN  => LEDDYN,
		data => counter(39 downto 24),
		dp => "0100"
	);
	
	countup: process(MCLK1)
	begin
		if RISING_EDGE(MCLK1) then
			counter <= counter + 1;
		end if;
	end process countup;

end top;
