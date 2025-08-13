
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity testbench is end entity;
	
	architecture arch of testbench is
	
	constant N : integer := 16;
	
		component Clase4_a is
		
		 generic (
			  N : integer := N  -- Tamaño del contador
		 );
	
		port(
			
			clk : in std_logic;
			reset : in std_logic;
			
			count : out std_logic_vector (N-1 downto 0)
		
		);
		
		end component;
	
	signal clk : std_logic:= '0';
	signal reset : std_logic := '0';
	signal count : std_logic_vector( N-1 downto 0 );
	
	begin
	
	clk <= not(clk) after 10 ns;
	reset <= '1', '0' after 50 ns;	
	
	u0: Clase4_a port map (clk,reset,count);
	
	end arch;
	