
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Clase7_b is

	port(		
		FPGA_CLK1_50: in std_logic;
		KEY : in std_logic_vector (1 downto 0);
		SW: in std_logic_vector (3 downto 0);		
		LED : out std_logic_vector(3 downto 0);
	
		ADC_CONVST : out std_logic;
		ADC_SCK : out std_logic;
		ADC_SDI : out std_logic;
		ADC_SDO : in std_logic

	);

end Clase7_b;

	architecture arch of Clase7_b is

	signal clk : std_logic;
	signal data_adc_valid : std_logic;
	signal data_adc : std_logic_vector ( 31 downto 0);

	component nios_system is
		 port (
			  clk_clk        : in std_logic                    := 'X';             -- clk
			  reset_reset_n  : in std_logic                    := 'X';             -- reset_n
			  data_in_export : in std_logic_vector(7 downto 0) := (others => 'X');  -- export
			  data_adc_in_valid : in std_logic                     := 'X';             -- valid
           data_adc_in_data  : in std_logic_vector(31 downto 0) := (others => 'X')  -- data
      
		 );
	end component nios_system;
	
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
	 
	 

	signal data_in : std_logic_vector(7 downto 0);

	begin

	clk <= FPGA_CLK1_50;
	data_in <= "0000" & sw;

	u0 : component nios_system
		 port map (
			  clk_clk        => clk,        --     clk.clk
			  reset_reset_n  => key(0),  --   reset.reset_n
			  data_in_export => data_in,  -- data_in.export
			  data_adc_in_valid => data_adc_valid, -- data_adc_in.valid
           data_adc_in_data  => data_adc   --            .data
 
	);
	
	u1: embedded_adc
        port map (
            clk    => clk,
            reset_n=> key(0),
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


	end arch;


