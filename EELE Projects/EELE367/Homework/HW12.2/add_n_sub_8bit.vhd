library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity add_n_sub_8bit is 
	port(A, B	: in std_logic_vector(7 downto 0);
	     ADDn_SUB	: in std_logic;
	     Sum_Diff	: out std_logic_vector(7 downto 0);
	     Cout_Bout	: out std_logic;
	     Vout	: out std_logic);
end entity;

architecture add_n_sub_8bit_arch of add_n_sub_8bit is

	signal Sum_Diff_sin  : signed(8 downto 0);

	begin
	
	ADD_OR_SUB : process (A, B, Sum_Diff_sin)
		begin
			if(ADDn_SUB = '0') then
				Sum_Diff_sin <= signed('0' & A) + signed('0' & B);
				Sum_Diff <= std_logic_vector(Sum_Diff_sin(7 downto 0));
				Cout_Bout <= Sum_Diff_sin(8);
			elsif(ADDn_SUB = '1') then
				Sum_Diff_sin <= signed('0' & A) - signed('0' & B);
				Sum_Diff <= std_logic_vector(Sum_Diff_sin(7 downto 0));
				Cout_Bout <= Sum_Diff_sin(8);
			end if;
		end process;

	TWOS_COMP : process (A(7), B(7), Sum_Diff_sin(7))
		  begin
			-- POS + POS = NEG, No-good :(
			if (A(7) = '0' and B(7) = '0' and Sum_Diff_sin(7) = '1') then
				Vout <= '1';
			-- NEG + NEG = POS, No-good :(
			elsif (A(7) = '1' and B(7) = '1' and Sum_Diff_sin(7) = '0') then
				Vout <= '1';
			else
				Vout <= '0';
			end if;
		end process;			


end architecture; 
