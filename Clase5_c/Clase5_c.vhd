
	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	entity Clase5_c is

	port (

		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		
		M : out std_logic_vector (7 downto 0);
		Mgenerico : out std_logic_vector (7 downto 0)

	);

	end entity;


	architecture arch of Clase5_c is

	signal zeroA,unA,dobleA,tripleA : std_logic_vector (5 downto 0);

	signal mult1,mult2 : std_logic_vector (5 downto 0);
	signal mult1_ext,mult2_ext : std_logic_vector (7 downto 0);

	component RippleCarry is
		generic ( N: integer := 4);
		port ( A : in std_logic_vector(N-1 downto 0);
				 B : in std_logic_vector(N-1 downto 0);
				 S : out std_logic_vector(N-1 downto 0));		 
	end component;

	begin

	zeroA <= "000000"; --(others => 0);
	unA <= "00" & A;
	dobleA <= '0' & A & '0';

	sum3: RippleCarry generic map(6) port map (unA,dobleA,tripleA);

	mult1 <= 
		zeroA when ( B(1) = '0' and B(0) = '0' ) else
		unA when ( B(1) = '0' and B(0) = '1' ) else 
		dobleA when ( B(1) = '1' and B(0) = '0' ) else
		tripleA when ( B(1) = '1' and B(0) = '1' ) else
		(others => '0');

	mult2 <= 
		zeroA when ( B(3) = '0' and B(2) = '0' ) else
		unA when ( B(3) = '0' and B(2) = '1' ) else 
		dobleA when ( B(3) = '1' and B(2) = '0' ) else
		tripleA when ( B(3) = '1' and B(2) = '1' ) else
		(others => '0');
		
	mult1_ext <= "00" & mult1;
	mult2_ext <= mult2 & "00"; -- mUltiplico por 4
	
	sum: RippleCarry generic map(8) port map (mult1_ext,mult2_ext,M);
	
	
	Mgenerico <= std_logic_vector ( unsigned(A) * unsigned(B) );

	end arch;



