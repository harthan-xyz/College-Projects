library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity twos_comp_decoder is
	port (TWOS_COMP_IN	: in std_logic_vector(3 downto 0);
			MAG_OUT			: out std_logic_vector(6 downto 0);
			SIGN_OUT			: out std_logic_vector(6 downto 0));
end entity;

architecture twos_comp_decoder_arch of twos_comp_decoder is 

	begin
	
		
			process (TWOS_COMP_IN)
				
				begin
				
					if    (TWOS_COMP_IN = "0000") then MAG_OUT <= "1000000"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0001") then MAG_OUT <= "1111001"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0010") then MAG_OUT <= "0100100"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0011") then MAG_OUT <= "0110000"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0100") then MAG_OUT <= "0011001"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0101") then MAG_OUT <= "0010010"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0110") then MAG_OUT <= "0000010"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "0111") then MAG_OUT <= "1111000"; SIGN_OUT <= "1111111";
					elsif (TWOS_COMP_IN = "1000") then MAG_OUT <= "0000000"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1001") then MAG_OUT <= "1111000"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1010") then MAG_OUT <= "0000010"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1011") then MAG_OUT <= "0010010"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1100") then MAG_OUT <= "0011001"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1101") then MAG_OUT <= "0110000"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1110") then MAG_OUT <= "0100100"; SIGN_OUT <= "0111111";
					elsif (TWOS_COMP_IN = "1111") then MAG_OUT <= "1111001"; SIGN_OUT <= "0111111";
					else  MAG_OUT <= "1111111"; SIGN_OUT <= "1111111";
					
					end if;
			
			end process;
	
	
end architecture; 