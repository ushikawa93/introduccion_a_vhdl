library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroDesplazamiento is
    generic (
        N : integer := 4  -- Número de bits del registro
    );
    Port (
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        SET     : in  STD_LOGIC;
        ENABLE  : in  STD_LOGIC;
        CARGAR  : in  STD_LOGIC;                     -- 1: Carga paralela, 0: Desplaza
        D_PAR   : in  STD_LOGIC_VECTOR(N-1 downto 0); -- Datos para carga paralela
        Q_SER   : out STD_LOGIC                      -- Salida serial
    );
end RegistroDesplazamiento;

architecture Behavioral of RegistroDesplazamiento is

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

    -- Lógica para determinar la entrada D de cada flip-flop
    -- Si CARGAR = '1', se carga D_PAR; si no, se desplaza el bit del siguiente flip-flop

    process(D_PAR, Q_int, CARGAR)
    begin
        for i in 0 to N-1 loop
            if CARGAR = '1' then
                D_int(i) <= D_PAR(i);
            else
                if i = N-1 then
                    D_int(i) <= '0'; -- Puedes cambiar por otro valor si querés otro comportamiento al desplazar
                else
                    D_int(i) <= Q_int(i+1);
                end if;
            end if;
        end loop;
    end process;

    -- Instanciación de los flip-flops
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

    -- Salida serial del bit menos significativo
    Q_SER <= Q_int(0);

end Behavioral;
