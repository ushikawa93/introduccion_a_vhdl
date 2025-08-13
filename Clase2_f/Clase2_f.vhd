
	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase2_f is
		 port (
			  a : in  std_logic_vector(7 downto 0);
			  y : out std_logic_vector(7 downto 0)
		 );
	end entity;

	architecture Combinacional of Clase2_f is
	begin

		 process(a)
			  variable i : integer := 0;
		 begin
			  i := 0;
			  while (i < 8) loop
					y(i) <= not(a(i));
					i := i + 1;
			  end loop;
		 end process;


	end architecture;
	
	
	--		 process(a)
--		 begin
--			  for i in 0 to 7 loop
--					y(i) <= not a(i);
--			  end loop;
--		 end process;
--		 

	
	