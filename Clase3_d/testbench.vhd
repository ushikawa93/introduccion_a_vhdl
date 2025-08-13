
	library ieee;
	use ieee.std_logic_1164.all;

	entity testbench is 
	end entity testbench;


	architecture test of testbench is	
	
	component Clase3_d is

		port
		(
			-- Input ports
			clk	: in  std_logic;
			dat	: in  std_logic;

			-- Output ports
			out1	: out std_logic
		);
		end component;

		signal clock  : std_logic := '0';
		signal datos  : std_logic := '0';
		signal salida : std_logic;
		
	begin

		u0: Clase3_d port map (clock,datos,salida);

		clock <= not clock after 10 ns;
		
		process
		begin
			
			wait for 40 ns;
			datos <= '1';
			wait for 40 ns;
			datos <= '0';
			
		end process;
		

	end test;
	
	
	

