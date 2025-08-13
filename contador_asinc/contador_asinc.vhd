
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity contador_asinc is
	
	generic
	(
		N : integer := 4
	
	);
		
	port
	(
		clk : in std_logic;
		reset : in std_logic;
		
		count : out std_logic_vector (N-1 downto 0)
	
	
	);
	
	end contador_asinc;
	
	architecture counter of contador_asinc is
	
	component FF_T is
	Port (
			T, CLK, SET, RESET : in STD_LOGIC;
			Q, Q_N             : out STD_LOGIC
		);
	end component;	
	
	signal q : std_logic_vector (N-1 downto 0);
	
	
	begin
	
	ff0: FF_T port map ('1',clk,'0',reset,q(0),open);
	
	gen:
	for i in 1 to N-1  generate 
		ff_i: FF_T port map ('1',q(i-1),'0',reset,q(i),open);
	end generate;
	
--	ff1: FF_T port map ('1',q(0),'0',reset,q(1),open);
--	
--	ff2: FF_T port map ('1',q(1),'0',reset,q(2),open);
--	
--	ff3: FF_T port map ('1',q(2),'0',reset,q(3),open);
	
	count <= q;
	
	
	end counter;