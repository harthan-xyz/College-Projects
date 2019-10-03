library IEEE;
use IEEE.std_logic_1164.all;

entity SystemJ is
   port (ABCD  	  : in  std_logic_vector(3 downto 0);
         F     	  : out std_logic);
end entity;

architecture SystemJ_arch of SystemJ is

	
	begin

		process  (ABCD)
		  begin
	    
			if	(ABCD = "0100") then F <= '1';
			elsif 	(ABCD = "0101") then F <= '1';
			elsif 	(ABCD = "0111") then F <= '1';
			elsif 	(ABCD = "1100") then F <= '1';
			elsif 	(ABCD = "1101") then F <= '1';
			elsif 	(ABCD = "1111") then F <= '1';
			else 	F <= '0';
		 	end if;
		
		end process; 
		

end architecture;
