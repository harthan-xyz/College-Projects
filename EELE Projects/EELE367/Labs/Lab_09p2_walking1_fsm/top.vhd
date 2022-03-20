--Joshua Harthan, Michael Valentino-Manno
--Lab 9.2 2/13/19

--import neeeded packages
library IEEE;
use IEEE.STD_Logic_1164.ALL;

--define entities (6 7-segment decoders, LEDR, D-flip-flops, IO ports)
entity top is 
	port(Clock_50 	: in std_logic;
		  Reset 	: in std_logic;
		  SW 	  	: in std_logic_vector  (3 downto 0);
		  LEDR  	: out std_logic_vector (9 downto 0);
		  HEX0  	: out std_logic_vector (6 downto 0);
		  HEX1  	: out std_logic_vector (6 downto 0);
		  HEX2  	: out std_logic_vector (6 downto 0);
		  HEX3  	: out std_logic_vector (6 downto 0);
		  HEX4  	: out std_logic_vector (6 downto 0);
		  HEX5  	: out std_logic_vector (6 downto 0);
		  GPIO_1 : out std_logic_vector (9 downto 0));
end entity; 

--begin architecture
architecture top_arch of top is 
	
	--instantiate the signals to be used in the d-flip-flops
	signal CNT  : std_logic_vector(37 downto 0);
	signal CNTN : std_logic_vector(37 downto 0);
	signal Clock_div : std_logic;
	signal Walking1_out : std_logic_vector(9 downto 0);
	
	--define the different states
	type State_Type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
	signal current_state, next_state: State_Type;
		
	--define the char-decoder component 
	component char_decoder
		port (BIN_IN 	: in std_logic_vector  (3 downto 0);
				HEX_OUT 	: out std_logic_vector (6 downto 0));
	end component;
	
	--define the d-flip-flop component
	component dflipflop 
		port (Clock : in std_logic;
				Reset : in std_logic;
				D     : in std_logic;
				Q, Qn : out std_logic);
	end component;
	
	
	begin 
		--instatiate the 6 char-decoders
		C0 : char_decoder port map (BIN_IN => CNT(17 downto 14), HEX_OUT => HEX0);
		C1 : char_decoder port map (BIN_IN => CNT(21 downto 18), HEX_OUT => HEX1);
		C2 : char_decoder port map (BIN_IN => CNT(25 downto 22), HEX_OUT => HEX2);
		C3 : char_decoder port map (BIN_IN => CNT(29 downto 26), HEX_OUT => HEX3);
		C4 : char_decoder port map (BIN_IN => CNT(33 downto 30), HEX_OUT => HEX4);
		C5 : char_decoder port map (BIN_IN => CNT(37 downto 34), HEX_OUT => HEX5);
		
		--instatiate the 38 d-flip-flops
		DFF0  : dflipflop port map (Clock => Clock_50, Reset => Reset, D => CNTN(0), Q => CNT(0), Qn => CNTN(0));
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

----------------------------------------------------------------------------------------------------------------------------
		--set clock cycle at 11.9 Hz
		Clock_div <= CNTN(21);
		
		--synthesizable state memory that triggers off rising clock edge
			STATE_MEMORY : process (Clock_div, Reset)
				begin
				  if (Reset = '0') then
						current_state <= S0;
				  elsif (rising_edge(Clock_div)) then
						current_state <= next_state;
				  end if;
			 end process;
		--combinational next state logic that triggers off current state and switch
			 NEXT_STATE_LOGIC : process (current_state, SW(0))
				begin
				  case (current_state) is 
						when S0 => if (SW(0) = '1') then
							next_state <= S1;
						else
							next_state <= S9;
						end if;
				-------------------------------------------		
						when S1 => if (SW(0) = '1') then
							next_state <= S2;
						else
							next_state <= S0;
						end if;
				-------------------------------------------		
						when S2 => if (SW(0) = '1') then
							next_state <= S3;
						else
							next_state <= S1;
						end if;
				-------------------------------------------		
						when S3 => if (SW(0) = '1') then
							next_state <= S4;
						else
							next_state <= S2;
						end if;
				-------------------------------------------		
						when S4 => if (SW(0) = '1') then
							next_state <= S5;
						else
							next_state <= S3;
						end if;
				-------------------------------------------	
						when S5 => if (SW(0) = '1') then
							next_state <= S6;
						else
							next_state <= S4;
						end if;
				-------------------------------------------		
						when S6 => if (SW(0) = '1') then
							next_state <= S7;
						else
							next_state <= S5;
						end if;
				-------------------------------------------		
						when S7 => if (SW(0) = '1') then
							next_state <= S8;
						else
							next_state <= S6;
						end if;
				-------------------------------------------		
						when S8 => if (SW(0) = '1') then
							next_state <= S9;
						else
							next_state <= S7;
						end if;
				-------------------------------------------		
						when S9 => if (SW(0) = '1') then
							next_state <= S0;
						else
							next_state <= S8;
						end if;
					when others => next_state <= S0;
				end case;
			 end process;
			--combinational output logic that is only dependent on current state	
			 OUTPUT_LOGIC : process (current_state)
				begin
					case(current_state) is 
						when S0 => LEDR <= "0000000001";GPIO_1 <= "0000000001";
						when S1 => LEDR <= "0000000010";GPIO_1 <= "0000000010";
						when S2 => LEDR <= "0000000100";GPIO_1 <= "0000000100";
						when S3 => LEDR <= "0000001000";GPIO_1 <= "0000001000";
						when S4 => LEDR <= "0000010000";GPIO_1 <= "0000010000";
						when S5 => LEDR <= "0000100000";GPIO_1 <= "0000100000";
						when S6 => LEDR <= "0001000000";GPIO_1 <= "0001000000";
						when S7 => LEDR <= "0010000000";GPIO_1 <= "0010000000";
						when S8 => LEDR <= "0100000000";GPIO_1 <= "0100000000";
						when S9 => LEDR <= "1000000000";GPIO_1 <= "1000000000";
						when others => LEDR <= "0000000000";GPIO_1 <= "0000000000";
					 end case;
			 end process;
			 
			 
end architecture; 