
library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
	
	port
	(
		-- Input ports
		D	: in  std_logic;
		clk	: in  std_logic;
		
		reset_n : in std_logic; -- activa en bajo
		set : in std_logic;
		enable : in std_logic;

		-- Inout ports
		Q	: out std_logic;
		Q_n : out std_logic
	);
end ff_d;


architecture comportamiento of ff_d is

	signal Q_reg : std_logic := '0';

	begin

	process(set,reset_n,clk) 
	begin
	
		if(reset_n = '0') then
				Q_reg <= '0';
				
		elsif (set = '1') then
				Q_reg <= '1';
	
		elsif(rising_edge(clk) and (enable = '1') )	then				
				Q_reg <= D;
				
		else 
			Q_reg <= Q_reg;
				
		end if;
	
	end process;
		
	Q <= Q_reg;
	Q_n <= not (Q_reg);

end comportamiento;


