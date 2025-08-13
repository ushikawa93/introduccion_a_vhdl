
library ieee;
use ieee.std_logic_1164.all;

entity registro is

generic( N : integer := 4);

port ( 
	
	clk : in std_logic;
	D : in std_logic_vector (N-1 downto 0);
	reset : in std_logic;
	set : in std_logic;
	enable : in std_logic;
	Q : out std_logic_vector (N-1 downto 0);
	Q_n : out std_logic_vector (N-1 downto 0)

 );
 
end entity;

architecture arch of registro is

component FF_D is
    Port (
        D, CLK, SET, RESET, ENABLE: in STD_LOGIC;
        Q, Q_N             : out STD_LOGIC
    );
end component;

begin

gen:
for i in 0 to N-1 generate
	ff_i: FF_D port map (D(i),clk,set,reset,enable,Q(i),Q_n(i));	
end generate;

end arch;
