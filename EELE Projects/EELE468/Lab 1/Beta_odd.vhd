-- Joshua Harthan
-- A function that computes alpha = -2*beta + 1/2*beta + 1/2 when beta is found to be odd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Beta_odd is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits

	port 	(clk	      : in std_logic;
		 X	      : in std_logic_vector(W_bits - 1 downto 0);
		 Odd_or_Even  : out std_logic;
		 A	      : out integer);
end entity;

architecture Beta_odd_arch of Beta_odd is
	
	-- declare the signals to represent the values calculated
	signal A_sign	   : signed(5 downto 0) := (others => '0');	
	signal B_sign	   : signed(4 downto 0) := (others => '0');
	signal HALFBETA	   : signed(5 downto 0) := (others => '0');
	signal TWOBETA     : signed(5 downto 0) := (others => '0');
	signal ONE	   : integer := 1;
	signal ONE_SIGNED  : signed(5 downto 0) := (others => '0');
	signal HALF	   : signed(5 downto 0) := (others => '0');

	-- instantiate the components to compute y0
	component Compute_B is	
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(clk	      : in std_logic;
			 x	      : in std_logic_vector(W_bits - 1 downto 0);
			 B 	      : out signed(4 downto 0);
			 Odd_or_Even  : out std_logic); -- EVEN = 0, ODD = 1
	end component;


	begin

	-- Create the one and one half signal to be used in a calculation
	ONE_SIGNED <= to_signed(ONE, 5) & '0';
	HALF <= shift_right(ONE_SIGNED,1);
	
	-- instantiate the BETA component
	BETA : Compute_B generic map(W_bits => W_bits, F_Bits => F_bits) 
			 port map (clk => clk, x => X, B => B_sign, Odd_or_Even => Odd_or_Even);

	-- Calculate 2*BETA
	SHIFT_BETA_LEFT : process(clk, B_sign)
		begin
			TWOBETA <= shift_left('0' & B_sign,1);
	end process;

	-- Calculate 1/2*BETA
	SHIFT_BETA_RIGHT : process(clk, B_sign)
		begin
			HALFBETA <= shift_right('0' & B_sign,1);
	end process;

	-- Compute ALPHA = -2*BETA + 1/2*BETA + 1/2
	COMPUTE : process(clk, B_sign, HALFBETA, TWOBETA)
		begin
			A_sign <=  HALFBETA - TWOBETA + HALF;
	end process;

	-- Assign the calculated value to the output
	A <= to_integer(A_sign);

end architecture; 

