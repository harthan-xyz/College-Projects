entity encoder_8to3_binary is 
	port (A : in bit_vector (7 downto 0);
	F : out bit_vector (2 downto 0));
end entity;

architecture encoder_arch of encoder_8to3_binary is
		
	begin
		
		with (A) select
			F <= "000" when "00000001",
			"001" when "00000010",
			"010" when "00000100",
			"011" when "00001000",
			"100" when "00010000",
			"101" when "00100000",
			"110" when "01000000",
			"111" when "10000000",
			"000" when others;
			
end architecture; 