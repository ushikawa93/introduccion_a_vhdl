	
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase5_a is
		generic(	N : integer := 64 );
		port 
		(
			clk : in std_logic;
			reset : in std_logic;
			A : in std_logic_vector (N-1 downto 0);
			B : in std_logic_vector (N-1 downto 0);
			
			S : out std_logic_vector (N-1 downto 0)
		);
	end entity;


	-- Arquitectura
	architecture arch of Clase5_a is
	
	-- Señales internas
	signal reg_a,reg_b,reg_s,signal_s : std_logic_vector (N-1 downto 0); 
	
	-- Registro de N bits
	component registro is
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
	end component;
	
	-- Para la suma pruebo varias cosas (la mas rapida es de todas formas usar el +)
	component RippleCarry is
		generic ( N: integer := 4);
		port ( A : in std_logic_vector(N-1 downto 0);
				 B : in std_logic_vector(N-1 downto 0);
				 S : out std_logic_vector(N-1 downto 0));				 
	end component;
	
	component LookAheadCarry is
		generic ( N : integer := 16 );
		port ( A    : in  std_logic_vector(N-1 downto 0);
				 B    : in  std_logic_vector(N-1 downto 0);
				 S    : out std_logic_vector(N-1 downto 0));
	end component;
	
	component SumadorGenerico is
		generic ( N: integer := 8);
		port ( A : in std_logic_vector(N-1 downto 0);
				 B : in std_logic_vector(N-1 downto 0);
				 S : out std_logic_vector(N-1 downto 0));
	end component;
	
	component Restador is

		generic ( N: integer := 4);

		port ( A : in std_logic_vector(N-1 downto 0);
				 B : in std_logic_vector(N-1 downto 0);
				 S : out std_logic_vector(N-1 downto 0));
			 
	end component;
	
	begin

	ff_a: registro generic map (N) port map (clk,A,reset,'0','1',reg_a,open);
	ff_b: registro generic map (N) port map (clk,B,reset,'0','1',reg_b,open);
	
	sum: SumadorGenerico generic map (N) port map(reg_a,reg_b,signal_s);

	ff_s: registro generic map (N) port map (clk,signal_s,reset,'0','1',reg_s,open);

	S <= reg_s;

	end arch;
	
	