entity decoder_1hot_4to16 is
	port (A : in bit_vector (3 downto 0);
		F : out bit_vector (15 downto 0));
end entity;

Architecture decoder_arch of decoder_1hot_4to16 is

	begin
	
		F <= 	"0000000000000001" when (A = "0000") else
				"0000000000000010" when (A = "0001") else
				"0000000000000100" when (A = "0010") else
				"0000000000001000" when (A = "0011") else
				"0000000000010000" when (A = "0100") else
				"0000000000100000" when (A = "0101") else
				"0000000001000000" when (A = "0110") else
				"0000000010000000" when (A = "0111") else
				"0000000100000000" when (A = "1000") else
				"0000001000000000" when (A = "1001") else
				"0000010000000000" when (A = "1010") else
				"0000100000000000" when (A = "1011") else
				"0001000000000000" when (A = "1100") else
				"0010000000000000" when (A = "1101") else
				"0100000000000000" when (A = "1110") else
				"1000000000000000" when (A = "1111");
				
end architecture; 