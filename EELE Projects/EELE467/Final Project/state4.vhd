-- Joshua Harthan, Jordan Palmer
-- State 4 : Decrement by One 
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity state4 is
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

architecture state4_arch of state4 is 

	-- difference signed signal to store result, 33 bits in case of overflow
	signal Dif_1 : signed(32 downto 0) := to_signed(0,33);
	
	begin
	
	 -- difference calculation --
	 DIF : process(clk, reset)
		begin
			if (reset = '0') then
				Dif_1 <= to_signed(0,33);
			elsif(rising_edge(clk)) then
				Dif_1 <= signed('0' & B) - to_signed(1,33);
			end if;
	  end process;
	  
	  --assign the calculated value to the corresponding registers
	  Result_Low <= std_logic_vector(Dif_1(31 downto 0));
	  Result_High <= std_logic_vector(to_unsigned(0,32));
	
		-- negative flag (N) --
		NEGATIVE_FLAG : process(clk, reset)
		 begin
			if(reset = '0') then
				Status(1) <= '0';
			elsif(rising_edge(clk)) then
				if(Dif_1 < x"00" and Dif_1(31 downto 0) /= x"00") then	
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
				if(Dif_1(31 downto 0) = x"00") then
					Status(0) <= '1';
				else
					Status(0) <= '0';
				end if;
			end if;
		end process;

	
end architecture;
