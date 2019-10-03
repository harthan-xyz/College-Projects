--Joshua Harthan, Michael Valentino-Manno
--Lab 9.3 2/20/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

--define entities (6 7-segment decoders, LEDR, Clock, Reset, IO ports)
entity top is 
	port(Clock_50 	: in std_logic;
		  Reset 	: in std_logic;
		  SW 	  	: in std_logic_vector  (3 downto 0);
		  LEDR  	: out std_logic_vector (9 downto 0);
		  HEX0  	: out std_logic_vector (6 downto 0);
		  HEX1  	: out std_logic_vector (6 downto 0);
		  HEX2  	: out std_logic_vector (6 downto 0);
		  HEX3  	: out std_logic_vector (6 downto 0);
		  HEX4  	: out std_logic_vector (6 downto 0);
		  HEX5  	: out std_logic_vector (6 downto 0);
		  GPIO_1 : out std_logic_vector (7 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
	
	--instantiate the signals to be used in the d-flip-flops and counter
	signal CNT  : std_logic_vector(23 downto 0);
	signal CNTN : std_logic_vector(23 downto 0);
	signal Clock_div : std_logic;
	
	--instantiate the unsigned signal for the counter
	signal CNT_uns : unsigned(23 downto 0);
		
	--define the char-decoder component 
	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	--define the d-flip-flop component
	component dflipflop 
		port (Clock : in std_logic;
				Reset : in std_logic;
				D     : in std_logic;
				Q, Qn : out std_logic);
	end component;
	
	--define the multiplex component
	component clock_div_2ton
		port(Clock_In : in std_logic;
			  Reset	 : in std_logic;
			  Sel		 : in std_logic_vector(1 downto 0);
			  Clock_Out		: out std_logic);
	   end component;
	
	
	begin 
		
	----------------------------------------------------------------------------------------------------------------------------
		-- instantiate the 24 bit counter
		MUX	: clock_div_2ton port map (Clock_In => Clock_50, Reset => Reset, Sel => SW(0) & SW(1), Clock_Out => Clock_div);
		
		--create the counter
		COUNTER : process (Clock_div, Reset)
			begin
				if (Reset = '0') then
					CNT_uns <= "000000000000000000000000";
				elsif (rising_edge(Clock_div)) then
					CNT_uns <= CNT_uns + 1; 
				end if;
			end process;
			
		CNT <= std_logic_vector(CNT_uns);
	---------------------------------------------------------------------------------------------------------------------------					
	
		--instatiate the 6 char-decoders
		C0 : char_decoder port map (BIN_IN => CNT(3 downto 0), HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => CNT(7 downto 4), HEX_OUT => HEX1);
		C2 : char_decoder port map (BIN_IN => CNT(11 downto 8), HEX_OUT => HEX2);
		C3 : char_decoder port map (BIN_IN => CNT(15 downto 12), HEX_OUT => HEX3);
		C4 : char_decoder port map (BIN_IN => CNT(19 downto 16), HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => CNT(23 downto 20), HEX_OUT => HEX5);
		
		--tie LEDR to 10 least significant bits
		LEDR <= CNT(9 downto 0);
		--tie GPIO to 8 least significant bits
		GPIO_1 <= CNT(7 downto 0);
	---------------------------------------------------------------------------------------------------------------------------	
		
		
		
			 
			 
end architecture; 