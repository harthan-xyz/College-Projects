entity counter_3bit_binary_up_down_TB is
end entity;

architecture counter_3bit_binary_up_down_TB_arch of counter_3bit_binary_up_down_TB is
        
  constant t_clk_per : time := 50 ns;

  component counter_3bit_binary_up_down
    port   (Clock           : in   bit;
            Reset           : in   bit;
            Up              : in   bit;
            Count           : out  bit_vector (2 downto 0));  
  end component;
        

  signal    Clock_TB      : bit;
  signal    Reset_TB      : bit;
  signal    UP_TB         : bit;
  signal    Count_TB      : bit_vector(2 downto 0);

  begin
      DUT1 : counter_3bit_binary_up_down
         port map (Clock         => Clock_TB, 
                   Reset         => Reset_TB, 
                   Up            => Up_TB,
                   Count         => Count_TB);

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
      UP_STIM : process
       begin
          Up_TB <= '1'; wait for 10*t_clk_per; 
          Up_TB <= '0'; wait for 10*t_clk_per; 
       end process;



end architecture;
