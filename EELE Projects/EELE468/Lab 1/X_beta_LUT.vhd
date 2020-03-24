-- Joshua Harthan
-- Find the value of (x_beta)^(-3/2) using a look-up table in ROM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity X_beta_LUT is 
	generic (W_bits	      : positive := 32; -- size of word
		 F_bits       : positive := 16); -- number of fractional bits

	port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
		 clk		: in std_logic;
		 XB  		: out std_logic_vector(W_bits - 1 downto 0);
		 Odd_or_Even	: out std_logic);
end entity;


architecture X_beta_LUT_arch of X_beta_LUT is
	
	-- declare the signals used
	signal ADDRESS	  	: std_logic_vector(7 downto 0) := (others => '0');
	signal Q	   	: std_logic_vector(7 downto 0) := (others => '0');
	signal X_B	   	: std_logic_vector(W_bits - 1 downto 0) := (others => '0');
	signal XB_THREE_HALFS 	: std_logic_vector(W_bits - 1 downto 0) := (others => '0');

	-- define the rsqrt_ROM component
	component rsqrt_ROM is
		port	(address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	 		 clock	 : IN STD_LOGIC  := '1';
			 q	 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;

	component X_beta is 
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16); -- number of fractional bits
		port 	(X  		: in std_logic_vector(W_bits - 1 downto 0);
			 clk		: in std_logic;
			 X_BETA  	: out std_logic_vector(W_bits - 1 downto 0);
			 Odd_Even	: out std_logic);
	end component;

	begin
	-- instantiate the X_BETA component
	X_BETA1 : X_beta generic map(W_bits => W_bits, F_bits => F_bits)
			 port map(X => X, clk => clk, X_BETA => X_B, Odd_Even => Odd_or_Even);
	
	-- Set the address location to be sent to the ROM component
	ASSIGN_ADDRESS : process(clk, X_B) 
		begin
			ADDRESS <= X_B(F_bits - 1 downto 8);
	end process;
	
	-- instantiate the ROM component
	ROM : rsqrt_ROM port map(address => ADDRESS, clock => clk, q => Q);

	ASSIGN_X_BETA : process(clk, Q)
		begin
			if(rising_edge(clk)) then
			XB_THREE_HALFS(F_bits downto 9) <= Q;
			end if;	
	end process;

	XB <= XB_THREE_HALFS;
end architecture;
