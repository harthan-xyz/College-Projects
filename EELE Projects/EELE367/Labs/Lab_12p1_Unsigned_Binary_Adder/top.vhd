--Joshua Harthan, Michael Valentino-Manno
--Lab 12.1 3/27/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

--define entities (6 7-segment decoders, LEDR)
entity top is 
	port(SW 	  		: in std_logic_vector  (7 downto 0);
		  LEDR  		: out std_logic_vector (9 downto 0);
		  HEX0  		: out std_logic_vector (6 downto 0);
		  HEX1  		: out std_logic_vector (6 downto 0);
		  HEX2  		: out std_logic_vector (6 downto 0);
		  HEX3  		: out std_logic_vector (6 downto 0);
		  HEX4  		: out std_logic_vector (6 downto 0);
		  HEX5  		: out std_logic_vector (6 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 

	--declare char_decoder component for hex displays
	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	--signals declaration for the addition
	signal sum_uns : unsigned(4 downto 0);
	signal sum		: std_logic_vector(3 downto 0);
	
	begin 
		
		sum_uns <= unsigned(('0' & SW(3 downto 0))) + unsigned(('0' & SW(7 downto 4)));
		sum <= std_logic_vector(sum_uns(3 downto 0));
		
---------------------------------------------------------	
	
		--instatiate the 6 char-decoders to display the values in hex
		C0 : char_decoder port map (BIN_IN => SW(3 downto 0), HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => SW(7 downto 4), HEX_OUT => HEX2);
		HEX1 <= "1111111";
		HEX3 <= "1111111";
		C4 : char_decoder port map (BIN_IN => sum, HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => "000" & sum_uns(4), HEX_OUT => HEX5);
	
			
		--tie LEDR to the value of the switches and carry bit
		LEDR(7 downto 0) <= SW(7 downto 0);
		LEDR(8) <= '0';
		LEDR(9) <=	sum_uns(4);
----------------------------------------------------------	
		
		
		
			 
			 
end architecture; 