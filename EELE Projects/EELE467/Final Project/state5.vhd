-- Joshua Harthan, Jordan Palmer
-- State 5 : Move A 
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state5 is
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

architecture state5_arch of state5 is 
	
	signal A_sign : signed(31 downto 0);
	
	begin
	
		A_sign <= signed(A);
	
	 -- move register A into the Result register --
		Result_Low  <= A;
		Result_High <= std_logic_vector(to_signed(0,32));	
		
		-- negative flag (N) --
		NEGATIVE_FLAG : process(clk, reset)
		 begin
			if(reset = '0') then
				Status(1) <= '0';
			elsif(rising_edge(clk)) then
				if(A_sign(31 downto 0) < x"00" and A_sign(31 downto 0) /= x"00") then
					Status(1) <= '1';
				else
					Status(1) <= '0';
				end if;
			end if;
		end process;

		-- zero flag (Z) --
		ZERO_FLAG : process (clk, reset)
		 begin
			if (reset = '0') then
				Status(0) <= '0';
			elsif(rising_edge(clk)) then
				if(A_sign(31 downto 0) = x"00") then
					Status(0) <= '1';
				else
					Status(0) <= '0';
				end if;
			end if;
		end process;

end architecture;
