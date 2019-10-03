library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity clock_div_prec is 
	port (Clock_in : in std_logic;
			Reset 	: in std_logic;
			Sel		: in std_logic_vector(1 downto 0);
			Clock_out: out std_logic);
end entity;

architecture clock_div_prec_arch of clock_div_prec is
		
		signal BCD0_int : integer range 0 to 24999;
		signal BCD1_int : integer range 0 to 249999;
		signal BCD2_int : integer range 0 to 2499999;
		signal BCD3_int : integer range 0 to 24999999;
		signal clock_div: std_logic;
		
		begin

-------------------------------------------------------------------------------------					
			PROC : process (Clock_in, Reset)
				begin 
					if (Reset = '0') then
						BCD0_int <= 0;
						BCD1_int <= 0;
						BCD2_int <= 0;
						BCD3_int <= 0;
					elsif (rising_edge(Clock_in) and (Sel = "00")) then  -- 1 kHz clock
						if (BCD0_int = 24999) then 
							BCD0_int <= 0;
							Clock_div <= Clock_div XOR '1';
						else 
							BCD0_int <= BCD0_int + 1;
						end if; 
--------------------------------------------------------------------------------------						
					elsif (rising_edge(Clock_in)and (Sel = "01")) then  -- 100 Hz clock
						if (BCD1_int = 249999) then
							BCD1_int <= 0;
							Clock_div <= Clock_div XOR '1';
						else
							BCD1_int <= BCD1_int + 1;
						end if;
---------------------------------------------------------------------------------------							
					elsif (rising_edge(Clock_in) and (Sel = "10")) then  -- 10 Hz clock
						if (BCD2_int = 2499999)  then
							BCD2_int <= 0;
							Clock_div <= Clock_div XOR '1';								
						else
							BCD2_int <= BCD2_int + 1;
						end if;
---------------------------------------------------------------------------------------						
					elsif (rising_edge(Clock_in) and (Sel = "11")) then  -- 1 Hz clock
						if (BCD3_int = 24999999)  then
							BCD3_int <= 0;		
							Clock_div <= Clock_div XOR '1';
						else
							BCD3_int <= BCD3_int + 1;
						end if;
					end if;
			 end process;
			 
			 
			
			 
	
	Clock_out <= Clock_div;

end architecture;