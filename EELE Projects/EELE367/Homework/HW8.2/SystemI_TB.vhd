library IEEE;
use IEEE.std_logic_1164.all;

entity SystemI_TB is
end entity;

architecture SystemI_TB_arch of SystemI_TB is
  
 component SystemI is
   port (ABCD  : in  std_logic_vector(3 downto 0);
         F     : out std_logic);
 end component;
 
 signal ABCD_TB : std_logic_vector(3 downto 0);
 signal F_TB    : std_logic;
 
 begin
    
    DUT : SystemI port map (ABCD_TB, F_TB);
    
    STIM : process
      begin
        ABCD_TB <= "0000"; wait for 50 ns;
        ABCD_TB <= "0001"; wait for 50 ns;
        ABCD_TB <= "0010"; wait for 50 ns;
        ABCD_TB <= "0011"; wait for 50 ns;
        ABCD_TB <= "0100"; wait for 50 ns;
        ABCD_TB <= "0101"; wait for 50 ns;
        ABCD_TB <= "0110"; wait for 50 ns;
        ABCD_TB <= "0111"; wait for 50 ns;

        ABCD_TB <= "1000"; wait for 50 ns;
        ABCD_TB <= "1001"; wait for 50 ns;
        ABCD_TB <= "1010"; wait for 50 ns;
        ABCD_TB <= "1011"; wait for 50 ns;
        ABCD_TB <= "1100"; wait for 50 ns;
        ABCD_TB <= "1101"; wait for 50 ns;
        ABCD_TB <= "1110"; wait for 50 ns;
        ABCD_TB <= "1111"; wait for 50 ns;

       
    end process;
  
end architecture;



