
library ieee;
use ieee.std_logic_1164.all;


entity Clase6_c is
generic( N : integer := 4; log2N : integer :=2 );
port(
	clk: in std_logic;
	reset : in std_logic;
	dat_in : in std_logic;
	enable : in std_logic;
	dat_out_valid : out std_logic;
	dat_out : out std_logic
);

end Clase6_c;

architecture estructural of Clase6_c is

signal regA,regB,regS,count : std_logic_vector (N-1 downto 0) := (others => '0');
signal enA,enB,enC,enCount,fin_count,resetCount, cargaRegC : std_logic := '0';

-- Contador:
component contador_asinc is
	generic (N : integer := 16 );
	port ( clk   : in  std_logic;
			 reset : in  std_logic;
			 enable : in std_logic;
			 fin_count : out std_logic;
			 count : out std_logic_vector(N-1 downto 0));
end component;

-- Sumador:
component RippleCarry is
	generic ( N: integer := 4);
	port ( A : in std_logic_vector(N-1 downto 0);
			 B : in std_logic_vector(N-1 downto 0);
			 S : out std_logic_vector(N-1 downto 0));		 
end component;

-- Registro de desplazamiento Serie/Paralelo
component RegistroSerieParalelo is
   generic (N : integer := 4);
   Port ( clk     : in  std_logic;
          reset   : in  std_logic;
          set     : in  std_logic;
          enable  : in  std_logic;
          D_ser   : in  std_logic;  
          Q_par   : out std_logic_vector(N-1 downto 0));
end component;

-- Registro de desplazamiento Paralelo/Serie
component RegistroDesplazamiento is
   generic (N : integer := 4);
   Port ( clk     : in  std_logic;
          reset   : in  std_logic;
          set     : in  std_logic;
          enable  : in  std_logic;
          cargar  : in  std_logic;
          D_par   : in  std_logic_vector(N-1 downto 0); 
          Q_ser   : out std_logic;
			 dat_out_valid : out std_logic	);
end component;

	-- Maquina de estados
	component MaquinaEstados is
		port ( clk : in std_logic;
				 reset : in std_logic;
				 enable : in std_logic;	
				 fin_count : in std_logic;
					
				 enA : out std_logic;
				 enB : out std_logic;
				 enC : out std_logic;
				 enCount : out std_logic;
				 ResetCount : out std_logic;
				 cargaC : out std_logic);
	end component;

begin


	counter: contador_asinc generic map (log2N) port map ( clk, resetCount ,enCount,fin_count, open );
	registroA: RegistroSerieParalelo generic map (N) port map (clk,reset,'0',enA,dat_in,regA);
	registroB: RegistroSerieParalelo generic map (N) port map (clk,reset,'0',enB,dat_in,regB);
	sumador: RippleCarry generic map (N) port map (regA,regB,regS);
	registroC: RegistroDesplazamiento generic map (N) port map (clk,reset,'0',enC,cargaRegC,regS,dat_out,dat_out_valid);
	
	
	ME : MaquinaEstados port map (clk,reset,enable,fin_count,enA,enB,enC,enCount,ResetCount,cargaRegC);

	

end estructural;
