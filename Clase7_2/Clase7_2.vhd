

library ieee;
use ieee.std_logic_1164.all;

entity Clase7_2 is

port(
	 
	FPGA_CLK1_50 : in std_logic;
	KEY : in std_logic_vector (1 downto 0);
	SW : in std_logic_vector ( 3 downto 0)

 );
 
 end entity;
 
  
 architecture arch of Clase7_2 is 
 
 
 component nios is
     port (
        clk_clk        : in std_logic                    := 'X';             -- clk
        reset_reset_n  : in std_logic                    := 'X';             -- reset_n
        data_in_export : in std_logic_vector(7 downto 0) := (others => 'X')  -- export
     );
 end component nios;
 
 begin
 
 
 
 
 u0 : component nios
        port map (
            clk_clk        => FPGA_CLK1_50,        --     clk.clk
            reset_reset_n  => KEY(0),  --   reset.reset_n
            data_in_export => "0000" & SW  -- data_in.export
        );
 
 end arch;
