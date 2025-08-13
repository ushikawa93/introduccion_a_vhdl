
	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	entity SumadorGenerico is
		generic ( N : integer := 4);
		
		port 
		(	
			A : in std_logic_vector (N-1 downto 0);
			B : in std_logic_vector (N-1 downto 0);
			
			S : out std_logic_vector (N-1 downto 0)
		);
		
	end entity;

	architecture sumador of SumadorGenerico is

	begin

	S <= std_logic_vector ( unsigned(A) + unsigned(B) );

	end sumador;
 
 
 