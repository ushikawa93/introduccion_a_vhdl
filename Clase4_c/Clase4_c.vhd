
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase4_c is

	port(
		
		clk : in std_logic;
		reset : in std_logic;
		dat_a : in std_logic;
		dat_b : in std_logic;
		
		dat_out : out std_logic

	);

	end Clase4_c;


	architecture test of Clase4_c is

	component FF_D is
		 Port (
			  D, CLK, SET, RESET, ENABLE: in STD_LOGIC;
			  Q, Q_N             : out STD_LOGIC
		 );
	end component;

	signal reg_a, reg_b, signal_out, reg_out : std_logic;

	begin 
		
	ff_1: FF_D port map (dat_a,clk,'0',reset,'1',reg_a,open);
	ff_2: FF_D port map (dat_b,clk,'0',reset,'1',reg_b,open);


	--signal_out <= (reg_a and reg_b); -- Mas Rapido
	signal_out <= (reg_a xor reg_b);	  -- Mas Lento

	ff_3: FF_D port map (signal_out,clk,'0',reset,'1',reg_out,open);

	dat_out <= reg_out;

	end test;
