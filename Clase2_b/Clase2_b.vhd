
	library ieee;
	use ieee.std_logic_1164.all;


		entity Clase2_b is
		
		port
		(
			-- Input ports
			A	: in  std_logic;
			B	: in  std_logic;
			C	: in std_logic;
			D	: in std_logic;
			sel : in std_logic_vector (1 downto 0);
				
			-- Output ports
			Y	: out std_logic
		);
	end Clase2_b;


	architecture arch of Clase2_b is	
		
		
	begin
	
--	with sel select
--		Y <= A when "00",
--			  B when "01",
--			  C when "10",
--			  D when "11",
--			  '0' when others;
	
--	process(A,B,C,D)
--	begin		
--		case sel is
--			when "00" => Y <= A;
--			when "01" => Y <= B;
--			when "10" => Y <= C;
--			when "11" => Y <= D;
--			when others => Y <= '0';
--		end case;		
--	
--	end process;

	process(A,B,C,D, sel)
	begin
		
		if(sel = "00") then
			Y <= A;
			
		elsif(sel = "01") then
			Y <= B;
			
		elsif(sel = "10") then
			Y <= C;
			
		else Y <= '0';
			
		end if;
		
	end process;


	end arch;
