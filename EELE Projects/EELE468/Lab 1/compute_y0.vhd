
-- Joshua Harthan
-- A function that computes Y_0 = X_ALPHA*(X_BETA)^(-3/2) if BETA is even, and Y_0 = X_ALPHA*(X_BETA)^(-3/2)*2^(-1/2) if BETA is odd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Compute_y0 is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits

	port 	(clk	      : in std_logic;
		 x 	      : in std_logic_vector(W_bits - 1 downto 0);
		 y0 	      : out std_logic_vector(W_bits - 1 downto 0));
end entity;

architecture Compute_y0_arch of Compute_y0 is
	
	-- Declare the signals used in the calculation
	signal ODD_OR_EVEN	: std_logic := '0';
	signal X_A		: std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_A_UNS		: unsigned(W_bits - 1 downto 0) := (others => '0');
	signal X_B		: std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_B_UNS	 	: unsigned(W_bits - 1 downto 0) := (others => '0');
	constant TOH_UNS	: unsigned(W_bits - 1 downto 0) := (W_bits - 1 downto F_bits - 1 => '0')&(F_bits - 2 => '1')& (F_bits - 3 => '0')&(F_bits - 4 downto F_bits - 5 => '1')&(F_bits - 6 => '0')&(F_bits - 7 downto F_bits - 8 => '1')&(F_bits - 9 downto 0 => '0');  -- .71
	signal Y_0_Product_Even	: unsigned(W_bits*2 - 1 downto 0) := (others => '0');
	signal INITIAL_PROD_ODD : unsigned(W_bits*2 - 1 downto 0) := (others => '0');
	signal Y_0_Product_ODD	: unsigned(W_bits*2 - 1 downto 0) := (others => '0');
	constant UPPER 		: integer := (W_bits * 2) - F_bits - 1;
	constant LOWER 		: integer := W_bits - F_bits;
	signal Y_0		: std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal DELAY1		: unsigned(W_bits*2 - 1 downto 0) := (others => '0');

	-- Declare the X_B^(-3/2) component
	component X_beta_LUT is 
		generic (W_bits	      	: positive := 32; -- size of word
			 F_bits       	: positive := 16); -- number of fractional bits	
		port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
			 clk		: in std_logic;
			 XB  		: out std_logic_vector(W_bits - 1 downto 0);
			 Odd_or_Even	: out std_logic);
	end component;

	-- Declare the X_A component
	component X_alpha is 
		generic (W_bits	      	: positive := 32; -- size of word
			 F_bits       	: positive := 16); -- number of fractional bits
		port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
			 clk		: in std_logic;
			 X_ALPHA  	: out std_logic_vector(W_bits - 1 downto 0));
	end component;

	begin
	-- Instantiate the components used in the calculaton
	X_BETA_COMP : X_beta_LUT generic map (W_bits => W_bits, F_bits => F_bits)
				 port map (X => x, clk => clk, XB => X_B , Odd_or_Even => ODD_OR_EVEN);
	
	X_ALPHA_COMP : X_alpha generic map (W_bits => W_bits, F_bits => F_bits)
			       port map(X => x, clk => clk, X_ALPHA => X_A);

	-- Assign the necessary values to unsigned to allow for muliplication
	ASSIGN_X_A : process(clk, X_A)
	begin
		X_A_UNS <= unsigned(X_A);
	end process;

	ASSIGN_X_B : process(clk, X_B)
	begin
		X_B_UNS <= unsigned(X_B);
	end process;

	-- Compute the guess based off if BETA is odd or even 
	COMPUTE_Y0_1 : process(clk, X_A_UNS, X_B_UNS)
		begin
		if(ODD_OR_EVEN = '0') then
			Y_0_Product_Even <= X_A_UNS * X_B_UNS;
		else
			Initial_PROD_ODD <= X_A_UNS * X_B_UNS;
		end if;
	end process;

	COMPUTE_Y0_2 : process(clk, Y_0_Product_Even, Initial_PROD_ODD)
	begin
		if(ODD_OR_EVEN = '0') then
			DELAY1 <= Y_0_Product_Even; 
		else
			Y_0_Product_Odd <= Initial_PROD_ODD(UPPER downto LOWER) * TOH_UNS;
		end if;
	end process;
	
	COMPUTE_Y0_3 : process(clk, DELAY1, Y_0_Product_Odd)
	begin
		if(ODD_OR_EVEN = '0') then
			Y_0 <= std_logic_vector(DELAY1(UPPER downto LOWER)); 
		else
			Y_0 <= std_logic_vector(Y_0_Product_Odd(UPPER downto LOWER));
		end if;
	end process;
	
	-- Assign the calculated value to the output
	y0 <= Y_0;
end architecture; 

