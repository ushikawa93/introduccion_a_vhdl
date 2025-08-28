-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's salidas are dependent only on the current state.
-- The salida is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity Clase7_a is

	port(
		clk		 : in	std_logic;
		entrada	 : in	std_logic;
		reset	 : in	std_logic;
		salida	 : out	std_logic_vector (1 downto 0)
	);

end entity;

architecture rtl of Clase7_a is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is			
				when s0=>
					if entrada = '0' then
						state <= s1;
					else
						state <= s0;
					end if;					
				when s1=>
					if entrada = '1' then
						state <= s2;
					else
						state <= s1;
					end if;					
				when s2=>
					if entrada = '0' then
						state <= s3;
					else
						state <= s2;
					end if;					
				when s3 =>
					if entrada = '1' then
						state <= s0;
					else
						state <= s3;
					end if;
					
			end case;
		end if;
	end process;

	-- salida depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				salida <= "01";
			when s1 =>
				salida <= "00";
			when s2 =>
				salida <= "10";
			when s3 =>
				salida <= "00";
		end case;
	end process;

end rtl;
