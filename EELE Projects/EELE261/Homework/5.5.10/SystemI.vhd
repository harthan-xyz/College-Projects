entity SystemI is 
	port(A,B,C,D	:	in bit;
	F		:	out bit);
end entity;

architecture Arch_I of SystemI is
	signal An, Bn, Cn, s1, s2, s3, s4	:	bit;
	
	begin
		
	An <= not A;
	Bn <= not B;
	Cn <= not C;
	
	s1 <= An and Bn and Cn and D;
	s2 <= An and Bn and C and D;
	s3 <= A and Bn and Cn and D;
	s4 <= A and Bn and C and D;
	
	F <= s1 or s2 or s3 or s4;
	
end architecture;