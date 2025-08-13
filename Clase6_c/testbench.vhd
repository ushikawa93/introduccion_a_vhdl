library ieee;
use ieee.std_logic_1164.all;

entity testbench is end entity;


architecture test of testbench is

constant N: integer := 4;

component Clase6_c is
generic( N : integer := 4 );
port(
	clk: in std_logic;
	reset : in std_logic;
	dat_in : in std_logic;
	enable : in std_logic;
	dat_out_valid : out std_logic;
	dat_out : out std_logic
);

end component;

signal clk, dat_in, enable, dat_out, reset, dat_out_valid : std_logic := '0';

begin

clk <= not(clk) after 10 ns;
reset <= '1', '0' after 20 ns;

process is begin

	
	wait for 40 ns;
	enable <= '1';
	
	-- Primer numero:
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '0';
	
	--  Segundo numero:
	wait for 20 ns;
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '1';
	
	wait for 20 ns;
	dat_in <= '0';
	
	
	wait for 20 ns;
	enable <= '0';
	wait for 200 ns;
	

end process;


u0: Clase6_c port map (clk,reset,dat_in,enable,dat_out_valid,dat_out);

end test;

