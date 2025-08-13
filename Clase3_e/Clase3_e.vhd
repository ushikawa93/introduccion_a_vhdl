	
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase3_e is

		 Port (
			  D, CLK, SET, RESET, enable : in STD_LOGIC;
			  Q, Q_N             : out STD_LOGIC
		 );
		 
	end Clase3_e;

	architecture Behavioral of Clase3_e is		 
		 
	begin
		 
		 q <= '0' when RESET = '1' else
				'1' when SET = '1' else
				d when clk'event and clk = '1' and enable = '1';
		 
	end Behavioral;
	
	
	
	
	
	