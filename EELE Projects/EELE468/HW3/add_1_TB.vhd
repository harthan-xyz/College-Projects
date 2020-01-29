-- Joshua Harthan
-- ADD 1 Testbench that reads in a file and outputs the results to another file
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity add_1_TB is 
end entity;

architecture add_1_TB_arch of add_1_TB is

	component add_1 is
		port(A : in std_logic_vector(3 downto 0);
		     B : out std_logic_vector(3 downto 0));
	end component;

	file file_VECTORS : text;
	file file_RESULTS : text;

	signal A_TB, B_TB : std_logic_vector(3 downto 0);

	begin
		DUT1 : add_1 port map (A => A_TB,
				       B => B_TB);

		FILE_READ : process
			variable LINE_IN : line;
			variable LINE_OUT: line;
			variable RESULT : std_logic_vector(3 downto 0);
			variable SPACE : character;
		    begin
			file_open(file_VECTORS, "input_vectors.txt", read_mode);
			file_open(file_RESULTS, "output_results.txt", write_mode);
		    
		     while not endfile(file_VECTORS) loop
			readline(file_VECTORS, LINE_IN);
			read(LINE_IN, RESULT);
			read(LINE_IN, SPACE);
			A_TB <= RESULT;
	
			wait for 10 ns;
			
			write(LINE_OUT, B_TB, right, 3);
			writeline(file_RESULTS, LINE_OUT);
		      end loop;
		      wait;
		end process;
	
end architecture; 