-- Joshua Harthan, Jordan Palmer
-- Multiplexer Component
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity mux is
	port(
	     A	  	 : in std_logic_vector(31 downto 0);
	     B	  	 : in std_logic_vector(31 downto 0); 
	     Result_High : in std_logic_vector(31 downto 0);
	     Result_Low  : in std_logic_vector(31 downto 0);
		  
	     SW		 : in std_logic_vector(3 downto 0); 
	     LED 	 : out std_logic_vector(7 downto 0)
	     );
end entity;

architecture mux_arch of mux is
	
	--signal to determine register to display on LEDs
	signal active_register : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	
	begin
	
	REGISTER_CONTROL : process(SW)
		begin
			case(SW(3 downto 2)) is
				when "00" => active_register <= A;
				when "01" => active_register <= B;
				when "10" => active_register <= Result_Low;
				when "11" => active_register <= Result_High;
				when others => active_register <= (others=>'0');
			end case;
	end process;
	
	DISPLAY_BYTE : process(SW)
		begin
			case(SW(1 downto 0)) is 
				when "00" => LED <= active_register(7 downto 0);
				when "01" => LED <= active_register(15 downto 8);
				when "10" => LED <= active_register(23 downto 16);
				when "11" => LED <= active_register(31 downto 24);
				when others => LED <= (others=>'0');
			end case;
	end process;
	
end architecture;
