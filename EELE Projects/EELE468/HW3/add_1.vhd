-- Joshua Harthan
-- ADD 1 Component that adds one to an input
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity add_1 is 
	port(A : in std_logic_vector(3 downto 0);
	     B : out std_logic_vector(3 downto 0));
end entity;

architecture add_1_arch of add_1 is
    signal sum_uns : unsigned(4 downto 0);

    begin
	ADD1 : process (A)
	   begin
		sum_uns <= unsigned('0' & A) + 1;
	end process;

	B <= std_logic_vector(sum_uns(3 downto 0));
end architecture; 