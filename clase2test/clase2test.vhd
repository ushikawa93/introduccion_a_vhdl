
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity clase2test is
	
	port(
		
			A : in std_logic;
			B : in std_logic_vector (1 downto 0);
			
			C1 : out std_logic;
			C2 : out std_logic
	
	);	
	
	end clase2test;
	
	architecture arch of clase2test is
	
	begin
	
		op1: C1 <= '1' when B = "01" else
					  '1' when B = "11" else '0';
		
		op2: with B select
			  C2 <= '1' when "01",
					  '1' when "11",
					  '0'when others;
					  
	
	end architecture;
	