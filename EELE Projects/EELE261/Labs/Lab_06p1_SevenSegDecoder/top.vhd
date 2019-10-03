entity top is 
	port (SW 		:	in bit_vector (3 downto 0);
			LEDR		:	out bit_vector (3 downto 0);
			Prime		:	out bit;
			SevenSeg :  out bit_vector (6 downto 0));
end entity;

architecture top_arch of top is

	begin
	
		LEDR <= SW;
		
		Prime <= 	'1' when (SW = "0000") else
						'1' when (SW = "0001") else
						'1' when (SW = "0010") else
						'1' when (SW = "0011") else
						'0' when (SW = "0100") else
						'1' when (SW = "0101") else
						'0' when (SW = "0110") else
						'1' when (SW = "0111") else
						'0' when (SW = "1000") else
						'0' when (SW = "1001") else
						'0' when (SW = "1010") else
						'1' when (SW = "1011") else
						'0' when (SW = "1100") else
						'1' when (SW = "1101") else
						'0' when (SW = "1110") else
						'0' when (SW = "1111");
		
		SevenSeg <= "1111110" when (SW = "0000") else
						"0110000" when (SW = "0001") else
						"1101101" when (SW = "0010") else
						"1111001" when (SW = "0011") else
						"0110011" when (SW = "0100") else
						"1011011" when (SW = "0101") else
						"1011111" when (SW = "0110") else
						"1110000" when (SW = "0111") else
						"1111111" when (SW = "1000") else
						"1111011" when (SW = "1001") else
						"1110111" when (SW = "1010") else
						"0011111" when (SW = "1011") else
						"0001101" when (SW = "1100") else
						"0111101" when (SW = "1101") else
						"1001111" when (SW = "1110") else
						"1000111" when (SW = "1111");
		
end architecture;