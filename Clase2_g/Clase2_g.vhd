
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase2_g is
	
		port 
		(
			A	 : in  std_logic_vector(7 downto 0);
			sel : in  integer range 0 to 7;


			-- Output ports
			B	: out std_logic
	);
	end Clase2_g;
	
	architecture arch of Clase2_g is
	
	component MuxGenerico is
		 generic (
			  N : integer := 4  -- Número de entradas
		 );
		 port (
			  inputs : in  std_logic_vector(N-1 downto 0);
			  sel    : in  integer range 0 to N-1;
			  y      : out std_logic
		 );
	end component;
		
	begin
		
	u0: MuxGenerico generic map (4) port map (A,sel,B);
	
	end arch;
	
