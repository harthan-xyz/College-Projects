entity SystemK is 
	port(A,B,C,D	:	in bit;
	F	:	out bit);
end entity;

Architecture Arch_K of SystemK is 
	signal An, Bn, Cn, Dn, sum1, sum2, sum3, sum4	:	bit;
	
		component INV1
			port (A	:	in bit;
			F	:	out bit);
		end component;
		
		component OR4 
			port (A,B,C,D	:	in bit;
			F	:	out bit);
		end component;
		
		component AND4 
			port (A,B,C,D	:	in bit;
			F	:	out bit);
		end component;
		
		begin
		
		U1: INV1 port map (A, An);
		U2: INV1 port map (B, Bn);
		U3: INV1 port map (C, Cn);
		U4: INV1 port map (D, Dn);
		
		U5: OR4 port map (A, B, Cn, Dn, sum1);
		U6: OR4 port map (A, Bn, Cn, Dn, sum2);
		U7: OR4 port map (An, B, Cn, Dn, sum3);
		U8: OR4 port map (An, Bn, Cn, Dn, sum4);
		
		U9: AND4 port map (sum1, sum2, sum3, sum4, F);
end architecture;