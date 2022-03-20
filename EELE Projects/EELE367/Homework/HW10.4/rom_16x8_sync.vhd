library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_16x8_sync is 
	port (Clock  	: in std_logic;
	      Address	: in std_logic_vector(3 downto 0);
	      Data_out	: out std_logic_vector(7 downto 0));
end entity;

architecture rom_16x8_sync_arch of rom_16x8_sync is

	type ROM_type is array (0 to 15) of std_logic_vector(7 downto 0);
	
	constant ROM : ROM_type := 	(0  => x"FF",
				    	1  => x"EE",
			           	2  => x"DD",
				    	3  => x"CC",
					4  => x"BB",
					5  => x"AA",
					6  => x"99",
					7  => x"88",
					8  => x"77",
					9  => x"66",
					10 => x"55",
					11 => x"44",
					12 => x"33",
					13 => x"22",
					14 => x"11",
					15 => x"00");									 
	
	begin
		MEMORY : process (Clock)
			begin 
				if (rising_edge(Clock)) then
					Data_out <= ROM (to_integer(unsigned(address)));
				end if;
		end process;	
		
end architecture;
