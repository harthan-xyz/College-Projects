-- Joshua Harthan, Jordan Palmer
-- ALU Component
library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity alu is
	port(
	     clk	: in std_logic;
	     reset	: in std_logic;
	     A  	: in std_logic_vector(31 downto 0);
	     B	  	: in std_logic_vector(31 downto 0);
	     Opcode 	: in std_logic_vector(2 downto 0);
	     Write_En	: in std_logic;
		  
	     Result_High : out std_logic_vector(31 downto 0);
	     Result_Low  : out std_logic_vector(31 downto 0);
	     Status	 : out std_logic_vector(2 downto 0)
	     );
end entity;

architecture alu_arch of alu is

	-- define the states to be used in the state machine
	type State_Type is (S0, S1,S2,S3,S4,S5,S6,S7);
	signal current_state, next_state : State_Type;
	
	-- define signals to be assigned to the output based off state
	signal RH0, RH1, RH2, RH3, RH4, RH5, RH6, RH7 : std_logic_vector(31 downto 0);
	signal RL0, RL1, RL2, RL3, RL4, RL5, RL6, RL7 : std_logic_vector(31 downto 0);
	signal Status0, Status1, Status2, Status3, Status4, Status5, Status6, Status7 : std_logic_vector(2 downto 0);
	
	--define the states to be used in the state machine
	component state0 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;
	
	component state1 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;

	component state2 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;
	
	component state3 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;
	
	component state4 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;
	
		component state5 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;

	component state6 is
			  port (A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0));
	end component;
	
	component state7 is
			  port (clk	: in std_logic;
				reset	: in std_logic;
				A	: in std_logic_vector(31 downto 0);
				B	: in std_logic_vector(31 downto 0);
		  
				Result_High: out std_logic_vector(31 downto 0);
				Result_Low : out std_logic_vector(31 downto 0);
				Status	   : out std_logic_vector(2 downto 0));
	end component;

	begin
	
	--instantiate the different states
	ST0 : state0 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH0, Result_Low => RL0, Status => Status0);
	ST1 : state1 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH1, Result_Low => RL1, Status => Status1);
	ST2 : state2 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH2, Result_Low => RL2, Status => Status2);
	ST3 : state3 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH3, Result_Low => RL3, Status => Status3);
	ST4 : state4 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH4, Result_Low => RL4, Status => Status4);
	ST5 : state5 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH5, Result_Low => RL5, Status => Status5);
	ST6 : state6 port map(A => A, B => B, Result_High => RH6, Result_Low => RL6);
	ST7 : state7 port map(clk => clk, reset => reset, A => A, B => B, Result_High => RH7, Result_Low => RL7, Status => Status7);
	
	-- start of the alu state machine
	STATE_MEMORY : process (clk, reset)
		begin
			if (reset = '0') then
				current_state <= current_state;
			elsif (rising_edge(clk)) then
				current_state <= next_state;
			end if;
	end process;

	STATE_LOGIC : process (current_state)
		begin
			case (Opcode) is
				when "000" => next_state <= S0; -- nop : do nothing
				when "001" => next_state <= S1; -- addition : R = A + B
				when "010" => next_state <= S2; -- subtraction : R = A - B
				when "011" => next_state <= S3; -- multiply : R = A * B
				when "100" => next_state <= S4; -- decrement B : R = B - 1
				when "101" => next_state <= S5; -- move A : R = A
				when "110" => next_state <= S6; -- swap : A <-> B
				when "111" => next_state <= S7; -- OR: A or B
				when others => next_state <= current_state;
			end case;
	end process;

	OUTPUT_LOGIC : process (current_state)	
		begin
			if(Write_En = '1') then
				case (current_state) is
					when S0 => 
						Result_High <= RH0;
						Result_Low  <= RL0;
						Status 	    <= Status0;
					when S1 => 
						Result_High <= RH1;
						Result_Low  <= RL1;
						Status 	    <= Status1;
					when S2 => 
						Result_High <= RH2;
						Result_Low  <= RL2;
						Status 	    <= Status2;
					when S3 => 
						Result_High <= RH3;
						Result_Low  <= RL3;
						Status 		<= Status3;
					when S4 => 
						Result_High <= RH4;
						Result_Low  <= RL4;
						Status 	    <= Status4;
					when S5 => 
						Result_High <= RH5;
						Result_Low  <= RL5;
						Status 	    <= Status5;
					when S6 => 
						Result_High <= RH6;
						Result_Low  <= RL6;
					when S7 => 
						Result_High <= RH7;
						Result_Low  <= RL7;
						Status	    <= Status7;
					when others => 
						Result_High <= std_logic_vector(to_unsigned(0,32));
						Result_Low  <= std_logic_vector(to_unsigned(0,32));
						Status 	    <= std_logic_vector(to_unsigned(0,3));
				end case;
			end if;
		end process;
	
end architecture;
