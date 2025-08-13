
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity Clase2_c is	

	port
	(
		-- Input ports
		x		: in  std_logic_vector (3 downto 0);
		sel	: in  std_logic_vector (1 downto 0);
		dir 	: in std_logic;	--0 izq, 1 der
		
		-- Output ports
		y	: out std_logic_vector(3 downto 0)
		
	);
	
	end Clase2_c;

	architecture arch of Clase2_c is
	
	
	begin
	
--		process( x,sel )
--		begin
--		
--			case sel is
--				when "00" => y <= X;
--				when "01" => y <= x(2) & x(1) & x(0) & x(3);
--				when "10" => y <= x(1) & x(0) & x(3) & x(2);
--				when "11" => y <= x(0) & x(3) & x(2) & x(1);
--				when others => y <= "0000";
--			end case;
--			
--		end process;

--		process( x,sel,dir )
--		begin
--		
--			if(dir = '0') then
--		
--				case sel is
--					when "00" => y <= X;
--					when "01" => y <= x(2) & x(1) & x(0) & x(3);
--					when "10" => y <= x(1) & x(0) & x(3) & x(2);
--					when "11" => y <= x(0) & x(3) & x(2) & x(1);
--					when others => y <= "0000";
--				end case;
--			
--			elsif(dir = '1') then
--				
--				case sel is
--					when "00" => y <= X;
--					when "01" => y <= x(0) & x(3) & x(2) & x(1);
--					when "10" => y <= x(1) & x(0) & x(3) & x(2);
--					when "11" => y <= x(2) & x(1) & x(0) & x(3);
--					when others => y <= "0000";
--				end case;
--			
--			else y <= "0000";
--			
--			end if;
--			
--		end process;

		process(sel, dir, x)
		begin
			case sel is
				when "00" =>
					y <= x;

				when "01" =>
					if dir = '0' then
						y <= x(2) & x(1) & x(0) & x(3);
					else
						y <= x(0) & x(3) & x(2) & x(1);
					end if;

				when "10" =>
					y <= x(1) & x(0) & x(3) & x(2);

				when "11" =>
					if dir = '0' then
						y <= x(0) & x(3) & x(2) & x(1);
					else
						y <= x(2) & x(1) & x(0) & x(3);
					end if;

				when others =>
					y <= "0000";
			end case;
		end process;
	
	
	end arch;
	