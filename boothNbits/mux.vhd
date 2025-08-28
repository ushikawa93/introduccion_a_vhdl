library ieee;
use ieee.std_logic_1164.all;


entity mux4a1 is 
generic (N : integer := 8);
port (

	sel : in std_logic_vector ( 1 downto 0);
	
	dat_in_0 : in std_logic_vector ( N-1 downto 0);
	dat_in_1 : in std_logic_vector ( N-1 downto 0);
	dat_in_2 : in std_logic_vector ( N-1 downto 0);
	dat_in_3 : in std_logic_vector ( N-1 downto 0);
	
	dat_out : out std_logic_vector ( N-1 downto 0)

);
end entity;


architecture arch of mux4a1 is

begin

process (sel) is begin

	if(sel = "00") then
		dat_out <= dat_in_0;
	elsif (sel = "01")then
		dat_out <= dat_in_1;
	elsif (sel = "10")then
		dat_out <= dat_in_2;
	elsif (sel = "11")then
		dat_out <= dat_in_3;
	else
		dat_out <= (others => '0');
	end if;
end process;

end arch;


