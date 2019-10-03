--Joshua Harthan, Michael Valentino-Manno
--Lab 12.2 4/3/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

--define entities (6 7-segment decoders, LEDR)
entity top is 
	port(SW 	  		: in std_logic_vector  (7 downto 0);
		  LEDR  		: out std_logic_vector (9 downto 0);
		  HEX0  		: out std_logic_vector (6 downto 0);
		  HEX1  		: out std_logic_vector (6 downto 0);
		  HEX2  		: out std_logic_vector (6 downto 0);
		  HEX3  		: out std_logic_vector (6 downto 0);
		  HEX4  		: out std_logic_vector (6 downto 0);
		  HEX5  		: out std_logic_vector (6 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
	
	--declare the twos complement decoder component
	component twos_comp_decoder
		port (TWOS_COMP_IN	: in std_logic_vector(3 downto 0);
				MAG_OUT			: out std_logic_vector(6 downto 0);
				SIGN_OUT			: out std_logic_vector(6 downto 0));
	end component;
	
	--signals declaration for the addition
	signal sum_sign : signed(3 downto 0);
	signal sum		: std_logic_vector(3 downto 0);
	signal Vout		: std_logic;
	
	begin 
		
		ADD : process (SW)
			begin
			sum_sign <= signed(SW(3 downto 0)) + signed(SW(7 downto 4));
			sum <= std_logic_vector(sum_sign(3 downto 0));
		end process;
---------------------------------------------------------		
		TWOS_COMP : process (SW)
		  begin
			-- POS + POS = NEG, No-good :(
			if (SW(3) = '0' and SW(7) = '0' and sum(3) = '1') then
				Vout <= '1';
			-- NEG + NEG = POS, No-good :(
			elsif (SW(3) = '1' and SW(7) = '1' and sum(3) = '0') then
				Vout <= '1';
			else
				Vout <= '0';
			end if;
		end process;
---------------------------------------------------------	
		--declare the twos compliment seven segment decoder	
		T1	: twos_comp_decoder port map (TWOS_COMP_IN => SW(3 downto 0), MAG_OUT => HEX0, SIGN_OUT => HEX1);
		T2 : twos_comp_decoder port map (TWOS_COMP_IN => Sw(7 downto 4), MAG_OUT => HEX2, sIGN_OUT => HEX3);		
		T3	: twos_comp_decoder port map (TWOS_COMP_IN => sum, MAG_OUT => HEX4, SIGN_OUT => HEX5);		
		
		--tie LEDR to the value of the switches and carry bit
		LEDR(7 downto 0) <= SW(7 downto 0);
		LEDR(8) <= '0';
		LEDR(9) <=	Vout;
----------------------------------------------------------	
		
		
		

			 
			 
end architecture; 