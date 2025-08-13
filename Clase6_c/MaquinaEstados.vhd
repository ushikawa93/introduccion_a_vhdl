
	library ieee;
	use ieee.std_logic_1164.all;
	
	entity MaquinaEstados is
	port 
	(
		clk : in std_logic;
		reset : in std_logic;
		enable : in std_logic;		
		fin_count : in std_logic; 		
		
		enA : out std_logic;
		enB : out std_logic;
		enC : out std_logic;
		enCount : out std_logic;
		ResetCount : out std_logic;
		cargaC : out std_logic
	);
	end entity;
	
	
	architecture rtl of MaquinaEstados is

		-- Build an enumerated type for the state machine
		type state_type is (s0, s1, s2, s3, s4, s5, s6,s7);

		-- Register to hold the current state
		signal state   : state_type;
		
		signal salidas : std_logic_vector (5 downto 0);
		-- salidas = enA & enB & enC & enCount & ResetCount & cargaC

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
			
		elsif (rising_edge(clk)) then
		
			case state is
				when s0=>
					if enable = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
					
				when s1=>
					if fin_count = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
					
				when s2=>
					if fin_count = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
					
				when s3 =>
					state <= s4;
					
				when s4 =>
					state <= s5;
					
				when s5 =>
					if fin_count = '1' then
						state <= s6;
					else
						state <= s5;
					end if;
				
				when s6 =>
					state <= s7;
					
				when s7 =>
					if enable = '0' then
						state <= s0;
					else
						state <= s7;
					end if;
					
					
			end case;
		end if;
	end process;

	-- salidas = enA & enB & enC & enCount & ResetCount & cargaC

	process (state)
	begin
		case state is
			when s0 =>
				salidas <= "000000";
			when s1 =>
				salidas <= "100100";
			when s2 =>
				salidas <= "010100";
			when s3 =>
				salidas <= "000010";
			when s4 =>
				salidas <= "001001";
			when s5 =>
				salidas <= "001100";
			when s6 =>
				salidas <= "001000";
			when s7 =>
				salidas <= "000000";
		end case;
	end process;
	
	enA <= salidas(5);
	enB <= salidas(4);
	enC <= salidas(3);
	enCount <= salidas(2);
	ResetCount <= salidas(1);
	cargaC <= salidas(0);

end rtl;
	
	