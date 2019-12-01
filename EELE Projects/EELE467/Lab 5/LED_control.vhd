-- Joshua Harthan
-- EELE 467
-- LED_control Lab #4
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LED_control is
	 port(
        clk            : in  std_logic;                         -- system clock
        reset          : in  std_logic;                         -- system reset
        PB             : in  std_logic;                         -- Pushbutton to change state  
        SW             : in  std_logic_vector(3 downto 0);      -- Switches that determine next state
        HS_LED_control : in  std_logic;                         -- Software is in control when asserted (=1)
        SYS_CLKs_sec   : in  std_logic_vector(31 downto 0);     -- Number of system clock cycles in one second
        Base_rate      : in  std_logic_vector(7 downto 0);      -- base transition time in seconds, fixed-point data type
        LED_reg        : in  std_logic_vector(7 downto 0);      -- LED register
        LED            : out std_logic_vector(7 downto 0)       -- LEDs on the DE10-Nano board
    );
end entity LED_control;

architecture LED_control_arch of LED_control is

--define the states to be used in the state machine
	type State_Type is (S0,S1,S2,S3,S4,show_state);
	signal current_state, next_state, previous_state : State_Type;
	
	--create the signals for the LED registers
	signal LED0_register : std_logic_vector(6 downto 0);
	signal LED1_register : std_logic_vector(6 downto 0);
	signal LED2_register : std_logic_vector(6 downto 0);
	signal LED3_register : std_logic_vector(6 downto 0);
	signal LED4_register : std_logic_vector(6 downto 0);
	
	--flag to signal if the SW display should be shown
	signal LED_Display_On : std_logic;
	
	--signal to represent a valid push
	signal push : std_logic;
	
	--signals to represent the various clock frequencies
	signal clock_by_1 : std_logic;
	signal clock_by_2 : std_logic;
	signal clock_by_4	: std_logic;
	
	signal BASE2 : std_logic_vector(7 downto 0);
	signal BASE4 : std_logic_vector(7 downto 0);
	
	--define the states to be used in the state machine
	component state0 is
		port (clock	: in std_logic;
				Reset : in std_logic;
				LED0	: out std_logic_vector(6 downto 0));
	end component;
	
	component state1 is
		port (clock	: in std_logic;
				Reset : in std_logic;
				LED1	: out std_logic_vector(6 downto 0));
	end component;

	component state2 is
		port (clock	: in std_logic;
				Reset : in std_logic;
				LED2	: out std_logic_vector(6 downto 0));
	end component;
	
	component state3 is
		port (clock	: in std_logic;
				Reset : in std_logic;
				LED3	: out std_logic_vector(6 downto 0));
	end component;
	
	component state4 is
		port (clock	: in std_logic;
				Reset : in std_logic;
				LED4	: out std_logic_vector(6 downto 0));
	end component;
	
	--define the blinking LED component
	component LED7 is
		port	(clock: in std_logic;
				 LED	: out std_logic);
	end component;
	
	--define the push button condition compoenent
	component PB_condition is
	port   (clock : in std_logic;
	        PB_In : in std_logic;
			  PB_out: out std_logic);
	end component;
	
	--define the clock generator o be used
	component clock_generator is
	 port(
        clk            : in  std_logic;                                                 
        SYS_CLKs_sec   : in  std_logic_vector(31 downto 0);     
        Base_rate      : in  std_logic_vector(7 downto 0);      
		  Clock_out		  : out std_logic
    );
	end component;
	
	
	begin
	
	--define the base rates to be twice and four times as fast, respectively
	BASE2 <= "0" & Base_rate(7 downto 1);
	BASE4 <= "00" & Base_rate(7 downto 2);
	
	--instantiate the clock frequency generators 
	CLOCK_GEN_1 : clock_generator port map (clk => clk, SYS_CLKs_sec => SYS_CLKs_sec, Base_rate => Base_rate, Clock_out => Clock_by_1);
	CLOCK_GEN_2 : clock_generator port map (clk => clk, SYS_CLKs_sec => SYS_CLKs_sec, Base_rate => BASE2, Clock_out => Clock_by_2);
	CLOCK_GEN_4 : clock_generator port map (clk => clk, SYS_CLKs_sec => SYS_CLKs_sec, Base_rate => BASE4, Clock_out => Clock_by_4);
	
	--instantiate LED7 as continuously blinking at the base rate * 1
	LED_7 : LED7 port map(clock => clock_by_1, LED => LED(7));
	
	--instantiate the different states
	ST0 : state0 port map(clock => clock_by_2, Reset => reset, LED0 => LED0_register);
	ST1 : state1 port map(clock => clock_by_4, Reset => reset, LED1 => LED1_register);
	ST2 : state2 port map(clock => clock_by_1, Reset => reset, LED2 => LED2_register);
	ST3 : state3 port map(clock => clock_by_4, Reset => reset, LED3 => LED3_register);
	ST4 : state4 port map(clock => clock_by_2, Reset => reset, LED4 => LED4_register);
	
	--instantiate the push button to be correctly synchronized, debounced, and single pulse
	PUSHBUTTON : PB_condition port map (clock => clk, PB_In => PB, PB_Out => Push);
	
	--process to set the flag to show the current switch
		LED_DISPLAY : process(clk, Push)
		--counter to time one second based off clock 
		variable count : integer :=  0;
		begin
			if (Push = '0') then
			LED_Display_On <= '1';
			count := 0;
			elsif(rising_edge(clk)) then			
				if(count = 50000000) then
					count := 0;
					LED_Display_On <= '0';
				else
					count := count + 1;
				end if;		
			end if;
		end process;
		
		
	--start of LED display state machine	
		STATE_MEMORY : process (clk, reset)
			begin
			  if (reset = '0') then
				current_state <= current_state;
			  elsif (rising_edge(Clk)) then
				current_state <= next_state;
			  end if;
		end process;

		STATE_LOGIC : process (current_state, Push, SW)
			begin
				if (Push = '0') then
					case (SW) is
						when "0000" => next_state <= S0;
					  
						when "0001" => next_state <= S1;
					  
						when "0010" => next_state <= S2;
				
						when "0011" => next_state <= S3;
				
						when "0100" => next_state <= S4;	
									
						when others => next_state <= current_state;
					end case;
				end if;
		end process;

		OUTPUT_LOGIC : process (current_state)
			begin
			if (HS_LED_control = '1') then
				LED(6 downto 0) <= LED_reg(6 downto 0);
				elsif (LED_Display_On = '0') then
					case(current_state) is
			        	  when S0 => LED(6 downto 0) <= LED0_register; 
                			  when S1 => LED(6 downto 0) <= LED1_register;	  
					  when S2 => LED(6 downto 0) <= LED2_register;
					  when S3 => LED(6 downto 0) <= LED3_register;
					  when S4 => LED(6 downto 0) <= LED4_register;
					  when others => LED(6 downto 0) <= LED0_register;
					 end case;
				else
					LED(6 downto 0) <= "000" & SW;
				end if;
		 end process;
end architecture;
