library ieee;
use ieee.std_logic_1164.all;

entity rom_16x8_sync_TB is
end entity;

architecture rom_16x8_sync_TB_arch of rom_16x8_sync_TB is
  
  signal Clock_TB    : std_logic;
  signal Address_TB  : std_logic_vector(3 downto 0);
  signal Data_Out_TB : std_logic_vector(7 downto 0);
  
  component rom_16x8_sync
     port (Clock    : in  std_logic;
           Address  : in  std_logic_vector(3 downto 0);
           Data_Out : out std_logic_vector(7 downto 0));
  end component;
  
  begin
    
    DUT : rom_16x8_sync port map (Clock_TB, Address_TB, Data_Out_TB);
      
    CLOCK_STIM : process
     begin
       Clock_TB <= '0'; wait for 10 ns;
       Clock_TB <= '1'; wait for 10 ns;
    end process;         



    ADDRESS_STIM : process
     begin
       Address_TB <= "0000"; wait for 20 ns;
       Address_TB <= "0001"; wait for 20 ns;
       Address_TB <= "0010"; wait for 20 ns;
       Address_TB <= "0011"; wait for 20 ns;       
       Address_TB <= "0100"; wait for 20 ns;
       Address_TB <= "0101"; wait for 20 ns;
       Address_TB <= "0110"; wait for 20 ns;
       Address_TB <= "0111"; wait for 20 ns;         
       Address_TB <= "1000"; wait for 20 ns;
       Address_TB <= "1001"; wait for 20 ns;
       Address_TB <= "1010"; wait for 20 ns;
       Address_TB <= "1011"; wait for 20 ns;       
       Address_TB <= "1100"; wait for 20 ns;
       Address_TB <= "1101"; wait for 20 ns;
       Address_TB <= "1110"; wait for 20 ns;
       Address_TB <= "1111"; wait for 20 ns;                     
    end process;         
         
end architecture;
