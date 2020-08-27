-- Joshua Harthan
-- Compute x_beta = x*2^(-beta)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity X_beta is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits

	port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
		 clk		: in std_logic;
		 X_BETA  	: out std_logic_vector(W_bits - 1 downto 0);
		 Odd_Even	: out std_logic);
end entity;


architecture X_beta_arch of X_beta is

	signal X_B_EVEN	   : std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_B_ODD	   : std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal X_UNS       : unsigned (W_bits - 1 downto 0) := (others => '0');
	signal BETA_ODD    : integer := 0;
	signal BETA_EVEN   : integer := 0;
	signal ODD_OR_EVEN : std_logic := '0';
	signal BETA_signed : signed(4 downto 0) := (others => '0');
	signal BETA_INT	   : integer := 0;


	-- Instantiate the compute BETA component
	component Compute_B is 
		generic (W_bits	      : positive := 32; -- size of word	
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(clk	      : in std_logic;
			 x	      : in std_logic_vector(W_bits - 1 downto 0);
			 B 	      : out signed(4 downto 0);
			 Odd_or_Even  : out std_logic); -- EVEN = 0, ODD = 1
	end component;

	begin
	-- instantiate the BETA component
	BETA1 : Compute_B generic map(W_bits => W_bits, F_bits => F_bits) 
			 port map(clk => clk, x => x, B => BETA_signed, Odd_or_Even => ODD_OR_EVEN);  

	-- Typecast the X input into unsigned to allow for shifting
	ASSIGN_VALUES : process(clk, X, ODD_OR_EVEN, Beta_signed)
		begin
			X_UNS <= unsigned(X);
			Odd_Even <= ODD_OR_EVEN;
			BETA_INT <= to_integer(BETA_signed);
	end process;

	-- Based off ODD_OR_EVEN, assign the appropriate value to the input BETA_EVEN or BETA_ODD
	ASSIGN_INPUT : process(clk, X_B_ODD, X_B_EVEN, X)
		begin
			if (ODD_OR_EVEN = '0') then
				BETA_EVEN <= BETA_INT;
			else
				BETA_ODD <= BETA_INT;
			end if;
	end process;

	-- Find X_BETA by shifting input X by BETA bits
	SHIFT_EVEN_B : process(clk, BETA_EVEN)
		begin
		X_B_EVEN <= std_logic_vector(shift_right(X_UNS, BETA_EVEN));
	end process; 

	SHIFT_ODD_B : process(clk, BETA_ODD) 
		begin
		X_B_ODD <= std_logic_vector(shift_right(X_UNS, BETA_ODD));
	end process;
	
	-- Based off ODD_OR_EVEN, assign the appropriate value to the output X_BETA
	ASSIGN_OUTPUT : process(clk, X_B_ODD, X_B_EVEN)
		begin
			if (rising_edge(clk)) then			
				if (ODD_OR_EVEN = '0') then
					X_BETA <= X_B_EVEN;
				else
					X_BETA <= X_B_ODD;
				end if;
			end if;
	end process;

end architecture;
