library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LookAheadCarry is
    generic (
        N : integer := 16  -- Múltiplo de 4
    );
    port (
        A    : in  std_logic_vector(N-1 downto 0);
        B    : in  std_logic_vector(N-1 downto 0);
        S    : out std_logic_vector(N-1 downto 0)
    );
end entity;

	architecture Structural of LookAheadCarry is

		 constant NUM_BLOCKS : integer := N / 4;

		 component LookAheadCarry4bits is
		 port (
			  A : in std_logic_vector(3 downto 0);
			  B : in std_logic_vector(3 downto 0);
			  cin : in std_logic;
			  S : out std_logic_vector(3 downto 0);
			  cout : out std_logic
		 );
		end component;
		
		 -- Tipo para array de std_logic_vector(3 downto 0)
		 type slv4_array is array (natural range <>) of std_logic_vector(3 downto 0);

		 -- Arreglo para carries entre bloques
		 signal C : std_logic_vector(NUM_BLOCKS downto 0);
		 signal S_blocks : slv4_array(0 to NUM_BLOCKS-1);

	begin

		 -- Carry inicial
		 C(0) <= '0';

		 -- Instancias en ripple
		 gen_blocks: for i in 0 to NUM_BLOCKS-1 generate
			  U_CLA4: LookAheadCarry4bits
					port map (
						 A       => A(4*i+3 downto 4*i),
						 B       => B(4*i+3 downto 4*i),
						 Cin     => C(i),
						 S       => S(4*i+3 downto 4*i),
						 cout    => C(i+1)
					);
		 end generate;

	end architecture;
