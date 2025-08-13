
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe is

port(
	clk : in std_logic;
	reset : in std_logic;
	
	dat_in : in std_logic_vector ( 7 downto 0);
	
	dat_out : out std_logic_vector ( 15 downto 0)

);

end entity;

architecture arch of pipe is

signal dat_0,dat_1,dat_2,dat_3,dat_4 : std_logic_vector( 15 downto 0);

begin

	process(clk,reset) is

	begin

		if (reset = '1') then
			dat_0 <= (others => '0');
			dat_1 <= (others => '0');
			dat_2 <= (others => '0');
			dat_3 <= (others => '0');
			dat_4 <= (others => '0');
			
		elsif (rising_edge (clk)) then
			
			dat_0 <= "00000000" & dat_in;		
			dat_1 <= dat_0; 	
			dat_2 <= dat_1; 		
			dat_3 <= dat_2; 
			
			dat_4 <= std_logic_vector( unsigned(dat_0) + unsigned(dat_1) + unsigned(dat_2) + unsigned(dat_3)); 		
			
			
		end if;
		
		dat_out <= dat_4;


	end process;

end arch;
