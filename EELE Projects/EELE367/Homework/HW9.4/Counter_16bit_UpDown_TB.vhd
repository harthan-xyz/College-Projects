library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter_16bit_UpDown_TB is
end entity;

architecture Counter_16bit_UpDown_TB_arch of Counter_16bit_UpDown_TB is
  
  component Counter_16bit_UpDown is
     port (Clock, Reset : in  std_logic;
           Up           : in  std_logic;
           Count_Out    : out std_logic_vector(15 downto 0));
   end component;
  
  signal Clock_TB, Reset_TB : std_logic;
  signal Up_TB              : std_logic;
  signal Count_Out_TB       : std_logic_vector(15 downto 0);  
  
  begin
  
  DUT : Counter_16bit_UpDown port map (Clock_TB, Reset_TB, Up_TB, Count_Out_TB);
    
  RESET_STIM : process
    begin
      Reset_TB <= '0'; wait for 2 ns;
      Reset_TB <= '1'; wait;
  end process;
    
  CLOCK_STIM : process
    begin
      Clock_TB <= '0'; wait for 10 ns;
      Clock_TB <= '1'; wait for 10 ns;      
  end process;

  UP_STIM : process
    begin
      Up_TB <= '1'; wait for 100 ns; -- Count up to 5 decimal
      Up_TB <= '0'; wait for 205 ns; -- Count down 10 to see roll-over from 0 to 65,535
      Up_TB <= '1'; wait;            -- Count up for the remaining time to see roll-over from 65,535 to 0
  end process;    

  
end architecture;