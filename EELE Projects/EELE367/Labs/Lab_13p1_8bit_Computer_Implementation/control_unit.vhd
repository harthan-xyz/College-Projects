library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity control_unit is
	port(Clock 	: in std_logic;
	     Reset 	: in std_logic;
	     CCR_Result : in std_logic_vector(3 downto 0);
	     IR    	: in std_logic_vector(7 downto 0);
	
	     IR_Load 	: out std_logic;
	     MAR_Load	: out std_logic;
	     PC_Load	: out std_logic;
	     PC_Inc	: out std_logic;
	     A_Load	: out std_logic;
	     B_Load	: out std_logic;
	     ALU_Sel	: out std_logic_vector(2 downto 0);
	     CCR_Load   : out std_logic;
	     Bus1_Sel	: out std_logic_vector(1 downto 0);
	     Bus2_Sel	: out std_logic_vector(1 downto 0);
	     write	: out std_logic);
end entity;

architecture control_unit_arch of control_unit is

		-- Constants for Instruction Pnemonics --
	constant LDA_IMM : std_logic_vector (7 downto 0) := x"86"; -- Load Register A with Immediate Addressing
	constant LDA_DIR : std_logic_vector (7 downto 0) := x"87"; -- Load Register A with Direct Addressing
	constant LDB_IMM : std_logic_vector (7 downto 0) := x"88"; -- Load Register B with Immediate Addressing
	constant LDB_DIR : std_logic_vector (7 downto 0) := x"89"; -- Load Register B with Direct Addressing
	constant STA_DIR : std_logic_vector (7 downto 0) := x"96"; -- Store Register A to memory (RAM or IO)
	constant STB_DIR : std_logic_vector (7 downto 0) := x"97"; -- Store Register B to memory (RAM or IO)
	constant ADD_AB : std_logic_vector (7 downto 0) := x"42"; -- A <= A + B
	constant SUB_AB : std_logic_vector (7 downto 0) := x"43"; -- A <= A - B
	constant AND_AB : std_logic_vector (7 downto 0) := x"44"; -- A <= A and B
	constant OR_AB : std_logic_vector (7 downto 0) := x"45"; -- A <= A or B
	constant INCA : std_logic_vector (7 downto 0) := x"46"; -- A <= A + 1
	constant INCB : std_logic_vector (7 downto 0) := x"47"; -- B <= B + 1
	constant DECA : std_logic_vector (7 downto 0) := x"48"; -- A <= A - 1
	constant DECB : std_logic_vector (7 downto 0) := x"49"; -- B <= B - 1
	constant BRA : std_logic_vector (7 downto 0) := x"20"; -- Branch Always
	constant BMI : std_logic_vector (7 downto 0) := x"21"; -- Branch if N = 1
	constant BPL : std_logic_vector (7 downto 0) := x"22"; -- Branch if N = 0
	constant BEQ : std_logic_vector (7 downto 0) := x"23"; -- Branch if Z = 1
	constant BNE : std_logic_vector (7 downto 0) := x"24"; -- Branch if Z = 0 
	constant BVS : std_logic_vector (7 downto 0) := x"25"; -- Branch if V = 1
	constant BVC : std_logic_vector (7 downto 0) := x"26"; -- Branch if V = 0
	constant BCS : std_logic_vector (7 downto 0) := x"27"; -- Branch if C = 1
	constant BCC : std_logic_vector (7 downto 0) := x"28"; -- Branch if C = 0

	type state_type is
		(S_FETCH_0, S_FETCH_1, S_FETCH_2, -- Opcode Fetch
		 S_DECODE_3, -- Opcode Decode
		 S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6, -- Load A (Immediate)
		 S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7, S_LDA_DIR_8, -- Load A (Direct)
		 S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7, -- Store A (Direct)
		 S_ADD_AB_4, -- Add A and B
		 S_BRA_4, S_BRA_5, S_BRA_6, -- Branch Always
		 S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7); -- Branch if Equivalent
	
	signal current_state, next_state : state_type;

	begin
------------------------------------------------------------------------------------------
-- STATE MEMORY
------------------------------------------------------------------------------------------
		STATE_MEMORY : process (Clock,Reset)
			begin
			  if(Reset = '0') then
				current_state <= S_FETCH_0;
			  elsif(rising_edge(Clock)) then
				current_state <= next_state;
			  end if;
			end process;

-------------------------------------------------------------------------------------------
-- NEXT STATE LOGIC
-------------------------------------------------------------------------------------------
		NEXT_STATE_LOGIC : process (current_state, IR, CCR_Result)
			 begin
			    if(current_state = S_FETCH_0) then
				next_state <= S_FETCH_1;
			    elsif(current_state = S_FETCH_1) then
				next_state <= S_FETCH_2;
			    elsif(current_state = S_FETCH_2) then
				next_state <= S_DECODE_3;
				
				-- select execution path --
			    elsif(current_state = S_DECODE_3) then 				
				if(IR = LDA_IMM) then  		-- Load A Immediate
					next_state <= S_LDA_IMM_4;
				elsif(IR = LDA_DIR) then 	-- Load A Direct
					next_state <= S_LDA_DIR_4;
				elsif(IR = STA_DIR) then	-- Store A Direct
					next_state <= S_STA_DIR_4;
				elsif(IR = ADD_AB) then		-- Add A and B
					next_state <= S_ADD_AB_4;
				elsif(IR = BRA) then		-- Branch Always
					next_state <= S_BRA_4;
				elsif(IR = BEQ and CCR_Result(2) = '1') then -- BEQ and z = 1
					next_state <= S_BEQ_4;
				elsif(IR = BEQ and CCR_Result(2) = '0') then -- BEQ and z = 0
					next_state <= S_BEQ_7;
				else
					next_state <= S_FETCH_0;
				end if;

				-- Load A Immediate --
			     elsif(current_state = S_LDA_IMM_4) then
				next_state <= S_LDA_IMM_5;
			     elsif(current_state = S_LDA_IMM_5) then
				next_state <= S_LDA_IMM_6;
			     elsif (current_state = S_LDA_IMM_6) then
				next_state <= S_FETCH_0;
			 
				-- Load A Direct --
			     elsif(current_state = S_LDA_DIR_4) then
				next_state <= S_LDA_DIR_5;
			     elsif(current_state = S_LDA_DIR_5) then
				next_state <= S_LDA_DIR_6;
			     elsif(current_state = S_LDA_DIR_6) then
				next_state <= S_LDA_DIR_7;
			     elsif(current_state = S_LDA_DIR_7) then
				next_state <= S_LDA_DIR_8;
			     elsif(current_state = S_LDA_DIR_8) then
				next_state <= S_FETCH_0;
			
				-- Stora A Direct --
			     elsif(current_state = S_STA_DIR_4) then
				next_state <= S_STA_DIR_5;
			     elsif(current_state = S_STA_DIR_5) then
				next_state <= S_STA_DIR_6;
			     elsif(current_state = S_STA_DIR_6) then
				next_state <= S_STA_DIR_7;
			     elsif(current_state = S_STA_DIR_7) then
				next_state <= S_FETCH_0;

				-- Add A and B --
			     elsif(current_state = S_ADD_AB_4) then
				next_state <= S_FETCH_0;
	
				-- Branch Always --
			     elsif(current_state = S_BRA_4) then
				next_state <= S_BRA_5;
			     elsif(current_state = S_BRA_5) then
				next_state <= S_BRA_6;
			     elsif(current_state = S_BRA_6) then
				next_state <= S_FETCH_0;

				-- Branch if Equivalent --
			     elsif(current_state = S_BEQ_4) then
				next_state <= S_BEQ_5;
			     elsif(current_state = S_BEQ_5) then
				next_state <= S_BEQ_6;
			     elsif(current_state = S_BEQ_6) then
				next_state <= S_FETCH_0;
			     elsif(current_state = S_BEQ_7) then
				next_state <= S_FETCH_0;
			     end if;
			 end process;

----------------------------------------------------------------------------------------------
-- OUTPUT LOGIC
----------------------------------------------------------------------------------------------
		OUTPUT_LOGIC : process (current_state)
			begin
			  case(current_state) is

--------------------------------------------------------------------------------------------------------------------------------
						-- FETCH --
--------------------------------------------------------------------------------------------------------------------------------
			  	when S_FETCH_0 => -- Put PC into MAR to read Opcode
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00";  --"00" = PC, "01" = A, "10" = B
					Bus2_Sel <= "01";  --"00" = ALU_Result, "01" = Bus1, "10" = from memory
					write <= '0';

				when S_FETCH_1 => -- Increment PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '1';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_FETCH_2 => -- Opcode available on Bus2, latched into IR
					IR_Load <= '1';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- DECODE --
--------------------------------------------------------------------------------------------------------------------------------
				when S_DECODE_3 => -- IR decoded, No outputs
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- LDA_IMM --
--------------------------------------------------------------------------------------------------------------------------------
				when S_LDA_IMM_4 => -- Load A Immediate
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_LDA_IMM_5 => -- Increment PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '1';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_LDA_IMM_6 => -- Opcode available on Bus2, latched into A
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '1';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- LDA_DIR --
--------------------------------------------------------------------------------------------------------------------------------
				when S_LDA_DIR_4 => -- Load A Direct
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_LDA_DIR_5 => -- Increment PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '1';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_LDA_DIR_6 => -- Operand available on Bus2, value loaded into MAR
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_LDA_DIR_7 => -- Wait
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';
	
				when S_LDA_DIR_8 => -- MAR driving address, latch value into A
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '1';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- STA_DIR --
--------------------------------------------------------------------------------------------------------------------------------
				when S_STA_DIR_4 => -- Store A Direct
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_STA_DIR_5 => -- Increment PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '1';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_STA_DIR_6 => -- Operand available from Bus2, loaded into MAR
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_STA_DIR_7 => -- Put A into the address provided by operand
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '1';

--------------------------------------------------------------------------------------------------------------------------------
						-- ADD_AB --
--------------------------------------------------------------------------------------------------------------------------------
				when S_ADD_AB_4 => -- Add AB
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '1';
					B_Load <= '0';
					ALU_Sel <= "000"; -- "000" = Addition
					CCR_Load <= '1';
					Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- BRA --
--------------------------------------------------------------------------------------------------------------------------------
				when S_BRA_4 => -- Branch Always
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';
				
				when S_BRA_5 => -- Wait
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';
				
				when S_BRA_6 => -- Operand available on Bus2, latched into PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '1';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- BEQ --
--------------------------------------------------------------------------------------------------------------------------------
				when S_BEQ_4 => -- Branch if Equivalent, IR = BEQ and Z = 1
					IR_Load <= '0';
					MAR_Load <= '1';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "01"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_BEQ_5 => -- Wait
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

				when S_BEQ_6 => -- Place operand into PC
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '1';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000"; 
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "10"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';
	
				when S_BEQ_7 => -- Increment PC, IR = BEQ and Z = 0
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '1';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';

--------------------------------------------------------------------------------------------------------------------------------
						-- DEFAULT --
--------------------------------------------------------------------------------------------------------------------------------
				when others =>
					IR_Load <= '0';
					MAR_Load <= '0';
					PC_Load <= '0';
					PC_Inc <= '0';
					A_Load <= '0';
					B_Load <= '0';
					ALU_Sel <= "000";
					CCR_Load <= '0';
					Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10 = B
					Bus2_Sel <= "00"; -- "00" = ALU, "01" = Bus1, "10" = from memory 
					write <= '0';
				end case;
		end process;
		
end architecture;