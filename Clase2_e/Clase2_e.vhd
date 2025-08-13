
------------------------------------ E7 ---------------------------------------

----- Implementado solo para el caso concurrente y activo en bajo -------------
----- Para activo en alto habría que negar a,b,c,d,e,f,g  ---------------------
----- Para hacerlo con un process sería con una estructura CASE por ejemplo ---

library ieee;
use ieee.std_logic_1164.all;

entity Clase2_e is
	port ( S3,S2,S1,S0 : in std_logic;
			 a, b, c, d, e, f, g : out std_logic);
end Clase2_e;


	architecture behaivoral of Clase2_e is	
		signal data_in : std_logic_vector (3 downto 0);
		
	begin	
		data_in <= S3 & S2 & S1 & S0;
		
		
		a <=  '0' when((data_in = "0000") or (data_in = "0010") or 
							(data_in = "0011") or (data_in = "0101") or 
							(data_in = "0111") or (data_in = "1000") or 
							(data_in = "1001") ) else '1';
							
		b <=  '0' when((data_in = "0000") or (data_in = "0001") or 
							(data_in = "0010") or(data_in = "0011")  or
							(data_in = "0100") or (data_in = "0111") or
							(data_in = "1000") or(data_in = "1001")) else '1';
							
		c <=  '0' when((data_in = "0000") or (data_in = "0001") or
							(data_in = "0011") or (data_in = "0100") or 
							(data_in = "0101") or (data_in = "0110") or 
							(data_in = "0111") or (data_in = "1000") or
							(data_in = "1001")) else '1';
							
		d <=  '0' when((data_in = "0000") or (data_in = "0010") or
							(data_in = "0011") or (data_in = "0101") or 
							(data_in = "0110") or(data_in = "1000")) else '1';
							
		e <=  '0' when((data_in = "0000") or (data_in = "0010") or
							(data_in = "0110") or (data_in = "1000")) else '1';
							
		f <=  '0' when((data_in = "0000") or (data_in = "0100") or 
							(data_in = "0110") or(data_in = "0101") or
							(data_in = "1000") or(data_in = "1001")) else '1';
							
		g <=  '0' when((data_in = "0010") or (data_in = "0011") or
							(data_in = "0100") or(data_in = "0101") or
							(data_in = "0110") or(data_in = "1000") or
							(data_in = "1001")) else '1';

	end behaivoral;
