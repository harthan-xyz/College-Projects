library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity state1 is
	port (clock	: in std_logic;
	      Reset 	: in std_logic;
	      LED1	: out std_logic_vector(6 downto 0));
end entity;


architecture state1_arch of state1 is

	signal LED_register: std_logic_vector(6 downto 0) := "0000011"; --have LED(0) and LED(1) default as "on"
	
	begin
	
	--process that shifts the value of each LED to the left
	SHIFTL : process(clock,Reset)
		begin		
			if(reset = '0') then
				LED_register <= "0000011";
			elsif(rising_edge(clock)) then
				LED_register(0) <= LED_register(6);
            			LED_register(6) <= LED_register(5);
            			LED_register(5) <= LED_register(4);
            			LED_register(4) <= LED_register(3);
            			LED_register(3) <= LED_register(2);
            			LED_register(2) <= LED_register(1);
            			LED_register(1) <= LED_register(0);
			end if;
		end process;	
		
		LED1 <= LED_register; --assign shifted value to the output
		
	
end architecture;
