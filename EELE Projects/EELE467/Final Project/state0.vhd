-- Joshua Harthan, Jordan Palmer
-- State 0 : NOP
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state0 is
	port(
		  clk			  : in std_logic;
		  reset		  : in std_logic;
		  A			  : in std_logic_vector(31 downto 0);
		  B			  : in std_logic_vector(31 downto 0);
		  
		  Result_High : out std_logic_vector(31 downto 0);
		  Result_Low  : out std_logic_vector(31 downto 0);
		  Status		  : out std_logic_vector(2 downto 0)
		  );
end entity;

architecture state0_arch of state0 is 
	
	begin

end architecture;
