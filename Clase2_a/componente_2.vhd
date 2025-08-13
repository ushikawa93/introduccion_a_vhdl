
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity componente_2 is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;

			-- Output ports
			Y	: out std_logic
		);
		
	end componente_2;	
	
	architecture arch of componente_2 is
	
	begin	
	process(A,B)

	begin
		if((B = '0') or (A='0' and B='1')) then
			Y <= '1';
		else
			Y <= '0';
		end if;
		
	end process;
	
	end arch;
	
	
	
	
	
	
	
	
	
	
	
	