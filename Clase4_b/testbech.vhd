
library ieee;
use ieee.std_logic_1164.all;


entity testbench is end entity;


architecture test of testbench is

constant N : integer := 4;

component Clase4_b is

	generic
	(
		N : integer := N
	);	
	
	port
	(
		clk : in std_logic;
		dat_in : in std_logic;
		reset : in std_logic;
		enable : in std_logic;
		
		dat_out : out std_logic_vector (N-1 downto 0)
	
	);

end component;

signal clk_tb : std_logic := '0';
signal dat_in_tb : std_logic := '0';
signal reset_tb : std_logic := '0';
signal enable_tb : std_logic := '0';

signal dat_out_tb : std_logic_vector (N-1 downto 0) := (others =>'0');

	begin
	clk_tb <= not(clk_tb) after 10 ns;
	coso: Clase4_b port map (clk_tb,dat_in_tb,reset_tb,enable_tb,dat_out_tb);
	process
	begin

		reset_tb <= '1';
		wait for 40 ns;
		reset_tb <= '0';
		
		enable_tb <= '1';
		
		wait for 20 ns;
		dat_in_tb <= '0';
		
		wait for 20 ns;
		dat_in_tb <= '1';
		
		wait for 20 ns;
		dat_in_tb <= '1';
		
		wait for 20 ns;
		dat_in_tb <= '0';
		
		wait for 20 ns;
		enable_tb <= '0';
		
		wait for 40 ns;

	end process;


	end test;