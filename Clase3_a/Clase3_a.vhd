
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity Clase3_a is
	
		port(
		
			D: in std_logic;
			clk: in std_logic;
			rst_n: in std_logic;
			set: in std_logic;
			enable : in std_logic;
			
			Q: out std_logic
			
		);
	
	end entity;
	
	architecture arch of Clase3_a is	
	
	begin
	
		process(D,clk,rst_n,set)
		
		begin
		
			if(rst_n = '0') then
				Q <= '0';
			elsif(set = '1') then
				Q <= '1';
			elsif(enable = '1' and rising_edge(clk)) then
				Q <= D;
			end if;		
		
		end process;
	
	
	end arch;
	
	
	