-- Joshua Harthan
-- Root Square Root file that implements Newton's iteration with generic W and F bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rsqrt is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16; -- number of fractional bits
		 N_iterations : positive := 3); -- number of Newton's iterations

	port 	(X  : in std_logic_vector(W_bits - 1 downto 0);
		 Y0 : in std_logic_vector(W_bits - 1 downto 0);
		 Y  : out std_logic_vector(W_bits - 1 downto 0));
end entity;

architecture rsqrt_arch of rsqrt is
	
	-- create signals that utilize the generic values input for the math in Newton's iterations
	signal result, y2, xy2, minus, number, word_register : unsigned(W_bits - 1 downto 0);
	signal three_uns : unsigned(W_bits - 1 downto 0) := ((F_bits + 1) downto (F_bits) => '1', others => '0'); 
	signal UPPER : integer := (W_bits *2) - F_bits - 1;
	signal LOWER : integer := W_bits - F_bits;
	signal mult_temp1, mult_temp2, mult_temp3 : unsigned(W_bits*2 - 1 downto 0);

	begin

	-- (y_n)^(2)
	NEWTONS1 : process(Y0) 
		begin
		mult_temp1 <= (unsigned(Y0) * unsigned(Y0));
	end process;

	-- resize the result
	RESIZE1 : process (mult_temp1)
		begin	
		y2 <= (mult_temp1(UPPER downto LOWER));
	end process;

	-- x*(y_n^(2))
	NEWTONS2: process(y2)
		begin
		mult_temp2 <= unsigned(X) * y2;
	end process;

	-- resize the result
	RESIZE2: process (mult_temp2)
		begin
		xy2 <= (mult_temp2(UPPER downto LOWER));
	end process;

	-- 3 - x*(y_n^(2))
	NEWTONS3 : process(xy2)
		begin
		word_register <= three_uns - xy2;
	end process;

	-- resize the result
	RESIZE3 : process(word_register)
		begin
		minus <= word_register(W_bits-1 downto 0);
	end process;

	-- y_n * (3 - x*(y_n^(2)))
	NEWTONS4 : process(minus)
		begin
		mult_temp3 <= unsigned(Y0) * minus;
	end process;

	--resize the result
	RESIZE4 : process(mult_temp3)
		begin
		number <= (mult_temp3(UPPER downto LOWER));
	end process;
		
	-- (y_n * (3 - x*(y_n^(2))))/2
	SHIFT : process (number)
		begin
		result <= shift_right(number,1);
	end process;

	-- assign the calculated value to the output
	Y <= std_logic_vector(result);
end architecture; 
