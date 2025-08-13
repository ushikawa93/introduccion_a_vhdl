
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clase3_c is
	Port (
			T, CLK, SET, RESET : in STD_LOGIC;
			Q, Q_N             : out STD_LOGIC
		);
end Clase3_c;

	architecture Behavioral of Clase3_c is
		 signal state : STD_LOGIC := '0';
	begin
		 process(CLK, RESET, SET)
		 begin
			  if RESET = '1' then
					state <= '0';
					
			  elsif SET = '1' then
					state <= '1';
					
			  elsif rising_edge(CLK) then
					if T = '1' then
						 state <= not state;
					end if;
			  end if;
		 end process;

		 Q <= state;
		 Q_n <= not state;
	end Behavioral;

