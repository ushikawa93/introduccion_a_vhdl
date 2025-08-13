-- Quartus II VHDL Template
-- Four-State Mealy State Machine

-- A Mealy machine has salidas that depend on both the state and
-- the entradas.	When the entradas change, the salidas are updated
-- immediately, without waiting for a clock edge.  The salidas
-- can be written more than once per state or per clock cycle.

	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase6_b is

		port
		(
			clk		 : in	std_logic;
			entrada	 : in	std_logic;
			reset	 : in	std_logic;
			salida	 : out	std_logic
		);

	end entity;

	architecture rtl of Clase6_b is

		-- Build an enumerated type for the state machine
		type state_type is (s0, s1);

		-- Register to hold the current state
		signal state : state_type;

begin

	process (clk, reset)
	begin

		if reset = '1' then
			state <= s0;

		elsif (rising_edge(clk)) then

			-- El estado siguiente se determina 
			-- en forma sincrónica según la entrada
			case state is
				when s0=>
					if entrada = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if entrada = '0' then
						state <= s0;
					else
						state <= s1;
					end if;				
			end case;

		end if;
	end process;

	-- Determinamos la salida basada en al estado
	-- actual y la entrada (sin esperar flanco de clk)
	process (state, entrada)
	begin
			case state is
				when s0=>
					if entrada = '1' then
						salida <= '1';
					else
						salida <= '0';
					end if;
				when s1=>
					if entrada = '1' then
						salida <= '0';
					else
						salida <= '0';
					end if;				
			end case;
	end process;

end rtl;
