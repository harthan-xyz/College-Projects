library IEEE;
use IEEE.STD_Logic_1164.ALL;

entity top is 
	port(SW   : in std_logic_vector (3 downto 0);
		  LEDR :	out std_logic_vector (3 downto 0);
		  HEX0 :	out std_logic_vector (6 downto 0));
end entity; 

architecture top_arch of top is 

	begin 
	
		LEDR <= SW;
			process (SW)
				begin
				
					if    (SW = "0000") then HEX0 <= "0000001";
					elsif (SW = "0001") then HEX0 <= "1001111";
					elsif (SW = "0010") then HEX0 <= "0010010";
					elsif (SW = "0011") then HEX0 <= "0000110";
					elsif (SW = "0100") then HEX0 <= "1001100";
					elsif (SW = "0101") then HEX0 <= "0100100";
					elsif (SW = "0110") then HEX0 <= "0100000";
					elsif (SW = "0111") then HEX0 <= "0001111";
					elsif (SW = "1000") then HEX0 <= "0000000";
					elsif (SW = "1001") then HEX0 <= "0000100";
					elsif (SW = "1010") then HEX0 <= "0001000";
					elsif (SW = "1011") then HEX0 <= "1100000";
					elsif (SW = "1100") then HEX0 <= "1110010";
					elsif (SW = "1101") then HEX0 <= "1000010";
					elsif (SW = "1110") then HEX0 <= "0110000";
					elsif (SW = "1111") then HEX0 <= "0111000";
					else  HEX0 <= "1111111";
				
			end process;
		
end architecture; 