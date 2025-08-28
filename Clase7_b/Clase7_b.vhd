
library ieee;
use ieee.std_logic_1164.all;

entity Clase7_b is

	port(		
		FPGA_CLK1_50: in std_logic;
		KEY : in std_logic_vector (1 downto 0);
		SW: in std_logic_vector (3 downto 0);		
		LED : out std_logic_vector(3 downto 0)
	);

end Clase7_b;

	architecture arch of Clase7_b is

	signal clk : std_logic;

	component nios_system is
		 port (
			  clk_clk        : in std_logic                    := 'X';             -- clk
			  reset_reset_n  : in std_logic                    := 'X';             -- reset_n
			  data_in_export : in std_logic_vector(7 downto 0) := (others => 'X')  -- export
		 );
	end component nios_system;

	signal data_in : std_logic_vector(7 downto 0);

	begin

	clk <= FPGA_CLK1_50;
	data_in <= "0000" & sw;

	u0 : component nios_system
		 port map (
			  clk_clk        => clk,        --     clk.clk
			  reset_reset_n  => key(0),  --   reset.reset_n
			  data_in_export => data_in  -- data_in.export
	);


	end arch;


