--Joshua Harthan, Michael Valentino-Manno
--Lab 10.1 3/6/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

--define entities (6 7-segment decoders, LEDR, Clock, Reset, IO ports)
entity top is 
	port(Clock_50 	: in std_logic;
		  Reset 		: in std_logic;
		  SW 	  		: in std_logic_vector  (3 downto 0);
		  LEDR  		: out std_logic_vector (9 downto 0);
		  HEX0  		: out std_logic_vector (6 downto 0);
		  HEX1  		: out std_logic_vector (6 downto 0);
		  HEX2  		: out std_logic_vector (6 downto 0);
		  HEX3  		: out std_logic_vector (6 downto 0);
		  HEX4  		: out std_logic_vector (6 downto 0);
		  HEX5  		: out std_logic_vector (6 downto 0);
		  GPIO_1 	: out std_logic_vector (14 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
	
	--instantiate the signals to be used in the d-flip-flops and counter
	signal CNT  : std_logic_vector(23 downto 0);
	signal CNTN : std_logic_vector(23 downto 0);
	signal Clock_div : std_logic;					
	signal BCD0_int : integer range 0 to 9;
	signal BCD1_int : integer range 0 to 9;
	signal BCD2_int : integer range 0 to 9;
	signal BCD3_int : integer range 0 to 9;
	signal BCD4_int : integer range 0 to 9;
	signal BCD5_int : integer range 0 to 9;
	signal BCD0, BCD1, BCD2,BCD3,BCD4,BCD5 : std_logic_vector(3 downto 0);
	signal ROM_address :  std_logic_vector(5 downto 0);
	signal ROM_data_out : std_logic_vector (7 downto 0);
	signal ROM_int	 : integer range 0 to 63;
	
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
		port(Clock_in 	: in std_logic;
			  Reset	 	: in std_logic;
			  Sel		 	: in std_logic_vector(1 downto 0);
			  Clock_Out	: out std_logic);
	end component;
	
	--define the precise clock component
	component clock_div_prec
		port (Clock_in : in std_logic;
				Reset 	: in std_logic;
				Sel		: in std_logic_vector(1 downto 0);
				Clock_out: out std_logic);
	end component;
	
	--define the 64x8 bit ROM component
	component rom_64x8_sync
		port(Clock 		: in std_logic;
			  Address	: in std_logic_vector(5 downto 0);
			  data_out	: out std_logic_vector(7 downto 0));
	end component;  
	
	begin 
		
	----------------------------------------------------------------------------------------------------------------------------
		-- instantiate the precise clock counter
		PREC_CLOCK	: clock_div_prec port map (Clock_In => Clock_50, Reset => Reset, Sel => SW(0) & SW(1), Clock_Out => Clock_div);
		
		--create the counter
		CLOCK : process (Clock_div, Reset)
			begin
				if (Reset = '0') then
					CNT_uns <= "000000000000000000000000";
				elsif (rising_edge(Clock_div)) then
					CNT_uns <= CNT_uns + 1; 
				end if;
			end process;
			
		CNT <= std_logic_vector(CNT_uns);


	
	--instantiate the ROM ports
	ROM : rom_64x8_sync port map (Clock => Clock_div, Address => ROM_address, data_out => ROM_data_out);
	
	---------------------------------------------------
	ROM_counter : process (Clock_div, Reset)
	   begin
	       if (Reset = '0') then
				ROM_int <= 0;
          elsif (rising_edge(Clock_div)) then
				if(ROM_int = 63)  then
					ROM_int <= 0;
				else
					ROM_int <= ROM_int + 1;
				end if; 	
			end if;
		end process;	
	
	ROM_address <= std_logic_vector(to_unsigned(ROM_int, 6));
---------------------------------------------------------	
	BCD0 <= ROM_data_out(3 downto 0);
	BCD1 <= ROM_data_out(7 downto 4);
	
	BCD4 <=  ROM_address(3 downto 0);
	BCD5 <= "00" & ROM_address(5 downto 4);
	
		--instatiate the 6 char-decoders
		C0 : char_decoder port map (BIN_IN => BCD0, HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => BCD1, HEX_OUT => HEX1);
		HEX2 <= "1111111";
		HEX3 <= "1111111";
		C4 : char_decoder port map (BIN_IN => BCD4, HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => BCD5, HEX_OUT => HEX5);
	
			
		--tie LEDR(0) to the clock_div signal coming out of clock
		LEDR(0) <= Clock_div;
		--tie GPIO to the clock_div signal coming out of clock
		GPIO_1(14) <= Clock_div;
		GPIO_1(7 downto 0)  <= ROM_data_out;
		GPIO_1(13 downto 8) <= ROM_address;
		
	-------------------------------------------------	
		
		
		
			 
			 
end architecture; 