
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is end entity testbench;

architecture tb of testbench is

constant N_ma : integer := 8;
constant Q : integer := 12;

constant M : integer := 8;


component filtro_ma is
	generic( N_ma : integer := 8; Q : integer := 12);
	port(	
		clk : in std_logic;
		reset_n : in std_logic;	
		data_in : in std_logic_vector (Q-1 downto 0);
		data_in_valid : in std_logic;
		data_out : out std_logic_vector (Q-1+4 downto 0);	-- Con 4 bits mas se podria acumular hasta 16 ciclos
		data_out_valid : out std_logic
	);
end component;


signal clk,reset : std_logic := '0';
signal data_in_tb : std_logic_vector (Q-1 downto 0);
signal data_in_valid_tb : std_logic;
signal data_out_tb : std_logic_vector (Q-1+4 downto 0);
signal data_out_valid_tb : std_logic;


type datos_array is array (natural range <>) of std_logic_vector(Q-1 downto 0);

signal sin_signal : datos_array(0 to M-1) := (

    0 => std_logic_vector(to_unsigned(2047,Q)),
    1 => std_logic_vector(to_unsigned(3494,Q)),
    2 => std_logic_vector(to_unsigned(4094,Q)),
    3 => std_logic_vector(to_unsigned(3494,Q)),
    4 => std_logic_vector(to_unsigned(2047,Q)),
    5 => std_logic_vector(to_unsigned(599,Q)),
    6 => std_logic_vector(to_unsigned(0,Q)),
    7 => std_logic_vector(to_unsigned(599,Q)) 
);

begin 

filter: filtro_ma generic map (N_ma,Q) port map (clk,reset,data_in_tb,data_in_valid_tb,data_out_tb,data_out_valid_tb); 

-- Valores "artificiales" a todas las señales

clk <= not(clk) after 10 ns;
reset <= '0', '1' after 40 ns;

-- Proceso que alimenta la señal sinusoidal
    stimulus : process
        variable idx : integer := 0;
    begin
        wait until reset = '1';  -- espero a que termine el reset
        wait until rising_edge(clk);

        while true loop
            data_in_tb <= sin_signal(idx);
            data_in_valid_tb <= '1';
            wait until rising_edge(clk);

            -- paso a la siguiente muestra (cíclico)
            idx := (idx + 1) mod M;
        end loop;
    end process;


end tb;

