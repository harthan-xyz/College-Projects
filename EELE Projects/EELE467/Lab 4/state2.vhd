library IEEE;
use IEEE.std_logic_1164.all;

entity state2 is
	port (clock	: in std_logic;
			Reset : in std_logic;
			LED2	: out std_logic_vector(6 downto 0));
end entity;


architecture state2_arch of state2 is

	--define the up down counter
	component binary_up_down_counter is
		port
			(clk	 	: in std_logic;
			 reset 	: in std_logic;
			 updown	: in std_logic;
			 q		   : out std_logic_vector (6 downto 0));
	end component;


	begin
	
	--instantiate the up down counter, count up
	UDC : binary_up_down_counter port map(clk => clock, reset => Reset, updown => '1', q(6 downto 0) => LED2(6 downto 0));
	
end architecture;