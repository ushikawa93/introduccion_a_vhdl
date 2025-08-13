
library ieee;
use ieee.std_logic_1164.all;

entity Clase2_d is
 
	port (
	
		A : in std_logic_vector (1 downto 0);
		B : in std_logic_vector (1 downto 0);
		
		opSel : in std_logic;
		
		Z_prod_logic : out std_logic_vector (3 downto 0);
		Z_prod_table : out std_logic_vector (3 downto 0);
		
		Z_sum : out std_logic_vector (3 downto 0);
		
		Z : out std_logic_vector(3 downto 0)


	);

end Clase2_d;

architecture alu of Clase2_d is

signal inputs : std_logic_vector (3 downto 0);

signal Z_prod_logic_reg : std_logic_vector (3 downto 0);
signal Z_prod_table_reg : std_logic_vector (3 downto 0);
signal Z_sum_reg : std_logic_vector (3 downto 0);

begin

--	Z_prod_logic_reg(0) <= A(0) and B(0);
--	
--	Z_prod_logic_reg(1) <= (A(0) and B(1) and not(B(0)) ) or 
--								  (A(1) and not(A(0)) and B(0) ) or 
--								  (A(0) and B(0) and ( A(1) xor B(1) ) );
--								  
--	Z_prod_logic_reg(2) <= A(1) and B(1) and 
--								  (not(B(0)) or ( not(A(0)) and B(0) )) ;
--								  
--	Z_prod_logic_reg(3) <= A(1) and A(0) and B(1) and B(0);
--	
	
	inputs <= A & B;
	
	p0: process (A,B) is
	begin
	
		case inputs is
		
			when "0000" => 	Z_prod_table_reg <= "0000";
			when "0001" => 	Z_prod_table_reg <= "0000";
			when "0010" => 	Z_prod_table_reg <= "0000";
			when "0011" => 	Z_prod_table_reg <= "0000";
			when "0100" => 	Z_prod_table_reg <= "0000";
			when "0101" => 	Z_prod_table_reg <= "0001";
			when "0110" => 	Z_prod_table_reg <= "0010";
			when "0111" => 	Z_prod_table_reg <= "0011";
			when "1000" => 	Z_prod_table_reg <= "0000";
			when "1001" => 	Z_prod_table_reg <= "0010";
			when "1010" => 	Z_prod_table_reg <= "0100";
			when "1011" => 	Z_prod_table_reg <= "0110";
			when "1100" => 	Z_prod_table_reg <= "0000";
			when "1101" => 	Z_prod_table_reg <= "0011";
			when "1110" => 	Z_prod_table_reg <= "0110";
			when "1111" => 	Z_prod_table_reg <= "1001";
			
		end case;
	
	end process;
--	
--	Z_sum_reg(3) <= '0';
--	Z_sum_reg(2) <= (A(1) and B(1)) or (A(0) and B(1) and B(0)) or (A(1) and A(0) and B(0)) ;
--	Z_sum_reg(1) <= (not(B(0)) and ( A(1) xor B(1) ) ) or (B(0) and (A(1) xor A(0) xor B(1) ) ); 
--	Z_sum_reg(0) <= A(0) xor B(0);
--
--	Z <= Z_sum_reg when opSel = '1' else Z_prod_table_reg;
--	
--	Z_prod_logic <= Z_prod_logic_reg;
	Z_prod_table <= Z_prod_table_reg;
--	Z_sum <= Z_sum_reg;
		

end alu;