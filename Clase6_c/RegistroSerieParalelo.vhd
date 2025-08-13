library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroSerieParalelo is
    generic (
        N : integer := 4  -- Número de bits
    );
    Port (
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        SET     : in  STD_LOGIC;
        ENABLE  : in  STD_LOGIC;
        D_SER   : in  STD_LOGIC;                      -- Entrada serie
        Q_PAR   : out STD_LOGIC_VECTOR(N-1 downto 0)  -- Salida paralela
    );
end RegistroSerieParalelo;

architecture Behavioral of RegistroSerieParalelo is

    component FF_D
        Port (
            D, CLK, SET, RESET, ENABLE: in STD_LOGIC;
            Q, Q_N             : out STD_LOGIC
        );
    end component;

    signal D_int     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Q_int     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Q_N_dummy : STD_LOGIC_VECTOR(N-1 downto 0);

begin

    -- Lógica de entrada para los flip-flops
    process(D_SER, Q_int)
    begin
        for i in 0 to N-1 loop
            if i = N-1 then
                D_int(i) <= D_SER; -- Bit nuevo entra al último FF (puede invertirse si querés otro orden)
            else
                D_int(i) <= Q_int(i+1); -- Desplazamiento hacia la izquierda
            end if;
        end loop;
    end process;

    -- Instanciación de flip-flops
    gen_ff: for i in 0 to N-1 generate
        FF: FF_D
            port map (
                D      => D_int(i),
                CLK    => CLK,
                SET    => SET,
                RESET  => RESET,
                ENABLE => ENABLE,
                Q      => Q_int(i),
                Q_N    => Q_N_dummy(i)
            );
    end generate;

    -- Salida paralela del registro
    Q_PAR <= Q_int;

end Behavioral;
