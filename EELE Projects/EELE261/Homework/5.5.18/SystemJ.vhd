entity SystemK is 
	port(A,B,C,D	:	in bit;
		  F			:	out bit);
end entity;

Architecture Arch_K of SystemK is 
	signal ABCD	:	bit_vector (3 downto 0);
	
	begin
	
	ABCD	<=	A & B	&	C	&	D;
	
	with	(ABCD)	select
		F	<=	'1' when	"0000",
  				'1' when	"0001",
	 			'1' when	"0010",
	 			'0' when	"0011",
				'1' when	"0100",
				'1' when	"0101",
				'1' when	"0110",
				'0' when	"0111",
				'1' when	"1000",
				'1' when	"1001",
				'1' when	"1010",
				'0' when	"1011",
				'1' when	"1100",
				'1' when	"1101",
				'1' when	"1110",
				'0' when	"1111";

end architecture;