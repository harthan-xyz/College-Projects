-- Joshua Harthan, Jordan Palmer
-- State 3 : Multiplication
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state3 is
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

architecture state3_arch of state3 is 

	-- product signals to store result, 64 bits because of multiplication
	signal Product_sign: signed(63 downto 0) := to_signed(0,64);
	
	begin
	
	  -- multiplication calculation --
	  MULT : process(clk, reset)
		begin
			if (reset = '0') then
				Product_sign <= to_signed(0,64);
			elsif(rising_edge(clk)) then
				Product_sign <= signed(A) * signed(B); 
			end if;
		end process;
	
		--assign the calculated value to the corresponding registers		
		Result_Low 	<= std_logic_vector(Product_sign(31 downto 0));
		Result_High	<= std_logic_vector(Product_sign(63 downto 32));
		
		-- negative flag (N) --
		NEGATIVE_FLAG : process(clk, reset)
		 begin
			if(reset = '0') then
				Status(1) <= '0';
			elsif(rising_edge(clk)) then
				if(Product_sign(63 downto 0) < x"00" and Product_sign(63 downto 0) /= x"00") then
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
				if(Product_sign (63 downto 0) = x"00") then
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
				if (Product_sign(63 downto 32) = x"00" or
					(Product_sign(63 downto 32) = x"FF")) then
					Status(2) <= '0';
				else
					Status(2) <= '1';
				end if;
			end if;
		end process;
	
end architecture;
