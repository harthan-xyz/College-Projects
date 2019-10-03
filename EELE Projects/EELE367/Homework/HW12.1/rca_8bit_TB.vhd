library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity rca_8bit_TB is 
end entity;


architecture rca_8bit_TB_arch of rca_8bit_TB is

	component rca_8bit
	 port (A,B : in std_logic_vector(7 downto 0);
	       S   : out std_logic_vector(7 downto 0);
	       Cout: out std_logic);
	end component;
	
	signal A_TB, B_TB, S_TB : std_logic_vector(7 downto 0);
	signal Cout_TB		: std_logic;

	begin

	 DUT : rca_8bit port map (A_TB, B_TB, S_TB, Cout_TB);

	 STIM : process
		begin
			for i in 0 to 255 loop
				for j in 0 to 255 loop
					A_TB <= std_logic_vector(to_unsigned(i,8));
					B_TB <= std_logic_vector(to_unsigned(j,8));
					wait for 30 ns;
				end loop;
			end loop;
	end process;


end architecture; 