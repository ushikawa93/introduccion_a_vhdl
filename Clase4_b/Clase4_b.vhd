
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase4_b is

		generic
		(
			N : integer := 4
		);		
		
		port
		(
			clk : in std_logic;
			dat_in : in std_logic;
			reset : in std_logic;
			enable : in std_logic;
			
			dat_out : out std_logic_vector (N-1 downto 0)
		
		);
	end entity;

	architecture rd_serie_paralelo of Clase4_b is

	component FF_D is
		 Port (
			  D, CLK, SET, RESET, ENABLE : in STD_LOGIC;
			  Q, Q_N             : out STD_LOGIC
		 );
	end component;

	signal q_aux : std_logic_vector (N downto 0) := (others => '0');

	begin

	ff_d_0: FF_D port map ( dat_in,clk,'0',reset,enable, q_aux(0),open );

	gen_rd:
	for i in 0 to N-2 generate
		
		ff_d_0: FF_D port map ( q_aux(i),clk,'0',reset,enable, q_aux(i+1),open );
		
	end generate;

	dat_out <= q_aux(N-1 downto 0);

	end rd_serie_paralelo;
	
	