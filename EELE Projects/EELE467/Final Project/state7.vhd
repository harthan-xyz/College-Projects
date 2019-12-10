-- Joshua Harthan, Jordan Palmer
-- State 7 : A OR B 
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state7 is
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

architecture state7_arch of state7 is 
	
	signal OR_result 	: std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	
	begin
	
	 -- OR calculation --
	 OR_CALC : process(clk, reset)
		begin
			if (reset = '0') then
				OR_result <= std_logic_vector(to_unsigned(0,32));
			elsif(rising_edge(clk)) then
				OR_result  <= A OR B;
			end if;
		end process;
		
		--assign the calculated value to the corresponding registers
		Result_Low <= OR_result;
		Result_High(31 downto 0) <= std_logic_vector(to_unsigned(0,32));
		
		-- negative flag (N) --
		NEGATIVE_FLAG : process(clk, reset)
		 begin
			if(reset = '0') then
				Status(1) <= '0';
			elsif(rising_edge(clk)) then
				Status(1) <= OR_result(31);
			end if;
		end process;

		-- zero flag (Z) --
		ZERO_FLAG : process (clk, reset)
		 begin
			if (reset = '0') then
				Status(0) <= '0';
			elsif(rising_edge(clk)) then
				if(OR_result(31 downto 0) = x"00") then
					Status(0) <= '1';
				else
					Status(0) <= '0';
				end if;
			end if;
		end process;

		-- overflow flag / carry flag (F) --
		OVERFLOW_FLAG : process(clk, reset)
		 begin
			if (reset = '0') then
				Status(2) <= '0';
			elsif(rising_edge(clk)) then
				Status (2) <= '0'; -- there will be no overflow in an OR operation
			end if;
		end process;
	
end architecture;
