-- Joshua Harthan, Jordan Palmer
-- State 6 : Swap A and B
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state6 is
	port(
		  A			  : in std_logic_vector(31 downto 0);
		  B			  : in std_logic_vector(31 downto 0);
		  
		  Result_High : out std_logic_vector(31 downto 0);
		  Result_Low  : out std_logic_vector(31 downto 0)
		  );
end entity;

architecture state6_arch of state6 is 
	
	begin
	 -- swap register A and register B --
	 Result_Low  <= B;
	 Result_High <= A;
end architecture;
