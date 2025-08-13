library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
    Port (
        D, CLK, SET, RESET : in STD_LOGIC;
        Q, Q_N             : out STD_LOGIC
    );
end FF_D;

architecture Behavioral of FF_D is
    signal Q_reg, Q_N_reg : STD_LOGIC := '0';
begin
    process (CLK,RESET,SET,Q_reg)
    begin
        if RESET = '1' then
            Q_reg <= '0';
		  elsif SET = '1' then
            Q_reg <= '1';

        elsif rising_edge(CLK) then
                Q_reg <= D;
					 
		  else Q_reg <= Q_reg;
		  
        end if;
    end process;

    Q <= Q_reg;
    Q_N <= not(Q_reg);
end Behavioral;