-- Quartus Prime VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;

entity state0 is
	port (clock	: in std_logic;
	      Reset 	: in std_logic;
	      LED0	: out std_logic_vector(6 downto 0));
end entity;

architecture state0_arch of state0 is

	signal LED_register: std_logic_vector(6 downto 0) := "1000000"; --have LED(6) default as "on"
	
	begin
	
	--process that shifts the value of each LED to the right
	SHIFTR : process(clock,Reset)
		begin		
			if(reset = '0') then
				LED_register <= "1000000";
			elsif(rising_edge(clock)) then
				LED_register(5) <= LED_register(6);
            			LED_register(4) <= LED_register(5);
            			LED_register(3) <= LED_register(4);
            			LED_register(2) <= LED_register(3);
            			LED_register(1) <= LED_register(2);
            			LED_register(0) <= LED_register(1);
            			LED_register(6) <= LED_register(0);
			end if;
		end process;	
		
		LED0 <= LED_register; --assign shifted value to the output

end architecture;



