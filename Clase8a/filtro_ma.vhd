
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filtro_ma is

generic( N_ma : integer := 4; Q : integer := 12);

port(
	
	clk : in std_logic;
	reset_n : in std_logic;
	
	data_in : in std_logic_vector (Q-1 downto 0);
	data_in_valid : in std_logic;
	
	data_out : out std_logic_vector (Q-1+4 downto 0);
	data_out_valid : out std_logic
);

end entity;

architecture filter of filtro_ma is

	type datos_array is array (natural range <>) of std_logic_vector(Q-1+4 downto 0);

	signal reg : datos_array (N_ma-1 downto 0);

	signal acumulador : std_logic_vector (Q-1+4 downto 0);
	signal data_out_valid_reg : std_logic;
	
	-- Funcion auxiliar para sumar todos los elementos del arreglo...
	function sum_array(a : datos_array) return unsigned is
		 variable acc : unsigned(15 downto 0) := (others => '0');  -- tamaño mayor que 12 bits
	begin
		 for i in a'range loop
			  acc := acc + unsigned(a(i));  -- convierte cada elemento y acumula
		 end loop;
		 
		 return acc;
	end function;

begin

process (clk,reset_n) is begin
	

	if(reset_n = '0') then
	
		for i in 0 to N_ma-1 loop
			reg(i) <= (others => '0');
		end loop;
		
		data_out_valid_reg <= '0';
		
	elsif (rising_edge(clk)) then
	
		data_out_valid_reg <= data_in_valid;
	
			if(data_in_valid = '1') then
				reg(0) <= "0000" & data_in;
				
				for i in 1 to N_ma-1 loop
					reg(i) <= reg(i-1);
				end loop;			
				acumulador <= std_logic_vector(sum_array(reg));					
			end if;		
		end if;
	
end process;


data_out <= acumulador;
data_out_valid <= data_out_valid_reg;

end filter;






