--Joshua Harthan, Michael Valentino-Manno
--Lab 8.2 1/30/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;

--define entities (4 7-segment decoder)
entity top is 
	port(SW : in std_logic_vector(3 downto 0);
LEDR : out std_logic_vector (3 downto 0);
HEX0 : out std_logic_vector (6 downto 0);
HEX1 : out std_logic_vector (6 downto 0);
HEX2 : out std_logic_vector (6 downto 0);
HEX3 : out std_logic_vector (6 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
--component converts input to output
	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	
	begin 
	--concatenation to achieve 0 or 1
		LEDR <= SW;
		C0 : char_decoder port map (BIN_IN => "000" & SW(0), HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => "000" & SW(1), HEX_OUT => HEX1);
		C2 : char_decoder port map (BIN_IN => "000" & SW(2), HEX_OUT => HEX2);
		C3 : char_decoder port map (BIN_IN => "000" & SW(3), HEX_OUT => HEX3);	
		
end architecture; 