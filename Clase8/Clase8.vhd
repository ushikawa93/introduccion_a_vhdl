
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Clase8 is

generic ( N_ma : integer := 8);
port( FPGA_CLK1_50 : in std_logic;
		KEY : in std_logic_vector(1 downto 0);
		SW : in std_logic_vector(3 downto 0);
		LED : out std_logic_vector(7 downto 0);
		
		ADC_CONVST : out std_logic;
		ADC_SCK : out std_logic;
		ADC_SDI : out std_logic;
		ADC_SDO : in std_logic;
		
		-- DDR3 pins del HPS
      HPS_DDR3_ADDR    : out std_logic_vector(12 downto 0);
      HPS_DDR3_BA      : out std_logic_vector(2 downto 0);
      HPS_DDR3_CAS_N   : out std_logic;
      HPS_DDR3_CKE     : out std_logic;
      HPS_DDR3_CK_N    : out std_logic;
      HPS_DDR3_CK_P    : out std_logic;
      HPS_DDR3_CS_N    : out std_logic;
      HPS_DDR3_DM      : out std_logic;
      HPS_DDR3_DQ      : inout std_logic_vector(7 downto 0);
      HPS_DDR3_DQS_N   : inout std_logic;
      HPS_DDR3_DQS_P   : inout std_logic;
      HPS_DDR3_ODT     : out std_logic;
      HPS_DDR3_RAS_N   : out std_logic;
      HPS_DDR3_RESET_N : out std_logic;
      HPS_DDR3_WE_N    : out std_logic;
      HPS_DDR3_RZQ     : in std_logic
		
		);
end entity;


architecture estructural of Clase8 is

signal data_adc : std_logic_vector (31 downto 0);
signal data_adc_valid : std_logic;
signal data_procesada : std_logic_vector (15 downto 0);
signal data_procesada_valid : std_logic;

signal half_clk : std_logic := '0';

-- Componente del Filtro de Media movil
component filtro_ma is

	generic( N_ma : integer := 8; Q : integer := 12);
	port(		
		clk : in std_logic;
		reset : in std_logic;		
		
		data_in : in std_logic_vector (Q-1 downto 0);
		data_in_valid : in std_logic;	
		
		data_out : out std_logic_vector (Q-1+4 downto 0);	-- Con 4 bits mas se podria acumular hasta 16 ciclos
		data_out_valid : out std_logic
	);
	
end component;

-- Componente para el ADC
component embedded_adc
       port (
           clk    : in  std_logic;
           reset_n: in  std_logic;
           enable : in  std_logic;
           fmuestreo : in std_logic_vector(31 downto 0);
           sel_ch    : in std_logic_vector(3 downto 0);
           adc_cs_n  : out std_logic;
           adc_sclk  : out std_logic;
           adc_din   : out std_logic;
           adc_dout  : in  std_logic;
           data_stream_valid_adc : out std_logic;
           data_stream_adc       : out std_logic_vector(31 downto 0)
       );
   end component;

	
-- Componente para el HPS
component hps is
        port (
            clk_clk                 : in    std_logic                     := 'X';             -- clk
            memory_mem_a            : out   std_logic_vector(12 downto 0);                    -- mem_a
            memory_mem_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck           : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n         : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke          : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n         : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n        : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n        : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n         : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n      : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq           : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
            memory_mem_dqs          : inout std_logic                     := 'X';             -- mem_dqs
            memory_mem_dqs_n        : inout std_logic                     := 'X';             -- mem_dqs_n
            memory_mem_odt          : out   std_logic;                                        -- mem_odt
            memory_mem_dm           : out   std_logic;                                        -- mem_dm
            memory_oct_rzqin        : in    std_logic                     := 'X';             -- oct_rzqin
            data_in_export          : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            fifo_adc_in_valid       : in    std_logic                     := 'X';             -- valid
            fifo_adc_in_data        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- data
            fifo_procesada_in_valid : in    std_logic                     := 'X';             -- valid
            fifo_procesada_in_data  : in    std_logic_vector(31 downto 0) := (others => 'X')  -- data
        );
    end component hps;
	 

begin

process (FPGA_CLK1_50) is begin
	if(rising_edge(FPGA_CLK1_50)) then
		half_clk <= not(half_clk);
	end if;	
end process;


u0: filtro_ma generic map (N_ma,12) port map (half_clk,KEY(0),data_adc(11 downto 0),data_adc_valid,data_procesada,data_procesada_valid);

u1: embedded_adc 
        port map (
            clk    	=> half_clk,
            reset_n 	=> KEY(0),
            enable => '1',
            fmuestreo => std_logic_vector(to_unsigned(1000, 32)),
            sel_ch    => "0001",
            adc_cs_n  => ADC_CONVST,
            adc_sclk  => ADC_SCK,
            adc_din   => ADC_SDI,
            adc_dout  => ADC_SDO,
            data_stream_valid_adc => data_adc_valid,
            data_stream_adc       => data_adc
        );

u2 : component hps
        port map (
            clk_clk            => half_clk,            --     clk.clk
            memory_mem_a       => HPS_DDR3_ADDR,       --  memory.mem_a
            memory_mem_ba      => HPS_DDR3_BA,      --        .mem_ba
            memory_mem_ck      => HPS_DDR3_CK_P,      --        .mem_ck
            memory_mem_ck_n    => HPS_DDR3_CK_N,    --        .mem_ck_n
            memory_mem_cke     => HPS_DDR3_CKE,     --        .mem_cke
            memory_mem_cs_n    => HPS_DDR3_CS_N,    --        .mem_cs_n
            memory_mem_ras_n   => HPS_DDR3_RAS_N,   --        .mem_ras_n
            memory_mem_cas_n   => HPS_DDR3_CAS_N,   --        .mem_cas_n
            memory_mem_we_n    => HPS_DDR3_WE_N,    --        .mem_we_n
            memory_mem_reset_n => HPS_DDR3_RESET_N, --        .mem_reset_n
            memory_mem_dq      => HPS_DDR3_DQ,      --        .mem_dq
            memory_mem_dqs     => HPS_DDR3_DQS_P,     --        .mem_dqs
            memory_mem_dqs_n   => HPS_DDR3_DQS_N,   --        .mem_dqs_n
            memory_mem_odt     => HPS_DDR3_ODT,     --        .mem_odt
            memory_mem_dm      => HPS_DDR3_DM,      --        .mem_dm
            memory_oct_rzqin   => HPS_DDR3_RZQ,   --        .oct_rzqin
				fifo_adc_in_valid       => data_adc_valid,       --       fifo_adc_in.valid
            fifo_adc_in_data        => data_adc,        --                  .data
            fifo_procesada_in_valid => data_procesada_valid, -- fifo_procesada_in.valid
            fifo_procesada_in_data  => "0000000000000000" & data_procesada,   --                  .data
            data_in_export     => "0000" & SW      -- data_in.export
        );
		  
		  
end estructural;

