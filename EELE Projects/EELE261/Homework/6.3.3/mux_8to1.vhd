entity mux_8to1 is
	port(A : in bit_vector (7 downto 0);
	Sel : in bit_vector (2 downto 0);
	F	: out bit);
end entity;

architecture mux_arch of mux_8to1 is
	
	begin
	
		F <= A(0) when (Sel = "000") else
		A(1) when (Sel = "001") else
		A(2) when (Sel = "010") else
		A(3) when (Sel = "011") else
		A(4) when (Sel = "100") else
		A(5) when (Sel = "101") else
		A(6) when (Sel = "110") else
		A(7) when (Sel = "111");

end architecture; 