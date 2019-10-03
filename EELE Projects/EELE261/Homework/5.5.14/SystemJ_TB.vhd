entity SystemJ_TB is
end entity;

architecture SystemJ_TB_arch of SystemJ_TB is

 -- Constant Declaration
  constant t_wait : time := 100 ns; 

 -- Component Declaration   
  component SystemJ
    port (A, B, C, D  : in  bit;
          F           : out bit);
  end component;

 -- Signal Declaration
  signal   A_TB, B_TB, C_TB, D_TB  : bit; -- these signals are used to connect to the device under test (DUT)
  signal   F_TB                    : bit;

  begin

 -- Component Instantiation of DUT
  DUT :   SystemJ
            port map (A    => A_TB,
                      B    => B_TB,
                      C    => C_TB,                    
                      D    => D_TB,                    
                      F    => F_TB);

 -- Stimulus Generation
  STIMULUS : process
    begin
      A_TB <= '0'; B_TB <= '0'; C_TB <= '0'; D_TB <= '0'; wait for t_wait;
      A_TB <= '0'; B_TB <= '0'; C_TB <= '0'; D_TB <= '1'; wait for t_wait;
      A_TB <= '0'; B_TB <= '0'; C_TB <= '1'; D_TB <= '0'; wait for t_wait;
      A_TB <= '0'; B_TB <= '0'; C_TB <= '1'; D_TB <= '1'; wait for t_wait;
      A_TB <= '0'; B_TB <= '1'; C_TB <= '0'; D_TB <= '0'; wait for t_wait;
      A_TB <= '0'; B_TB <= '1'; C_TB <= '0'; D_TB <= '1'; wait for t_wait;
      A_TB <= '0'; B_TB <= '1'; C_TB <= '1'; D_TB <= '0'; wait for t_wait;
      A_TB <= '0'; B_TB <= '1'; C_TB <= '1'; D_TB <= '1'; wait for t_wait;

      A_TB <= '1'; B_TB <= '0'; C_TB <= '0'; D_TB <= '0'; wait for t_wait;
      A_TB <= '1'; B_TB <= '0'; C_TB <= '0'; D_TB <= '1'; wait for t_wait;
      A_TB <= '1'; B_TB <= '0'; C_TB <= '1'; D_TB <= '0'; wait for t_wait;
      A_TB <= '1'; B_TB <= '0'; C_TB <= '1'; D_TB <= '1'; wait for t_wait;
      A_TB <= '1'; B_TB <= '1'; C_TB <= '0'; D_TB <= '0'; wait for t_wait;
      A_TB <= '1'; B_TB <= '1'; C_TB <= '0'; D_TB <= '1'; wait for t_wait;
      A_TB <= '1'; B_TB <= '1'; C_TB <= '1'; D_TB <= '0'; wait for t_wait;
      A_TB <= '1'; B_TB <= '1'; C_TB <= '1'; D_TB <= '1'; wait for t_wait;

    end process;
      
end architecture;                