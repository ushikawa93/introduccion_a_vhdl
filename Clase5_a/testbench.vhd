library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is end entity;


architecture test of testbench is

constant N: integer := 64;

component Clase5_a is
	generic(	N : integer := N );
	port 
	(
		clk : in std_logic;
		reset : in std_logic;
		A : in std_logic_vector (N-1 downto 0);
		B : in std_logic_vector (N-1 downto 0);		
		S : out std_logic_vector (N-1 downto 0)
	);
end component;

signal A,B,S : std_logic_vector(N-1 downto 0);

signal clk : std_logic := '0';
signal reset : std_logic;

begin

clk <= not(clk) after 10 ns;
reset <= '1', '0' after 40 ns;

A <= std_logic_vector(to_unsigned(54, N));
B <= std_logic_vector(to_unsigned(42, N));

u0: Clase5_a port map (clk,reset,A,B,S);

end test;

