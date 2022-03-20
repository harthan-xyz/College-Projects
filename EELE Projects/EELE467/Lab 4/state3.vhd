library IEEE;
use IEEE.std_logic_1164.all;

entity state3 is
	port (clock	: in std_logic;
			Reset : in std_logic;
			LED3	: out std_logic_vector(6 downto 0));
end entity;


architecture state3_arch of state3 is
	
	--define the up down counter
	component binary_up_down_counter is
		port
			(clk	 	: in std_logic;
			 reset 	: in std_logic;
			 updown	: in std_logic;
			 q		   : out std_logic_vector (6 downto 0));
	end component;


	begin
	
	--instantiate the up down counter, count down
	UDC : binary_up_down_counter port map(clk => clock, reset => Reset, updown => '0', q(6 downto 0) => LED3(6 downto 0));
	
end architecture;