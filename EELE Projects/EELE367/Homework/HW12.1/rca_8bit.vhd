library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity rca_8bit is 
	port (A,B : in std_logic_vector(7 downto 0);
	      S   : out std_logic_vector(7 downto 0);
	      Cout: out std_logic);
end entity;

architecture rca_8bit_arch of rca_8bit is 

	component full_adder
	 port(A, B, Cin	: in std_logic;
	      Sum, Cout : out std_logic);
	end component;
	
	signal C1, C2, C3, C4, C5, C6, C7 : std_logic;

	begin
	
		A0 : full_adder port map (A(0) , B(0), '0', S(0), C1);
		A1 : full_adder port map (A(1) , B(1), C1, S(1), C2);
		A2 : full_adder port map (A(2) , B(2), C2, S(2), C3);
		A3 : full_adder port map (A(3) , B(3), C3, S(3), C4);
		A4 : full_adder port map (A(4) , B(4), C4, S(4), C5); 
		A5 : full_adder port map (A(5) , B(5), C5, S(5), C6);
		A6 : full_adder port map (A(6) , B(6), C6, S(6), C7);
		A7 : full_adder port map (A(7) , B(7), C7, S(7), Cout);

end architecture; 