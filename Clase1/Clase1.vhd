
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase1 is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;

			-- Output ports
			Y1	: out std_logic;
			Y2 : out std_logic;
			Y3 : out std_logic
		);
		
	end Clase1;

	architecture arch of Clase1 is

		signal C,D,E : std_logic;

	begin
		
		-- Sin simplificar y con señales intermedias:
		C <= A and not(B);
		D <= not(A) and B;
		E <= not(A) and not(B);
		
		Y1 <= C or D or E;
		
		-- Simplificado
		Y2 <= not(B) or ( not(A) and B );	
		
		-- Sino podria usarse un process..
		
		process(A,B)
		variable F,G,H : std_logic;
		begin
		
			if((A = '1') and (B = '0')) then
				F := '1';
			else
				F := '0';
			end if;
			
			if((A = '0') and (B = '1')) then
				G := '1';
			else
				G := '0';
			end if;
			
			if((A = '0') and (B = '0')) then
				H := '1';
			else
				H := '0';
			end if;
			
			if((F = '1') or (G = '1') or (H ='1')) then
				Y3 <= '1';
			else
				Y3 <= '0';
			end if;		
		end process;

	end arch;
