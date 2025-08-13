
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity componente_1 is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;

			-- Output ports
			Y	: out std_logic
		);
		
	end componente_1;
	
	
	
	architecture arch of componente_1 is
	
	
	begin
		Y <= not(B) or ( not(A) and B );	
	end arch;
	
	
	