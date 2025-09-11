
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EjFinal is 

port ( x : in std_logic_vector ( 11 downto 0 );
		 clk : in std_logic;
		 reset_n : in std_logic;
		 
		 y : out std_logic_vector ( 31 downto 0 ) );
		 
end EjFinal;

architecture arch of EjFinal is

constant B0 : std_logic_vector ( 12 downto 0) := std_logic_vector(to_signed(   138, 13)); -- 138
constant B1 : std_logic_vector ( 12 downto 0) := std_logic_vector(to_signed(   276, 13)); -- 276 
constant B2 : std_logic_vector ( 12 downto 0) := std_logic_vector(to_signed(   138, 13)); -- 138

constant A1 : std_logic_vector ( 12 downto 0) := std_logic_vector(to_signed(   2340, 13)); -- 2340
constant A2 : std_logic_vector ( 12 downto 0) := std_logic_vector(to_signed(   -845, 13)); -- -845

signal x0,x1,x2 : std_logic_vector ( 11 downto 0);
signal y0,y1,y2 : std_logic_vector ( 31 downto 0);

begin

process (clk,reset_n) is
    variable aux : signed(47 downto 0);
begin
    if (reset_n = '0') then
        x0 <= (others => '0');
        x1 <= (others => '0');
        x2 <= (others => '0');
        y0 <= (others => '0');
        y1 <= (others => '0');
        y2 <= (others => '0');
    
    elsif rising_edge(clk) then
        x0 <= x;
        x1 <= x0;
        x2 <= x1;

        aux :=  resize(signed(B0) * signed(x0), 48) +
					 resize(signed(B1) * signed(x1), 48) +
					 resize(signed(B2) * signed(x2), 48) +
					 resize(signed(A1) * signed(y1), 48) +
					 resize(signed(A2) * signed(y2), 48) ;
			
		  y0 <= std_logic_vector(aux(47 downto 16));
        y1 <= y0;
        y2 <= y1;
		  
    end if;
end process;


y <= y0;





end arch;

		 
		 