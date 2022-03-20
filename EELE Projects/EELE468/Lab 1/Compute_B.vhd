-- Joshua Harthan
-- A function that computes BETA = W - F - Z - 1 and notes whether the result is even or odd 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Compute_B is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits
	port 	(clk	      : in std_logic;
		 x	      : in std_logic_vector(W_bits - 1 downto 0);
		 B 	      : out signed(4 downto 0);
		 Odd_or_Even  : out std_logic); -- EVEN = 0, ODD = 1
end entity;

architecture Compute_B_arch of Compute_B is
	
	-- declare signals used in the calculation
	signal Z_vector 	: std_logic_vector(4 downto 0) := (others => '0');
	signal Z_int		: integer := 0;
	signal B_int		: integer := 0;
	signal B_vec		: signed(4 downto 0) := (others => '0');
	signal Odd_Even		: std_logic := '0';


	-- instantiate the lzc component to get the leading number of zeros for the calculation
	component lzc is
		port (clk        : in  std_logic;
        	      lzc_vector : in  std_logic_vector (31 downto 0);
        	      lzc_count  : out std_logic_vector ( 4 downto 0));
	end component;

	begin	
	
	-- Declare the lzc component
	LEADING_ZEROS : lzc port map(clk => clk, lzc_vector => x, lzc_count => Z_vector);
	
	-- Convert the z_vector into an integer for easier math operations
	ASSIGN_Z : process(clk, Z_vector)
		begin
		Z_int <= to_integer(unsigned(Z_vector));
	end process;

	-- Do the calculation Beta = W - F - Z - 1, output this as a signed vector (only negative is -1)
	CALCULATE_BETA : process(clk, Z_int)
		begin
		B_int <= W_bits - F_bits - Z_int - 1;
	end process;
	
	ASSIGN_BETA_VECTOR : process(clk, B_int)
		begin
		B_vec <= to_signed(B_int, 5);
	end process;
	
	-- Determine whether beta is odd or even, and output the corresponding flag
	ODD_EVEN1 : process (clk, B_vec)
		begin
			if(B_vec(0) = '0') then
				Odd_Even <= '0';
			else
				Odd_Even <= '1';
			end if;
	end process;

	-- assign the calculated value to the output
	Odd_or_Even <= Odd_Even;
	B <= B_vec;

end architecture; 

