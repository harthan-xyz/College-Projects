entity top is 
	port (SW 	:	in bit_vector (3 downto 0);
			LEDR	:	out bit_vector (3 downto 0);
			Prime	:	out bit);
end entity;

architecture top_arch of top is

	begin
	
		LEDR <= SW;
		
		Prime <= '1' when (SW = "0000") else
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
		
end architecture;