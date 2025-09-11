library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is end entity;

architecture tb of testbench is

    component EjFinal is 
        port (
            x       : in  std_logic_vector (11 downto 0);
            clk     : in  std_logic;
            reset_n : in  std_logic;
            y       : out std_logic_vector (31 downto 0)
        );
    end component;

    signal clk_tb      : std_logic := '0';
    signal reset_tb_n  : std_logic := '1';
    signal x_tb        : std_logic_vector (11 downto 0);
    signal y_tb        : std_logic_vector (31 downto 0);

    -- Definimos un arreglo con los estímulos
    type stim_array is array (natural range <>) of std_logic_vector(11 downto 0);
	 
	  constant stim_4 : stim_array := (
        std_logic_vector(to_signed(   0, 12)),
        std_logic_vector(to_signed(2047, 12)),
        std_logic_vector(to_signed(0, 12)),
        std_logic_vector(to_signed(-2047, 12))
    );
	 
    constant stim_8 : stim_array := (
        std_logic_vector(to_signed(   0, 12)),
        std_logic_vector(to_signed(1447, 12)),
        std_logic_vector(to_signed(2047, 12)),
        std_logic_vector(to_signed(1147, 12)),
        std_logic_vector(to_signed(-1148, 12)),
        std_logic_vector(to_signed(-2047, 12)),
		  std_logic_vector(to_signed(-1148, 12))
    );
	 
	 constant stim_16 : stim_array := (
        std_logic_vector(to_signed(   0, 12)),
        std_logic_vector(to_signed(783, 12)),
        std_logic_vector(to_signed(1447, 12)),
        std_logic_vector(to_signed(1891, 12)),
        std_logic_vector(to_signed(2047, 12)),
        std_logic_vector(to_signed(1891, 12)),
		  std_logic_vector(to_signed(1447, 12)),
		  std_logic_vector(to_signed(783, 12)),
		  std_logic_vector(to_signed(0, 12)),
		  std_logic_vector(to_signed(-783, 12)),
		  std_logic_vector(to_signed(-1448, 12)),
		  std_logic_vector(to_signed(-1892, 12)),
		  std_logic_vector(to_signed(-2047, 12)),
		  std_logic_vector(to_signed(-1892, 12)),
		  std_logic_vector(to_signed(-1448, 12)),
		  std_logic_vector(to_signed(-783, 12))
    );

    signal stim_index : integer := 0;
	 signal stim_select : std_logic := '0';

begin

    u0: EjFinal port map(x_tb, clk_tb, reset_tb_n, y_tb);

    clk_tb <= not clk_tb after 10 ns;
    reset_tb_n <= '0', '1' after 20 ns; 
	 
	 stim_select <= '0', '1' after 500 ns;

    process
    begin
        wait until rising_edge(clk_tb);
		  
        if ((reset_tb_n = '1') and (stim_select = '0')) then
            x_tb <= stim_4(stim_index);
            stim_index <= (stim_index + 1) mod stim_4'length;
				
		  elsif((reset_tb_n = '1') and (stim_select = '1')) then
				x_tb <= stim_16(stim_index);
            stim_index <= (stim_index + 1) mod stim_16'length;
				
        else
            x_tb <= (others => '0');
        end if;
    end process;

end tb;
