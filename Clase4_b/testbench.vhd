
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity testbench is end entity testbench;
	
	architecture test of testbench is
	
	constant N : integer := 8;
	
	component Clase4_b is 
	
		generic
		(
			N : integer := 4
		);
		
		
		port (
			
			clk : in std_logic;
			reset : in std_logic;
			
			count : out std_logic_vector(N-1 downto 0)
		
		);
		
		end component;
	
	signal clk_tb : std_logic := '0';
	signal reset_tb : std_logic :='0';
	signal count_tb : std_logic_vector (N-1 downto 0);
	
	begin
	
	clk_tb <= not(clk_tb) after 10 ns;
	reset_tb <= '1','0' after 40 ns;
	
	tb: Clase4_b generic map (N) port map (clk_tb,reset_tb,count_tb);
	
	
	end test;
	
	
	
	