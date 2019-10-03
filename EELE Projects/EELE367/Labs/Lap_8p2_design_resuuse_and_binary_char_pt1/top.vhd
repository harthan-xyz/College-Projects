library IEEE;
use IEEE.STD_Logic_1164.ALL;

entity top is 
	port(SW : in std_logic_vector(3 downto 0);
LEDR : out std_logic_vector (3 downto 0);
HEX0 : out std_logic_vector (6 downto 0);
HEX1 : out std_logic_vector (6 downto 0);
HEX2 : out std_logic_vector (6 downto 0);
HEX3 : out std_logic_vector (6 downto 0);
HEX4 : out std_logic_vector (6 downto 0);
HEX5 : out std_logic_vector (6 downto 0));
end entity; 

architecture top_arch of top is 

	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	begin 
	
		LEDR <= SW;
		C0 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX1);
		C2 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX2);
		C3 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX3);
		C4 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => SW, HEX_OUT => HEX5);
	
		
end architecture; 