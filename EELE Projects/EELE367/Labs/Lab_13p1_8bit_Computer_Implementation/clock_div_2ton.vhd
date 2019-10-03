--Joshua Harthan, Michael Valentino-Manno
--Lab 9.2 2/13/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;

--define entities 
entity clock_div_2ton is 
	port(Clock_In 	: in std_logic;
		  Reset 	: in std_logic;
		  Sel  	: in std_logic_vector(1 downto 0);
		  Clock_Out : out std_logic);
end entity; 

--begin architecture
architecture clock_div_2ton_arch of clock_div_2ton is 
	
	--instantiate the signals to be used in the d-flip-flops
	signal CNT  : std_logic_vector(37 downto 0);
	signal CNTN : std_logic_vector(37 downto 0);
	signal Clock_div : std_logic;
	
	--define the d-flip-flop component
	component dflipflop 
		port (Clock : in std_logic;
				Reset : in std_logic;
				D     : in std_logic;
				Q, Qn : out std_logic);
	end component;
	
	begin 
		--instatiate the 38 d-flip-flops
		DFF0  : dflipflop port map (Clock => Clock_In, Reset => Reset, D => CNTN(0), Q => CNT(0), Qn => CNTN(0));
   	DFF1  : dflipflop port map (Clock => CNTN(0), Reset => Reset, D => CNTN(1), Q => CNT(1), Qn => CNTN(1));
		DFF2  : dflipflop port map (Clock => CNTN(1), Reset => Reset, D => CNTN(2), Q => CNT(2), Qn => CNTN(2));
		DFF3  : dflipflop port map (Clock => CNTN(2), Reset => Reset, D => CNTN(3), Q => CNT(3), Qn => CNTN(3));
		DFF4  : dflipflop port map (Clock => CNTN(3), Reset => Reset, D => CNTN(4), Q => CNT(4), Qn => CNTN(4));
		DFF5  : dflipflop port map (Clock => CNTN(4), Reset => Reset, D => CNTN(5), Q => CNT(5), Qn => CNTN(5));
		DFF6  : dflipflop port map (Clock => CNTN(5), Reset => Reset, D => CNTN(6), Q => CNT(6), Qn => CNTN(6));
		DFF7  : dflipflop port map (Clock => CNTN(6), Reset => Reset, D => CNTN(7), Q => CNT(7), Qn => CNTN(7));
		DFF8  : dflipflop port map (Clock => CNTN(7), Reset => Reset, D => CNTN(8), Q => CNT(8), Qn => CNTN(8));
		DFF9  : dflipflop port map (Clock => CNTN(8), Reset => Reset, D => CNTN(9), Q => CNT(9), Qn => CNTN(9));
		DFF10  : dflipflop port map (Clock => CNTN(9), Reset => Reset, D => CNTN(10), Q => CNT(10), Qn => CNTN(10));
		DFF11  : dflipflop port map (Clock => CNTN(10), Reset => Reset, D => CNTN(11), Q => CNT(11), Qn => CNTN(11));
		DFF12  : dflipflop port map (Clock => CNTN(11), Reset => Reset, D => CNTN(12), Q => CNT(12), Qn => CNTN(12));
		DFF13  : dflipflop port map (Clock => CNTN(12), Reset => Reset, D => CNTN(13), Q => CNT(13), Qn => CNTN(13));
		DFF14  : dflipflop port map (Clock => CNTN(13), Reset => Reset, D => CNTN(14), Q => CNT(14), Qn => CNTN(14));
		DFF15  : dflipflop port map (Clock => CNTN(14), Reset => Reset, D => CNTN(15), Q => CNT(15), Qn => CNTN(15));
		DFF16  : dflipflop port map (Clock => CNTN(15), Reset => Reset, D => CNTN(16), Q => CNT(16), Qn => CNTN(16));
		DFF17  : dflipflop port map (Clock => CNTN(16), Reset => Reset, D => CNTN(17), Q => CNT(17), Qn => CNTN(17));
		DFF18  : dflipflop port map (Clock => CNTN(17), Reset => Reset, D => CNTN(18), Q => CNT(18), Qn => CNTN(18));
		DFF19  : dflipflop port map (Clock => CNTN(18), Reset => Reset, D => CNTN(19), Q => CNT(19), Qn => CNTN(19));
		DFF20  : dflipflop port map (Clock => CNTN(19), Reset => Reset, D => CNTN(20), Q => CNT(20), Qn => CNTN(20));
		DFF21  : dflipflop port map (Clock => CNTN(20), Reset => Reset, D => CNTN(21), Q => CNT(21), Qn => CNTN(21));
		DFF22  : dflipflop port map (Clock => CNTN(21), Reset => Reset, D => CNTN(22), Q => CNT(22), Qn => CNTN(22));
		DFF23  : dflipflop port map (Clock => CNTN(22), Reset => Reset, D => CNTN(23), Q => CNT(23), Qn => CNTN(23));
		DFF24  : dflipflop port map (Clock => CNTN(23), Reset => Reset, D => CNTN(24), Q => CNT(24), Qn => CNTN(24));
		DFF25  : dflipflop port map (Clock => CNTN(24), Reset => Reset, D => CNTN(25), Q => CNT(25), Qn => CNTN(25));
		DFF26  : dflipflop port map (Clock => CNTN(25), Reset => Reset, D => CNTN(26), Q => CNT(26), Qn => CNTN(26));
		DFF27  : dflipflop port map (Clock => CNTN(26), Reset => Reset, D => CNTN(27), Q => CNT(27), Qn => CNTN(27));
		DFF28  : dflipflop port map (Clock => CNTN(27), Reset => Reset, D => CNTN(28), Q => CNT(28), Qn => CNTN(28));
		DFF29  : dflipflop port map (Clock => CNTN(28), Reset => Reset, D => CNTN(29), Q => CNT(29), Qn => CNTN(29));
		DFF30  : dflipflop port map (Clock => CNTN(29), Reset => Reset, D => CNTN(30), Q => CNT(30), Qn => CNTN(30));
		DFF31  : dflipflop port map (Clock => CNTN(30), Reset => Reset, D => CNTN(31), Q => CNT(31), Qn => CNTN(31));
		DFF32  : dflipflop port map (Clock => CNTN(31), Reset => Reset, D => CNTN(32), Q => CNT(32), Qn => CNTN(32));
		DFF33  : dflipflop port map (Clock => CNTN(32), Reset => Reset, D => CNTN(33), Q => CNT(33), Qn => CNTN(33));
		DFF34  : dflipflop port map (Clock => CNTN(33), Reset => Reset, D => CNTN(34), Q => CNT(34), Qn => CNTN(34));
		DFF35  : dflipflop port map (Clock => CNTN(34), Reset => Reset, D => CNTN(35), Q => CNT(35), Qn => CNTN(35));
		DFF36  : dflipflop port map (Clock => CNTN(35), Reset => Reset, D => CNTN(36), Q => CNT(36), Qn => CNTN(36));
		DFF37  : dflipflop port map (Clock => CNTN(36), Reset => Reset, D => CNTN(37), Q => CNT(37), Qn => CNTN(37));

		
		MUX	: process (Sel)
			begin
				if (Sel = "00") then
					Clock_div <= CNTN(0); --25 MHz
				elsif (Sel = "01") then
					Clock_div <= CNTN(17); --191 Hz
				elsif (Sel = "10") then
					Clock_div <= CNTN(22); --6 Hz
				elsif (Sel = "11") then 
					Clock_div <= CNTN(24); --1.5 Hz
				end if;
			end process;
			
			Clock_Out <= Clock_div;
			 
			 
end architecture; 