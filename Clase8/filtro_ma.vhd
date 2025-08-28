library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filtro_ma is

generic( N_ma : integer := 8; Q : integer := 12);
port(
	
	clk : in std_logic;
	reset : in std_logic;
	
	data_in : in std_logic_vector (Q-1 downto 0);
	data_in_valid : in std_logic;
	
	data_out : out std_logic_vector (Q-1+4 downto 0);	-- Le agrego 4 bits (para valores altos de N_ma deberia ser mas
	data_out_valid : out std_logic
);

end entity;


architecture filter of filtro_ma is

-- Tipo auxiliar para hacer varios registros
type datos_array is array (natural range <>) of std_logic_vector(11 downto 0);
signal datos : datos_array(0 to N_ma-1);

signal acumulador : std_logic_vector (Q-1+4 downto 0) := (others => '0');
signal data_out_valid_reg : std_logic := '0';

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


process (clk) is
variable dato_extendido : std_logic_vector ( 15 downto 0 ) ;
begin	

	if(reset = '0') then 
		for i in 0 to N_ma-1 loop
			datos(i) <= (others => '0');
		end loop;

	elsif(rising_edge (clk) ) then

		data_out_valid_reg <= data_in_valid;
		
		if(data_in_valid = '1') then
			datos(0) <= data_in;
						
			for i in 1 to N_ma-1 loop
				datos(i) <= datos(i-1);
			end loop;				
		end if;		
	
	end if;
	
	
end process;

acumulador <= std_logic_vector(sum_array(datos));
data_out_valid <= data_out_valid_reg;
data_out <= acumulador;


end filter;