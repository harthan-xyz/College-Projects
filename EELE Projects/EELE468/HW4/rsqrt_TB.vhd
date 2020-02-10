-- Joshua Harthan
-- Root Square Root Testbench that reads in a file and outputs the results to another file
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity rsqrt_TB is 
end entity;

architecture rsqrt_TB_arch of rsqrt_TB is

	-- define the rsqrt componenet
	component rsqrt is
		generic (W_bits	      : positive := 32; -- size of word
			 F_bits       : positive := 16; -- number of fractional bits
			 N_iterations : positive := 3); -- number of Newton's iterations
		port	(X 	      : in std_logic_vector(W_bits - 1 downto 0);
			 Y0 	      : in std_logic_vector (W_bits - 1 downto 0);
		    	 Y            : out std_logic_vector(W_bits - 1 downto 0));
	end component;

	-- define the testbench signals
	file file_VECTORS : text;
	file file_RESULTS : text;

	constant W_bits_TB 	   : natural := 32;
  	constant F_bits_TB 	   : natural := 16;
  	constant N_iterations_TB   : natural := 3;

	signal X_TB, Y_TB, Y0_TB : std_logic_vector(W_bits_tb - 1 downto 0);

	begin
		-- instantiate the rsqrt component
		DUT : rsqrt 
			 generic map   (W_bits	     => W_bits_TB,
		 		    	F_bits       => F_bits_TB,
		 	  	 	N_iterations => N_iterations_TB)
			    port map   (X => X_TB,
				        Y0 => Y0_TB,
				        Y => Y_TB);

		-- read in a file, and assign signal values accordingly; after done reading
		-- output results to a different file
		FILE_READ : process
			-- varialbes to hold the values read in and written out
			variable LINE_IN : line;
			variable LINE_OUT: line;
			variable XINPUT, Y0INPUT : std_logic_vector(W_bits_TB - 1 downto 0) := (others => '0');
			variable SPACE : character;
		    
		     begin
			file_open(file_VECTORS, "input_vectors.txt", read_mode);
			file_open(file_RESULTS, "output_results.txt", write_mode);
		    
		     while not endfile(file_VECTORS) loop
			readline(file_VECTORS, LINE_IN);
			read(LINE_IN, XINPUT);
			read(LINE_IN, SPACE);
			read(LINE_IN, Y0INPUT);
			X_TB <= XINPUT;
			Y0_TB <= Y0INPUT;
			wait for 5 ns;

			write(LINE_OUT, Y_TB, right, W_bits_TB);
			writeline(file_RESULTS, LINE_OUT);
		      end loop;
			
			file_close(file_VECTORS);
			file_close(file_RESULTS);
			
		 	wait;
		end process;
end architecture; 