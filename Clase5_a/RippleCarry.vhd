
library ieee;
use ieee.std_logic_1164.all;

entity RippleCarry is

generic ( N: integer := 4);

port ( A : in std_logic_vector(N-1 downto 0);
		 B : in std_logic_vector(N-1 downto 0);
		 S : out std_logic_vector(N-1 downto 0));
		 
end RippleCarry;

architecture arch of RippleCarry is

signal C : std_logic_vector (N downto 0);

	component FA is
		port 
		(
			A : in std_logic;
			B : in std_logic;	
			Ci : in std_logic;	
			S : out std_logic;
			Co : out std_logic
		);
	end component;

begin

	C(0) <= '0';

	gen:
	for i in 0 to N-1 generate	
		fa_i: FA port map ( A(i),B(i),C(i),S(i),C(i+1));
	end generate;
	
end arch;

