
	library ieee;
	use ieee.std_logic_1164.all;

	entity FSub is

	port 
	(
		A : in std_logic;
		B : in std_logic;
		
		Ci : in std_logic;
		
		S : out std_logic;
		Co : out std_logic

	);

	end entity;

	architecture restar of FSub is
	begin

		S <= A xor B xor Ci;
		Co <= (not(A) and B) or (not(A) and Ci) or (B and Ci);

	end restar;



