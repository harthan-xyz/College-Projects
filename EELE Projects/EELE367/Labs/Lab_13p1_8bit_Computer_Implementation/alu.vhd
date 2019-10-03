library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity alu is
	port(A    : in std_logic_vector(7 downto 0);
	     B    : in std_logic_vector(7 downto 0);
	     ALU_Sel : in std_logic_vector(2 downto 0);
	     
	     NZVC : out std_logic_vector(3 downto 0);
	     ALU_Result : out std_logic_vector(7 downto 0));
end entity;

architecture alu_arch of alu is

	begin

	ALU_PROCESS : process (A,B, ALU_Sel)
	
	variable Sum_uns : unsigned(8 downto 0);
	variable Dif_uns : unsigned(8 downto 0);
	variable Product_uns : unsigned(8 downto 0);
	variable Quotient_uns: unsigned(8 downto 0);
	
	begin
		if (ALU_Sel = "000") then  -- addition
		-- sum calculation --
			Sum_uns := unsigned('0' & A) + unsigned('0' & B);
			ALU_Result <= std_logic_vector(Sum_uns(7 downto 0));

		-- negative flag (N) --
			NZVC(3) <= Sum_uns(7);

		-- zero flag (Z) --
			if(Sum_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;

		-- overflow flag (V) --
			if ((A(7) = '0' and B(7) = '0' and Sum_Uns(7) = '1') or
		  	    (A(7) = '1' and B(7) = '1' and Sum_Uns(7) = '0')) then
				NZVC(1) <= '1';
			else
				NZVC(1) <= '0';
			end if;

		-- carry flag (C) --
			NZVC(0) <= Sum_uns(8);
		
		elsif(ALU_Sel = "001") then -- subtraction
		-- difference calculation --
			Dif_uns := unsigned('0' & A) - unsigned('0' & B);
			ALU_Result <= std_logic_vector(Dif_uns(7 downto 0));

		-- negative flag (N) --
			NZVC(3) <= Dif_uns(7);

		-- zero flag (Z) --
			if(Dif_uns(7 downto 0) = x"00") then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;

		-- overflow flag (V) --
			if ((A(7) = '0' and B(7) = '0' and Dif_Uns(7) = '1') or
		  	    (A(7) = '1' and B(7) = '1' and Dif_Uns(7) = '0')) then
				NZVC(1) <= '1';
			else
				NZVC(1) <= '0';
			end if;

		-- carry flag (C) --
			NZVC(0) <= Dif_uns(8);


  		--elsif(ALU_Sel = "010") then
		--elsif(ALU_Sel = "011") then
		--elsif(ALU_Sel = "100") then
		--elsif(ALU_Sel = "101") then
		--elsif(ALU_Sel = "110") then
		--elsif(ALU_Sel = "111") then

		end if;
	end process;
end architecture;
