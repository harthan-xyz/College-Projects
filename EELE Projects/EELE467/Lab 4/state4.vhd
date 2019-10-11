library IEEE;
use IEEE.std_logic_1164.all;

entity state4 is
	port (clock	: in std_logic;
			Reset : in std_logic;
			LED4	: out std_logic_vector(6 downto 0));
end entity;


architecture state4_arch of state4 is

	signal LED_register: std_logic_vector(6 downto 0) := (others => '0');
	signal count : integer;
	signal input : std_logic := '0';
	
	begin
	
	--processes that shift multiple LEDs back and forth
	COUNTER : process (clock)
		begin
			if (count = 7) then
				input <= not input;
				count <= 0;
			elsif(rising_edge(clock)) then
				count <= count + 1;
				input <= not input;
			end if;
		end process;
	
	SHIFTR : process(clock,Reset)
		begin		
			if(reset = '0') then
				LED_register <= "0000000";
			elsif(rising_edge(clock)) then
				LED_register(6) <= input;
				LED_register(5 downto 0) <= Led_register(6 downto 1);
			end if;
		end process;	
		
		LED4 <= LED_register;
	
end architecture;