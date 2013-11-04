library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity c_led7seg is
	PORT ( clk      : in  STD_LOGIC;
	       data     : in  STD_LOGIC_VECTOR(15 downto 0);
			 dp       : in  STD_LOGIC_VECTOR(3 downto 0);
	       LED7SEG  : out STD_LOGIC_VECTOR(0 to 7);
			 LEDDYN   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end c_led7seg;

architecture RTL of c_led7seg is
	signal counter  : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
	signal nowdigit : STD_LOGIC_VECTOR(1 downto 0);
--	signal isclear  : STD_LOGIC;

	signal showing  : STD_LOGIC_VECTOR(3 downto 0);

begin

--	isclear <= '0';
	nowdigit <= counter(15 downto 14);
	LEDDYN <= --@"0000" when isclear='1' else
	          "0001" when nowdigit=0 else
				 "0010" when nowdigit=1 else
				 "0100" when nowdigit=2 else
				 "1000" when nowdigit=3;
				 
	showing <= data(15 downto 12) when nowdigit=3 else
				  data(11 downto 8)  when nowdigit=2 else
				  data(7  downto 4)  when nowdigit=1 else
				  data(3  downto 0);
	LED7SEG(0 to 6) <= "1111110" when showing=x"0" else
	                   "0110000" when showing=x"1" else
	                   "1101101" when showing=x"2" else
	                   "1111001" when showing=x"3" else
							 "0110011" when showing=x"4" else
							 "1011011" when showing=x"5" else
							 "1011111" when showing=x"6" else
	                   "1110010" when showing=x"7" else
							 "1111111" when showing=x"8" else
							 "1111011" when showing=x"9" else
	                   "1110111" when showing=x"A" else
							 "0011111" when showing=x"b" else
							 "1001110" when showing=x"C" else
							 "0111101" when showing=x"d" else
							 "1001111" when showing=x"E" else
	                   "1000111" when showing=x"F";
	LED7SEG(7) <= dp(conv_integer(nowdigit)); --DP						 


	countup: process(clk)
	begin
		if RISING_EDGE(clk) then
			counter <= counter + 1;
--			isclear <= '0';
		end if;
	end process countup;
	
--	clearing: process(counter(19))
--	begin
--		if RISING_EDGE(counter(19)) then
--			isclear <= '1';
--		end if;
--	end process clearing;	
	
end RTL;

