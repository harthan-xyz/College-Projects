-- Joshua Harthan
-- Compute x_alpha = x*2^(alpha)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity X_alpha is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits

	port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
		 clk		: in std_logic;
		 X_ALPHA  	: out std_logic_vector(W_bits - 1 downto 0));
end entity;


architecture X_alpha_arch of X_alpha is

	signal X_A_EVEN	   : std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_A_ODD	   : std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_UNS       : unsigned (W_bits - 1 downto 0) := (others => '0');
	signal ALPHA_ODD   : integer := 0;
	signal ALPHA_EVEN  : integer := 0;
	signal ODD_OR_EVEN : std_logic := '0';

	-- Instantiate the components to compute ALPHA for odd or even
	component Beta_even is 
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(clk	      : in std_logic;
			 X	      : in std_logic_vector(W_bits - 1 downto 0);
			 Odd_or_Even  : out std_logic;
			 A	      : out integer);
	end component;

	component Beta_odd is 
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(clk	      : in std_logic;
			 X	      : in std_logic_vector(W_bits - 1 downto 0);
			 Odd_or_Even  : out std_logic;
			 A	      : out integer);
	end component;

	begin

	-- Typecast the X input into unsigned to allow for shifting
	ASSIGN_X : process(clk, X)
		begin
		X_UNS <= unsigned(X);
	end process;

	-- Declare the BETA components, one for odd and even
	BETA_EVEN1 : Beta_even generic map(W_bits => W_bits, F_bits => F_bits)
			       port map (clk => clk, X => X, Odd_or_Even => ODD_OR_EVEN, A => ALPHA_EVEN);

	BETA_ODD1 : Beta_odd generic map(W_bits => W_bits, F_bits => F_bits)
			       port map (clk => clk, X => X, Odd_or_Even => ODD_OR_EVEN, A => ALPHA_ODD);


	-- Find X_ALPHA by shifting input X by ALPHA bits
	SHIFT_EVEN_A : process(clk, ALPHA_EVEN)
		begin
		X_A_EVEN <= std_logic_vector(shift_left(X_UNS, ALPHA_EVEN));
	end process; 

	SHIFT_ODD_A : process(clk, ALPHA_ODD) 
		begin
		X_A_ODD <= std_logic_vector(shift_left(X_UNS, ALPHA_ODD));
	end process;
	
	-- Based off ODD_OR_EVEN, assign the appropriate value to the output X_ALPHA
	ASSIGN_OUTPUT : process(clk, X_A_ODD, X_A_EVEN)
		begin
			if (ODD_OR_EVEN = '0') then
				X_ALPHA <= X_A_EVEN;
			else
				X_ALPHA <= X_A_ODD;
			end if;
	end process;
end architecture;