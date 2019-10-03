library IEEE;
use IEEE.std_logic_1164.all;

entity SystemI is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     	  : out std_logic);
end entity;

architecture SystemI_arch of SystemI is

	
	begin

		process  (ABCD)
		  begin
	    
			if	(ABCD = "0001") then F <= '1';
			elsif 	(ABCD = "0011") then F <= '1';
			elsif 	(ABCD = "1001") then F <= '1';
			elsif 	(ABCD = "1011") then F <= '1';
			else 	F <= '0';
		 	end if;
		
		end process; 
		

end architecture;
