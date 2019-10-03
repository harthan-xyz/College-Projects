library IEEE;
use IEEE.std_logic_1164.all;

entity SystemJ_TB is
end entity;

architecture SystemJ_TB_arch of SystemJ_TB is
  
 component SystemJ is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     : out std_logic);
 end component;
 
 signal ABCD_TB : std_logic_vector(3 downto 0);
 signal F_TB    : std_logic;
 
 begin
    
    DUT : SystemJ port map (ABCD_TB, F_TB);
    
    STIM : process
      begin
        ABCD_TB <= "0000"; wait for 10 ns;
	report "Inputting 0000" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 0000, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 0000, F was a 0" severity ERROR;

        ABCD_TB <= "0001"; wait for 10 ns;
	report "Inputting 0001" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 0001, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 0001, F was a 0" severity ERROR;


        ABCD_TB <= "0010"; wait for 10 ns;
	report "Inputting 0010" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 0010, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 0010, F was a 0" severity ERROR;


        ABCD_TB <= "0011"; wait for 10 ns;
	report "Inputting 0011" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 0011, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 0011, F was a 0" severity ERROR;


        ABCD_TB <= "0100"; wait for 10 ns;
	report "Inputting 0100" severity NOTE;
	assert (F_TB = '0') report "Passed Test at 0100, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 0100, F was a 0" severity ERROR;


        ABCD_TB <= "0101"; wait for 10 ns;
	report "Inputting 0101" severity NOTE;
	assert (F_TB = '0') report "Passed Test at 0101, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 0101, F was a 0" severity ERROR;


        ABCD_TB <= "0110"; wait for 10 ns;
	report "Inputting 0110" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 0110, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 0110, F was a 0" severity ERROR;


        ABCD_TB <= "0111"; wait for 10 ns;
	report "Inputting 0111" severity NOTE;
	assert (F_TB = '0') report "Passed Test at 0111, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 0111, F was a 0" severity ERROR;


        ABCD_TB <= "1000"; wait for 10 ns;
	report "Inputting 1000" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 1000, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 1000, F was a 0" severity ERROR;


        ABCD_TB <= "1001"; wait for 10 ns;
	report "Inputting 1001" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 1001, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 1001, F was a 0" severity ERROR;


        ABCD_TB <= "1010"; wait for 10 ns;
	report "Inputting 1010" severity NOTE;	
	assert (F_TB = '0') report "Failed Test at 1010, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 1010, F was a 0" severity ERROR;


        ABCD_TB <= "1011"; wait for 10 ns;
	report "Inputting 1011" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 1011, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 1011, F was a 0" severity ERROR;


        ABCD_TB <= "1100"; wait for 10 ns;
	report "Inputting 1100" severity NOTE;
	assert (F_TB = '0') report "Passed Test at 1100, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 1100, F was a 0" severity ERROR;


        ABCD_TB <= "1101"; wait for 10 ns;
	report "Inputting 1101" severity NOTE;
	assert (F_TB = '0') report "Passed Test at 1101, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 1101, F was a 0" severity ERROR;


        ABCD_TB <= "1110"; wait for 10 ns;
	report "Inputting 1110" severity NOTE;
	assert (F_TB = '0') report "Failed Test at 1110, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Passed Test at 1110, F was a 0" severity ERROR;


        ABCD_TB <= "1111"; wait for 10 ns;
	report "Inputting 1111" severity NOTE; 
	assert (F_TB = '0') report "Passed Test at 1111, F was a 1" severity ERROR;
	assert (F_TB = '1') report "Failed Test at 1111, F was a 0" severity ERROR;


    end process;
  
end architecture;



