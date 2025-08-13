library ieee;
use ieee.std_logic_1164.all;

	entity Clase3_d is

	port
	(
		-- Input ports
		clk	: in  std_logic;
		dat	: in  std_logic;

		-- Output ports
		out1	: out std_logic
	);
	end Clase3_d;


	architecture arch of Clase3_d is
	
	signal dat_1,dat_2 :std_logic := '0';
	
	component FF_D is
    Port (
        D, CLK, SET, RESET : in STD_LOGIC;
        Q, Q_N             : out STD_LOGIC
    );
	end component;
		
	begin
	
	u0: FF_D port map (dat,clk,'0','0',dat_1,open);
	u1: FF_D port map (dat_1,clk,'0','0',dat_2,open);
	
	out1 <= not(dat_2) and dat_1;		

	end arch;
