entity mux_8to1_TB is
end entity;

architecture mux_8to1_TB_arch of mux_8to1_TB is

 -- Constant Declaration
  constant t_wait : time := 2 ns; 

 -- Component Declaration   
  component mux_8to1
    port (A   : in  bit_vector (7 downto 0);
          Sel : in  bit_vector (2 downto 0); 
          F   : out bit);
  end component;

 -- Signal Declaration
  signal   A_TB   : bit_vector (7 downto 0);
  signal   Sel_TB : bit_vector (2 downto 0);
  signal   F_TB   : bit;

  begin

 -- Component Instantiation of DUT
  DUT :   mux_8to1
            port map (A    => A_TB,
                      Sel  => Sel_TB,
                      F    => F_TB);
                      
 -- Stimulus Generation
  STIMULUS0 : process
    begin
      A_TB(0) <= '0'; wait for 1*t_wait; A_TB(0) <= '1'; wait for 1*t_wait; 
    end process;
      
  STIMULUS1 : process
    begin
      A_TB(1) <= '0'; wait for 2*t_wait; A_TB(1) <= '1'; wait for 2*t_wait; 
    end process;

  STIMULUS2 : process
    begin
      A_TB(2) <= '0'; wait for 3*t_wait; A_TB(2) <= '1'; wait for 3*t_wait; 
    end process;
    
  STIMULUS3 : process
    begin
      A_TB(3) <= '0'; wait for 4*t_wait; A_TB(3) <= '1'; wait for 4*t_wait; 
    end process;
    
  STIMULUS4 : process
    begin
      A_TB(4) <= '0'; wait for 5*t_wait; A_TB(4) <= '1'; wait for 5*t_wait; 
    end process;

  STIMULUS5 : process
    begin
      A_TB(5) <= '0'; wait for 6*t_wait; A_TB(5) <= '1'; wait for 6*t_wait; 
    end process;

  STIMULUS6 : process
    begin
      A_TB(6) <= '0'; wait for 7*t_wait; A_TB(6) <= '1'; wait for 7*t_wait; 
    end process;

  STIMULUS7 : process
    begin
      A_TB(7) <= '0'; wait for 8*t_wait; A_TB(7) <= '1'; wait for 8*t_wait; 
    end process;


  STIM_Sel : process
    begin
      Sel_TB <= "000"; wait for 50*t_wait; 
      Sel_TB <= "001"; wait for 50*t_wait;       
      Sel_TB <= "010"; wait for 50*t_wait; 
      Sel_TB <= "011"; wait for 50*t_wait; 
      Sel_TB <= "100"; wait for 50*t_wait; 
      Sel_TB <= "101"; wait for 50*t_wait;       
      Sel_TB <= "110"; wait for 50*t_wait; 
      Sel_TB <= "111"; wait for 50*t_wait; 

    end process;

end architecture;                