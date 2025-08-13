
	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
	entity Clase6_d is	
		generic( N : integer := 32 );	
		port( clk: in std_logic;
				reset : in std_logic;
				dat_in: in std_logic_vector (N-1 downto 0);
				
				dat_aux0 : out std_logic_vector (N-1 downto 0);
				dat_aux1 : out std_logic_vector (N-1 downto 0);
				dat_aux2 : out std_logic_vector (N-1 downto 0);
				
				dat_out: out std_logic_vector (N-1 downto 0)	);
				
	end entity;
	
	
		architecture arch of Clase6_d is
		
		signal dat_0,dat_1,dat_2 : std_logic_vector(N-1 downto 0);
		
		begin
		
		process (clk) is begin
		
			if (reset = '1') then
				dat_0 <= (others => '0');
				dat_1 <= (others => '0');
				dat_2 <= (others => '0');
				
				
			elsif (rising_edge(clk)) then
				dat_0 <= dat_in;
				
				dat_1 <= std_logic_vector ( unsigned(dat_0) + 15 ) ;
				
				dat_2 <= std_logic_vector ( unsigned(dat_1) + 42 ) ;
				
			end if;
			
		end process;
		
		dat_out <= dat_2;
		
		dat_aux0 <= dat_0;
		dat_aux1 <= dat_1;
		dat_aux2 <= dat_2;
		
		end arch;
	
	
	
	