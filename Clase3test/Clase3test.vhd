

library ieee;
use ieee.std_logic_1164.all;

entity Clase3test is

	port 
	(
			-- Input ports
		dat	: in  std_logic;
		clk	: in  std_logic;
		
		out_aux_1 : out std_logic;
		out_aux_2 : out std_logic;
		
		A,B,C : in std_logic;
		
		out1 : out std_logic;
		out2 : out std_logic
	
	);
end entity;


architecture arch of Clase3test is

signal Q1,aux4,Q2 : std_logic;


component ff_d is
	
	port
	(
		-- Input ports
		D	: in  std_logic;
		clk	: in  std_logic;
		
		reset_n : in std_logic; -- activa en bajo
		set : in std_logic;
		enable : in std_logic;

		-- Inout ports
		Q	: out std_logic;
		Q_n : out std_logic
	);
	
end component;

begin

	u0: ff_d port map (dat,clk,'1','0','1',aux4,open);
	
	
	Q1 <= ((aux4 and A and D) or (B xor C)) and (a xor C);
	
	u2: ff_d port map (Q1,clk,'1','0','1',Q2,open);
	
	
	-- Q1 valor "actual" de la señal dat
	-- Q2 valor previo de la señal dat
	
	out1 <= Q1 and not(Q2);
	out2 <= not(Q1) and Q2;
	
--	process begin
--		if(rising_edge(dat))
		---
--	end
	
	out_aux_1 <= Q1;
	out_aux_2 <= Q2;

end arch;




