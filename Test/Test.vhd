-- Diseño mínimo sin librerías externas
entity Test is
    port (
        A : in boolean;
        B : in boolean;
        Y : out boolean
    );
end entity;

architecture simple_logic of Test is
begin
    process (A, B)
    begin
        if A and B then
            Y <= true;
        else
            Y <= false;
        end if;
    end process;
end architecture;
