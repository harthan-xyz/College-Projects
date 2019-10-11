library IEEE;
use IEEE.std_logic_1164.all;

entity LED7 is
	port (clock	: in std_logic;
			LED	: out std_logic);
end entity;


architecture LED7_arch of LED7 is

	signal blink : std_logic :=  '0';

	begin
	
	--create a process to continuously blink LED(7)
	process (Clock)
		begin
			if (rising_edge(Clock)) then
				blink <= not blink;
			end if;
	end process;
	
	LED <= blink;
		
end architecture; 