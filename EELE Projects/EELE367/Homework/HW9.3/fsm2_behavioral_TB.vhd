library IEEE;
use IEEE.std_logic_1164.all;

entity fsm2_behavioral_TB is
end entity;

architecture fsm2_behavioral_TB_arch of fsm2_behavioral_TB is
  
  constant t_clk_per : time := 50 ns;
  
  component fsm2_behavioral
   port (Clock, Reset : in  std_logic;
         Din          : in  std_logic;
         Dout         : out std_logic);
  end component;
 
  signal Clock_TB : std_logic;
  signal Reset_TB : std_logic;
  signal Din_TB   : std_logic; 
  signal Dout_TB  : std_logic;
 
 
begin
    
  DUT : fsm2_behavioral port map (Clock_TB, Reset_TB, Din_TB, Dout_TB);
    
-----------------------------------------------
      CLOCK_STIM : process
       begin
          Clock_TB <= '0'; wait for 0.5*t_clk_per; 
          Clock_TB <= '1'; wait for 0.5*t_clk_per; 
       end process;
-----------------------------------------------      
      RESET_STIM : process
       begin
          Reset_TB <= '0'; wait for 1.5*t_clk_per; 
          Reset_TB <= '1'; wait; 
       end process;
-----------------------------------------------      
      DIN_STIM : process
       begin
          Din_TB <= '0'; wait for 3.0*t_clk_per; -- sit in S0
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S1
          Din_TB <= '0'; wait for 1.0*t_clk_per; -- go to S2
          Din_TB <= '0'; wait for 1.0*t_clk_per; -- go to S0
          
          Din_TB <= '0'; wait for 3.0*t_clk_per; -- sit in S0
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S1
          Din_TB <= '0'; wait for 1.0*t_clk_per; -- go to S2
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S3
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S0
          
          Din_TB <= '0'; wait for 3.0*t_clk_per; -- sit in S0
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S1
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S3
          Din_TB <= '1'; wait for 1.0*t_clk_per; -- go to S0                         
       end process;
  
end architecture;



