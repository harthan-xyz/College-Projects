-- Quartus Prime VHDL Template
-- Binary Up/Down Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_up_down_counter is

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 127
	);

	port
	(
		clk		   : in std_logic;
		reset	   	: in std_logic;
		updown	   : in std_logic;
		q		   	: out std_logic_vector(6 downto 0)
	);

end entity;

architecture rtl of binary_up_down_counter is
		signal direction : integer;
	begin

		process (updown)
			begin
			-- Determine the increment/decrement of the counter
				if (updown = '1') then
					direction <= 1;
				else
					direction <= -1;
				end if;
		end process;


	process (clk)
		variable   cnt	: integer range MIN_COUNT to MAX_COUNT;
		
		begin
			if (reset = '0') then
			-- Reset the counter to 0
				cnt := 0;
			-- Synchronously update counter
			elsif (rising_edge(clk)) then
				-- Increment/decrement the counter
					cnt := cnt + direction;
			end if;

		-- Output the current count
		q <= std_logic_vector(to_unsigned(cnt, q'length));
		
	end process;
end rtl;
