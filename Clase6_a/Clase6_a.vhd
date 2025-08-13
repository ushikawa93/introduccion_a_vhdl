
	-- Quartus II VHDL Template
	-- Four-State Moore State Machine

	-- A Moore machine's outputs are dependent only on the current state.
	-- The output is written only when the state changes.  (State
	-- transitions are synchronous.)

	library ieee;
	use ieee.std_logic_1164.all;

	entity Clase6_a is

		port(
			clk		 : in	std_logic;
			entrada	 : in	std_logic;
			reset	 : in	std_logic;
			salidas	 : out	std_logic
		);

	end entity;

	architecture rtl of Clase6_a is

		-- Tipo de estado nuevo con conjunto finito de valores
		type state_type is (entradaEn0, Recibi1, entradaEn1);

		-- Registro de tipo state_type que guarda el estado actual
		signal state   : state_type;

	begin

		-- Logica para avanzar al siguiente estado
		process (clk, reset)
		begin
			if reset = '1' then
				state <= entradaEn0;
				
			elsif (rising_edge(clk)) then
				case state is
				
					when entradaEn0=>					
						if entrada = '1' then
							state <= Recibi1;
						else
							state <= entradaEn0;
						end if;
						
						
					when Recibi1=>
						state <= entradaEn1;
						
					when entradaEn1=>
						if entrada = '0' then
							state <= entradaEn0;
						else
							state <= entradaEn1;
						end if;
						
				end case;
				
			end if;
		end process;

	-- La salida solo depende del estado actual
	-- Es una lógica combinatoria entre estados
	process (state)
	begin
		case state is
			when entradaEn0 =>
				salidas <= '0';
			when recibi1 =>
				salidas <= '1';
			when entradaEn1 =>
				salidas <= '0';
		end case;
	end process;

end rtl;
