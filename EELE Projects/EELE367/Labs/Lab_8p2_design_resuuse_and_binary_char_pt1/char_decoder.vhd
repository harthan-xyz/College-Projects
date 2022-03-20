library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity char_decoder is 
	port (BIN_IN  : in std_logic_vector (3 downto 0);
			HEX_OUT : out std_logic_vector (6 downto 0));
end entity;

architecture char_decoder_arch of char_decoder is 

	begin 
	
		
			process (BIN_IN)
				
				begin
				
					if    (BIN_IN = "0000") then HEX_OUT <= "1000000";
					elsif (BIN_IN = "0001") then HEX_OUT <= "1111001";
					elsif (BIN_IN = "0010") then HEX_OUT <= "0100100";
					elsif (BIN_IN = "0011") then HEX_OUT <= "0110000";
					elsif (BIN_IN = "0100") then HEX_OUT <= "0011001";
					elsif (BIN_IN = "0101") then HEX_OUT <= "0010010";
					elsif (BIN_IN = "0110") then HEX_OUT <= "0000010";
					elsif (BIN_IN = "0111") then HEX_OUT <= "1111000";
					elsif (BIN_IN = "1000") then HEX_OUT <= "0000000";
					elsif (BIN_IN = "1001") then HEX_OUT <= "0010000";
					elsif (BIN_IN = "1010") then HEX_OUT <= "0001000";
					elsif (BIN_IN = "1011") then HEX_OUT <= "0000011";
					elsif (BIN_IN = "1100") then HEX_OUT <= "0100111";
					elsif (BIN_IN = "1101") then HEX_OUT <= "0100001";
					elsif (BIN_IN = "1110") then HEX_OUT <= "0000110";
					elsif (BIN_IN = "1111") then HEX_OUT <= "0001110";
					else  HEX_OUT <= "1111111";
					
					end if;
			
			end process;
		
end architecture; 
