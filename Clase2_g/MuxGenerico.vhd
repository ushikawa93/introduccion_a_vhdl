	
	library ieee;
	use ieee.std_logic_1164.all;

	entity MuxGenerico is
		 generic (
			  N : integer := 4  -- Número de entradas
		 );
		 port (
			  inputs : in  std_logic_vector(N-1 downto 0);
			  sel    : in  integer range 0 to N-1;
			  y      : out std_logic
		 );
	end entity;

	architecture Comportamiento of MuxGenerico is
	begin
		 process(inputs, sel)
		 begin
			  y <= '0'; 
			  for i in 0 to N-1 loop
					if sel = i then
						 y <= inputs(i);
					end if;
			  end loop;
		 end process;
	end architecture;
	
	
	
	
	
