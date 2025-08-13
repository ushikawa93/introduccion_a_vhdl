
library ieee;
use ieee.std_logic_1164.all;


entity ripple_carry is

generic (N : integer := 32);

port(

	clk : in std_logic;
	reset : in std_logic;

	A : in std_logic_vector(N-1 downto 0);
	B : in std_logic_vector(N-1 downto 0);
	
	S : out std_logic_vector(N-1 downto 0)

);
end entity;


architecture arch of ripple_carry is

signal regA,regB,signalS,regS : std_logic_vector (N-1 downto 0);
signal Carry : std_logic_vector (N downto 0);



	component registro is
		generic ( N : integer := 4);
		port ( 
			
			clk : in std_logic;
			D : in std_logic_vector (N-1 downto 0);
			reset : in std_logic;
			set : in std_logic;
			enable : in std_logic;
			Q : out std_logic_vector (N-1 downto 0);
			Q_n : out std_logic_vector (N-1 downto 0)

		 );
	end component;

	component FA is
		port 
		(
			A : in std_logic;
			B : in std_logic;		
			Ci : in std_logic;		
			S : out std_logic;
			Co : out std_logic
		);
	end component;


begin

Carry(0) <= '0';

registroA: registro generic map (N => N)  port map ( clk, A,reset,'0','1',regA,open );
registroB: registro generic map (N => N)  port map ( clk, B,reset,'0','1',regB,open );


gen:
for i in 0 to N-1 generate
	
	FA_i: FA port map (regA(i),regB(i),Carry(i),signalS(i),Carry(i+1));
	
end generate;

registroS: registro generic map (N => N)  port map ( clk, signalS,reset,'0','1',regS,open );

S <= regS;

end arch;

