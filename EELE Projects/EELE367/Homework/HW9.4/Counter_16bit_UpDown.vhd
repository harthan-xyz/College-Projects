library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter_16bit_UpDown is
     port (Clock, Reset : in  std_logic;
           Up           : in  std_logic;
           Count_Out    : out std_logic_vector(15 downto 0));
end entity;


architecture Couter_16bit_UpDown_arch of Counter_16bit_UpDown is

	signal Count_Out_int : integer range 0 to 65535;

	begin
		
		COUNTER : process (Clock, Reset)
			begin
				if (Reset = '0') then
				  Count_Out_int <= 0;
				elsif (rising_edge(Clock)) then	
					if ((Count_Out_int = 65535) and (Up = '1')) then
						Count_Out_int <= 0;
					elsif ((Count_Out_int = 0) and (Up = '0')) then
						Count_Out_int <= 65535;
					elsif (Up = '1') then
						Count_Out_int <= Count_Out_int + 1;
					elsif (Up = '0') then
						Count_Out_int <= Count_Out_int - 1;
					end if;
				end if;
			end process;

	Count_Out <=  std_logic_vector(to_unsigned(Count_Out_int,16));




end architecture;