entity demux_1to8_TB is
end entity;

architecture demux_1to8_TB_arch of demux_1to8_TB is

 -- Constant Declaration
  constant t_wait : time := 2 ns; 

 -- Component Declaration   
  component demux_1to8
    port (A   : in  bit;
          Sel : in  bit_vector (2 downto 0); 
          F   : out bit_vector (7 downto 0));
  end component;

 -- Signal Declaration
  signal   A_TB   : bit;
  signal   Sel_TB : bit_vector (2 downto 0);
  signal   F_TB   : bit_vector (7 downto 0);

  begin

 -- Component Instantiation of DUT
  DUT :   demux_1to8
            port map (A    => A_TB,
                      Sel  => Sel_TB,
                      F    => F_TB);
                      
 -- Stimulus Generation
  STIMULUS0 : process
    begin
      A_TB <= '0'; wait for 2*t_wait; A_TB <= '1'; wait for 2*t_wait; 
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