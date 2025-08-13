library ieee;
use ieee.std_logic_1164.all;

entity Clase3_b is
    port(
        J: in std_logic;
        K: in std_logic;

        clk: in std_logic;
        rst_n: in std_logic;
        set: in std_logic;
        enable : in std_logic;

        Q: out std_logic
    );
end entity;

	architecture arch of Clase3_b is
		 signal q_reg: std_logic := '0';  -- Registro interno
		 signal jk : std_logic_vector (1 downto 0);
	begin
		
		 jk <= J & K;
		 process(clk, rst_n, set)
		 begin
			  if rst_n = '0' then
					q_reg <= '0';
			  elsif set = '1' then
					q_reg <= '1';
			  elsif rising_edge(clk) then
					if enable = '1' then
						 case (jk) is
							  when "00" => q_reg <= q_reg;   -- sin cambio
							  when "01" => q_reg <= '0';     -- reset
							  when "10" => q_reg <= '1';     -- set
							  when "11" => q_reg <= not q_reg; -- toggle
							  when others => null;
						 end case;
					end if;
			  end if;
		 end process;

		 Q <= q_reg;

	end arch;
