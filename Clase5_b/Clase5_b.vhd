library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

	entity Clase5_b is
	
	generic (N : integer := 4);
	
	port(
	
		clk : in std_logic;
		reset : in std_logic;
		carga_paralela : in std_logic;
		
		A : in std_logic_vector (N-1 downto 0);
		B : in std_logic_vector (N-1 downto 0);
		
		S : out std_logic_vector (N-1 downto 0)
	
	);
	
	end entity;
	
	architecture sumador_secuencial of Clase5_b is
	
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
	
	component FF_D is
		 port (
			  D, CLK, SET, RESET, ENABLE: in STD_LOGIC;
			  Q, Q_N             : out STD_LOGIC
		 );
	end component;
	
	component RegistroDesplazamiento is
		 generic (
			  N : integer := 4  -- Número de bits del registro
		 );
		 Port (
			  CLK     : in  STD_LOGIC;
			  RESET   : in  STD_LOGIC;
			  SET     : in  STD_LOGIC;
			  ENABLE  : in  STD_LOGIC;
			  CARGAR  : in  STD_LOGIC;                     -- 1: Carga paralela, 0: Desplaza
			  D_PAR   : in  STD_LOGIC_VECTOR(N-1 downto 0); -- Datos para carga paralela
			  Q_SER   : out STD_LOGIC                      -- Salida serial
		 );
	end component;
	
	component RegistroSerieParalelo is
    generic (
        N : integer := 4  -- Número de bits
    );
    Port (
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        SET     : in  STD_LOGIC;
        ENABLE  : in  STD_LOGIC;
        D_SER   : in  STD_LOGIC;                      -- Entrada serie
        Q_PAR   : out STD_LOGIC_VECTOR(N-1 downto 0)  -- Salida paralela
    );
	end component;
	
	signal salida_A, salida_B : std_logic;
	signal C_actual : std_logic := '0';
	signal C_sig : std_logic := '0';
	
	signal salida_S : std_logic;
	
	begin
	
	
	RA: RegistroDesplazamiento generic map (N) port map (clk,reset,'0','1',carga_paralela,A,salida_A);
	RB: RegistroDesplazamiento generic map (N) port map (clk,reset,'0','1',carga_paralela,B,salida_B);
	RC: RegistroSerieParalelo generic map (N) port map (clk,reset,'0','1',salida_S,S);
	
	FAd: FA port map (salida_A,salida_B,C_actual,salida_S,C_sig);
	
	FFd: FF_D port map (C_sig,clk,'0',reset,'1',C_actual,open);
	
	end sumador_secuencial;
	