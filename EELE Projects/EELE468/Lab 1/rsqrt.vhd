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
		 clk: in std_logic;
		 Y  : out std_logic_vector(W_bits - 1 downto 0));
end entity;

architecture rsqrt_arch of rsqrt is

	-- Declare the Y0 component to get the intitial guess
	component compute_y0 is
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(clk	      : in std_logic;
			 x 	      : in std_logic_vector(W_bits - 1 downto 0);
			 y0 	      : out std_logic_vector(W_bits - 1 downto 0));
	end component;	
	
	-- create signals that utilize the generic values input for the math in Newton's iterations
	signal   result, y2, xy2, minus, number, word_register : unsigned(W_bits - 1 downto 0) := (others => '0');
	signal   delayX_1, delayX_2, delayX_3 : unsigned(W_bits - 1 downto 0) := (others => '0');
	constant three_uns : unsigned(W_bits - 1 downto 0) := ((F_bits + 1) downto (F_bits) => '1', others => '0'); 
	constant UPPER : integer := (W_bits * 2) - F_bits - 1;
	constant LOWER : integer := W_bits - F_bits;
	signal   mult_temp1, mult_temp2, mult_temp3 : unsigned(W_bits*2 - 1 downto 0) := (others => '0');
	signal   Y0, Y_result : std_logic_vector(W_bits - 1 downto 0) := (others => '0');

	begin
	
	-- instantiate the initial guess component
	INITIAL_GUESS : compute_y0 generic map (W_bits => W_bits, F_bits => F_bits)
				   port map (clk => clk, x => X, y0 => Y0);

	DELAY : process(clk)
		begin
		if(rising_edge(clk)) then
			delayX_1 <= unsigned(X);
			delayX_2 <= delayX_1;
			delayX_3 <= delayX_2;
		end if;
	end process;

	-- (y_n)^(2)
	NEWTONS1 : process(Y0, clk) 
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
		mult_temp2 <= delayX_3 * y2;
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
	
	-- assign the calculated value to the output on the rising edge of the clock
	ASSIGN_OUTPUT : process (clk, result)
		begin
		if (rising_edge(clk)) then		
			Y_result <= std_logic_vector(result);
		end if;
	end process;
	Y <= Y_result;
end architecture; 
