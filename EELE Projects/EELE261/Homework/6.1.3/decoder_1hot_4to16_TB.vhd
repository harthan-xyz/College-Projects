entity decoder_1hot_4to16_TB is
end entity;

architecture decoder_1hot_4to16_TB_arch of decoder_1hot_4to16_TB is

 -- Constant Declaration
  constant t_wait : time := 100 ns; 

 -- Component Declaration   
  component decoder_1hot_4to16
    port (A  : in  bit_vector (3 downto 0);
          F  : out bit_vector (15 downto 0));
  end component;

 -- Signal Declaration
  signal   A_TB : bit_vector (3 downto 0);
  signal   F_TB : bit_vector (15 downto 0);

  begin

 -- Component Instantiation of DUT
  DUT :   decoder_1hot_4to16
            port map (A    => A_TB,
                      F    => F_TB);
                      
 -- Stimulus Generation
  STIMULUS : process
    begin
      A_TB <= "0000"; wait for t_wait;
      A_TB <= "0001"; wait for t_wait;
      A_TB <= "0010"; wait for t_wait;
      A_TB <= "0011"; wait for t_wait;
      A_TB <= "0100"; wait for t_wait;
      A_TB <= "0101"; wait for t_wait;
      A_TB <= "0110"; wait for t_wait;
      A_TB <= "0111"; wait for t_wait;

      A_TB <= "1000"; wait for t_wait;
      A_TB <= "1001"; wait for t_wait;
      A_TB <= "1010"; wait for t_wait;
      A_TB <= "1011"; wait for t_wait;
      A_TB <= "1100"; wait for t_wait;
      A_TB <= "1101"; wait for t_wait;
      A_TB <= "1110"; wait for t_wait;
      A_TB <= "1111"; wait for t_wait;

    end process;
      
end architecture;                