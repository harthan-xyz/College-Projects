--Joshua Harthan
--Lab 13.1 4/24/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

--define entities (6 7-segment decoders, LEDR)
entity top is 
	port(Clock_50	: in std_logic;
		  Reset		: in std_logic;
		  SW 	  		: in std_logic_vector  (9 downto 0);
		  KEY			: in std_logic_vector  (3 downto 0);
		  LEDR  		: out std_logic_vector (7 downto 0);
		  HEX0  		: out std_logic_vector (6 downto 0);
		  HEX1  		: out std_logic_vector (6 downto 0);
		  HEX2  		: out std_logic_vector (6 downto 0);
		  HEX3  		: out std_logic_vector (6 downto 0);
		  HEX4  		: out std_logic_vector (6 downto 0);
		  HEX5  		: out std_logic_vector (6 downto 0);
		  GPIO_0    : out std_logic_vector (15 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
	
	--declare the computer component
	component computer
	port(clock          : in   std_logic;
        reset          : in   std_logic;
        port_in_00     : in   std_logic_vector (7 downto 0);
        port_in_01     : in   std_logic_vector (7 downto 0);
        port_in_02     : in   std_logic_vector (7 downto 0);
        port_in_03     : in   std_logic_vector (7 downto 0);
        port_in_04     : in   std_logic_vector (7 downto 0);
        port_in_05     : in   std_logic_vector (7 downto 0);
        port_in_06     : in   std_logic_vector (7 downto 0);               
        port_in_07     : in   std_logic_vector (7 downto 0);
        port_in_08     : in   std_logic_vector (7 downto 0);
        port_in_09     : in   std_logic_vector (7 downto 0);
        port_in_10     : in   std_logic_vector (7 downto 0);
        port_in_11     : in   std_logic_vector (7 downto 0);
        port_in_12     : in   std_logic_vector (7 downto 0);
        port_in_13     : in   std_logic_vector (7 downto 0);
        port_in_14     : in   std_logic_vector (7 downto 0);
        port_in_15     : in   std_logic_vector (7 downto 0);                                                                   
        port_out_00    : out  std_logic_vector (7 downto 0);
        port_out_01    : out  std_logic_vector (7 downto 0);
        port_out_02    : out  std_logic_vector (7 downto 0);
        port_out_03    : out  std_logic_vector (7 downto 0);
        port_out_04    : out  std_logic_vector (7 downto 0);
        port_out_05    : out  std_logic_vector (7 downto 0);
        port_out_06    : out  std_logic_vector (7 downto 0);
        port_out_07    : out  std_logic_vector (7 downto 0);
        port_out_08    : out  std_logic_vector (7 downto 0);
        port_out_09    : out  std_logic_vector (7 downto 0);
        port_out_10    : out  std_logic_vector (7 downto 0);
        port_out_11    : out  std_logic_vector (7 downto 0);
        port_out_12    : out  std_logic_vector (7 downto 0);
        port_out_13    : out  std_logic_vector (7 downto 0);
        port_out_14    : out  std_logic_vector (7 downto 0);
        port_out_15    : out  std_logic_vector (7 downto 0));
	end component;
	
	--define the precise clock component
	component clock_div_prec
		port (Clock_in : in std_logic;
				Reset 	: in std_logic;
				Sel		: in std_logic_vector(1 downto 0);
				Clock_out: out std_logic);
	end component;
	
	--define the char-decoder component 
	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	
	--declare the signals to be used in the counter and computer
	signal Clock_div : std_logic;
	
	signal port_in_00, port_in_01, port_in_02, port_in_03,
			 port_in_04, port_in_05, port_in_06, port_in_07,
			 port_in_08, port_in_09, port_in_10, port_in_11,
			 port_in_12, port_in_13, port_in_14, port_in_15  	  : std_logic_vector(7 downto 0);
	
	signal port_out_00, port_out_01, port_out_02, port_out_03,
			 port_out_04, port_out_05, port_out_06, port_out_07,
			 port_out_08, port_out_09, port_out_10, port_out_11,
			 port_out_12, port_out_13, port_out_14, port_out_15  : std_logic_vector(7 downto 0);
	
	begin
----------------------------------------------------------------------------------------------------------------------------
		-- instantiate the precise clock counter
		PREC_CLOCK	: clock_div_prec port map (Clock_In => Clock_50, Reset => Reset, Sel => SW(9) & SW(8), Clock_Out => Clock_div);
		
----------------------------------------------------------------------------------------------------------------------------	
		-- instantiate the computer	
		COMP1	: computer port map (clock => clock_div, reset => Reset, port_in_00 => SW(7 downto 0), port_in_01 => "0000" & KEY(3 downto 0),
										port_in_02 => port_in_02, port_in_03 => port_in_03, port_in_04 => port_in_04, port_in_05 => port_in_05,
										port_in_06 => port_in_06, port_in_07 => port_in_07, port_in_08 => port_in_08, port_in_09 => port_in_09,
										port_in_10 => port_in_10, port_in_11 => port_in_11, port_in_12 => port_in_12, 	
										port_in_13 => port_in_13, port_in_14 => port_in_14, port_in_15 => port_in_15,
										port_out_00 => port_out_00, port_out_01 => port_out_01, port_out_02 => port_out_02, 
										port_out_03 => port_out_03, port_out_04 => port_out_04, port_out_05 => port_out_05,
										port_out_06 => port_out_06, port_out_07 => port_out_07, port_out_08 => port_out_08, port_out_09 => port_out_09,
										port_out_10 => port_out_10, port_out_11 => port_out_11, port_out_12 => port_out_12, 	
										port_out_13 => port_out_13, port_out_14 => port_out_14, port_out_15 => port_out_15);
		
				--instatiate the 6 char-decoders
		C0 : char_decoder port map (BIN_IN => port_out_01(3 downto 0), HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => port_out_01(7 downto 4), HEX_OUT => HEX1);
		C2 : char_decoder port map (BIN_IN => port_out_02(3 downto 0), HEX_OUT => HEX2);
		C3 : char_decoder port map (BIN_IN => port_out_02(7 downto 4), HEX_OUT => HEX3);
		C4 : char_decoder port map (BIN_IN => port_out_03(3 downto 0), HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => port_out_03(7 downto 4), HEX_OUT => HEX5);
		
		--tie LEDR and GPIO
		LEDR(7 downto 0) <= port_out_00;
		GPIO_0(7 downto 0) <= port_out_04;
		GPIO_0(15 downto 8) <= port_out_05;
-----------------------------------------------------------------------------------------------------------------------------	
		
		
		

			 
			 
end architecture; 