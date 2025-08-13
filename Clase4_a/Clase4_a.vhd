	
	
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase4_a is
		 generic (
			  N : integer := 16  -- Tamaño del contador
		 );
		 port (
			  clk   : in  std_logic;
			  reset : in  std_logic;
			  count : out std_logic_vector(N-1 downto 0)
		 );
	end entity;

	architecture count of Clase4_a is

		 component FF_T is
			  port (
					T, CLK, SET, RESET : in  std_logic;
					Q, Q_N             : out std_logic
			  );
		 end component;

		 signal count_aux : std_logic_vector(N-1 downto 0);

	begin

		 FF_T_0 : FF_T
					port map (
						 T     => '1',	CLK   => clk, SET   => '0', RESET => reset,
						 Q     => count_aux(0),	 Q_N   => open
						 );		
		
		 gen_ff: for i in 1 to N-1 generate
		 begin
			  FF_T_inst : FF_T
					port map (
						 T     => '1',CLK   => count_aux(i-1), SET   => '0',
						 RESET => reset,Q     => count_aux(i), Q_N   => open
					);
		 end generate;

		 count <= count_aux;

	end architecture;
	