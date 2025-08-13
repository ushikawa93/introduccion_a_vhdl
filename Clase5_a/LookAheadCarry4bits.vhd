	
	library ieee;
	use ieee.std_logic_1164.all;

	entity LookAheadCarry4bits is
		 port (
			  A : in std_logic_vector(3 downto 0);
			  B : in std_logic_vector(3 downto 0);
			  cin : in std_logic;
			  S : out std_logic_vector(3 downto 0);
			  cout : out std_logic
		 );
	end entity;

	architecture Behavioral of LookAheadCarry4bits is
		 signal G, P : std_logic_vector(3 downto 0); -- Generate and Propagate
		 signal C : std_logic_vector(4 downto 0);    -- Carry vector (C(0) = 0)
	begin

		 -- Inicialización del carry-in
		 C(0) <= cin;

		 -- Generate y Propagate
		 G <= A and B;
		 P <= A xor B;

		 -- Carry Look-Ahead Logic (expansión completa)
		 C(1) <= G(0) or (P(0) and C(0));
		 C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and C(0));
		 C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and C(0));
		 C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or 
					(P(3) and P(2) and P(1) and G(0)) or 
					(P(3) and P(2) and P(1) and P(0) and C(0));
					
    -- Suma final
    S(0) <= P(0) xor C(0);
    S(1) <= P(1) xor C(1);
    S(2) <= P(2) xor C(2);
    S(3) <= P(3) xor C(3);
	 
	 cout <= C(4);

	end architecture;

	
	