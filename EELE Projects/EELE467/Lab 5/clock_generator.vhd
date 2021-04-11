-- Joshua Harthan
-- EELE 467
-- Clock Generator
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_generator is
	port(clk            : in  std_logic;                                           
             SYS_CLKs_sec   : in  std_logic_vector(31 downto 0);    
             Base_rate      : in  std_logic_vector(7 downto 0);     
	     Clock_out      : out std_logic
    );
end entity clock_generator;
	
	
architecture clock_generator_arch of clock_generator is
	
	--signals to be used in the clock generation processes
	signal clock : std_logic;
	signal clock_prescaler : unsigned(39 downto 0);
	signal conversion : unsigned(34 downto 0);
	signal counter : integer := 0;

	
	begin
	
	--multiply the base rate by the number of clocks in one second
	clock_prescaler <= unsigned(SYS_CLKs_sec) * unsigned(Base_rate);
	conversion <= clock_prescaler(39 downto 5); --convert this product, as base_rate is fixed point

	--generate a new clock for the converted clock based off base rate
	CLOCK_GEN : process(clk)
		begin
			if (rising_edge(clk)) then
				if (counter = conversion) then 
					Clock_out <= clock;
					clock <= not clock;
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
	end process;
	
end architecture;
