entity encoder_8to3_binary_TB is
end entity;

architecture encoder_8to3_binary_TB_arch of encoder_8to3_binary_TB is

 -- Constant Declaration
  constant t_wait : time := 100 ns; 

 -- Component Declaration   
  component encoder_8to3_binary
    port (A  : in  bit_vector (7 downto 0);
          F  : out bit_vector (2 downto 0));
  end component;

 -- Signal Declaration
  signal   A_TB : bit_vector (7 downto 0);
  signal   F_TB : bit_vector (2 downto 0);

  begin

 -- Component Instantiation of DUT
  DUT :   encoder_8to3_binary
            port map (A    => A_TB,
                      F    => F_TB);
                      
 -- Stimulus Generation
  STIMULUS : process
    begin
      A_TB <= "00000001"; wait for t_wait;
      A_TB <= "00000010"; wait for t_wait;
      A_TB <= "00000100"; wait for t_wait;
      A_TB <= "00001000"; wait for t_wait;
      A_TB <= "00010000"; wait for t_wait;
      A_TB <= "00100000"; wait for t_wait;
      A_TB <= "01000000"; wait for t_wait;
      A_TB <= "10000000"; wait for t_wait;

    end process;
      
end architecture;                