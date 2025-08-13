
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity Clase2_a is
	
		generic
		(
			N : integer := 8	
		);
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;
			
			C : in std_logic_vector ( N-1 downto 0);
			D : in std_logic_vector ( N-1 downto 0);
			
			Z : out std_logic_vector ( N-1 downto 0);

			-- Output ports
			Y1	: out std_logic;
			Y2 : out std_logic
		);
		
	end Clase2_a;
	
	architecture arch of Clase2_a is
	
	component componente_1 is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;

			-- Output ports
			Y	: out std_logic
		);
		
	end component;	

	
	component componente_2 is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;

			-- Output ports
			Y	: out std_logic
		);
		
	end component;
	
		
	begin
	
		u1: componente_1 port map( A => A, B => B ,Y => Y1 );		
		u2: componente_2 port map( A,B,Y2);		
		
--		u3: componente_1 port map(C(0),D(0),Z(0));
--		u4: componente_1 port map(C(1),D(1),Z(1));
--		u5: componente_1 port map(C(2),D(2),Z(2));
--		u6: componente_1 port map(C(3),D(3),Z(3));
		
		label1:
		for i in 0 to N-1 generate
			ux: componente_1 port map (C(i),D(i),Z(i));
		end generate;
		
	
	end arch;
	
	