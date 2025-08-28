library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothNbits is

generic( N : integer := 16 );

port(
	
	A : in std_logic_vector (N-1 downto 0);
	B: in std_logic_vector (N-1 downto 0);
		
	C : out std_logic_vector (2*N-1 downto 0)
);

end entity;


architecture arch of boothNbits is

component mux4a1 is 
generic (N : integer := 8);
port (

	sel : in std_logic_vector ( 1 downto 0);
	
	dat_in_0 : in std_logic_vector ( N-1 downto 0);
	dat_in_1 : in std_logic_vector ( N-1 downto 0);
	dat_in_2 : in std_logic_vector ( N-1 downto 0);
	dat_in_3 : in std_logic_vector ( N-1 downto 0);
	
	dat_out : out std_logic_vector ( N-1 downto 0)

);
end component;


type arreglo is array (integer range <>) of std_logic_vector (2*N-1 downto 0);
signal salida,salidas_shifted : arreglo (0 to N/2-1);

signal zero_A,un_A,dos_A,tres_A :  std_logic_vector (2*N-1 downto 0) := (others => '0');

-- Funcion auxiliar para sumar todos los elementos del arreglo...
	function sum_array(a : arreglo) return unsigned is
		 variable acc : unsigned(2*N-1 downto 0) := (others => '0');  -- tamaño mayor que 12 bits
	begin
		 for i in a'range loop
			  acc := acc + unsigned(a(i));  -- convierte cada elemento y acumula
		 end loop;
		 
		 return acc;
	end function;



begin

zero_A <= (others => '0');
un_A <= (N-1 downto 0 => '0') & A;
dos_A <= (N-2 downto 0 => '0') & A & '0';
tres_A <= std_logic_vector ( unsigned(un_A) + unsigned(dos_A));

gen: for i in 0 to N/2-1 generate
	gen_i: mux4a1 generic map (2*N) port map ( B(2*i+1) & B(2*i) , zero_A, un_A , dos_A , tres_A, salida(i) ) ;	
end generate;

process (salida) is 
variable acum : unsigned(2*N-1 downto 0) := (others => '0');
variable salida_shifted : std_logic_vector(2*N-1 downto 0);
	begin 

	for i in 0 to N/2-1 loop 
		salida_shifted := std_logic_vector(shift_left(unsigned(salida(i)), 2*i));
		salidas_shifted(i) <= std_logic_vector(salida_shifted);
	end loop; 
	

end process;

C <= std_logic_vector(sum_array(salidas_shifted)); 
	
end arch;

