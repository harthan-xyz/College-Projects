-- Qsys file to control the LEDs on the DE-10 Nano
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Qsys_LED_control is
	port(
			--------------------------------------------------------
			-- Interface with Avalon bus
			--------------------------------------------------------
			clk					: 	in std_logic;
			reset_n 				: 	in std_logic; --reset asserted low
			avs_s1_address		: 	in std_logic_vector(1 downto 0);
			avs_s1_write		: 	in std_logic;
			avs_s1_writedata	:	in std_logic_vector(31 downto 0);
			avs_s1_read			: 	in std_logic;
			avs_s1_readdata	: 	out std_logic_vector(31 downto 0);
			switches				: 	in std_logic_vector(3 downto 0);
			pushbutton			: 	in std_logic;
			LEDs					: 	out std_logic_vector(7 downto 0)
			);
end Qsys_LED_control;

architecture Qsys_LED_control_arch of Qsys_LED_control is
	
	signal reg0 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg1 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(50000000, 32));
	signal reg2 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg3 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(16,32));

	component LED_control is
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
	end component;
	
	
	begin
	
	READ_REG: process (clk) is
		begin
			if (rising_edge(clk) and avs_s1_read = '1') then
				case (avs_s1_address) is 
					when "00" => avs_s1_readdata <= reg0;
					when "01" => avs_s1_readdata <= reg1;
					when "10" => avs_s1_readdata <= reg2;
					when "11" => avs_s1_readdata <= reg3;
					when others => avs_s1_readdata <= (others=>'0'); --return zeros for undefined registers;
				end case;
			end if;
	end process;
	
	WRITE_REG : process (clk) is
		begin
			if (rising_edge(clk) and avs_s1_write = '1') then
				case (avs_s1_address) is
					when "00" => reg0 <= avs_s1_writedata;
					when "01" => reg1 <= avs_s1_writedata;
					when "10" => reg2 <= avs_s1_writedata;
					when "11" => reg3 <= avs_s1_writedata;
					when others => null;
				end case;
			end if;
	end process;

	
	--instantiate the LED control component
	LEDCONTROL : LED_control port map (clk => clk, 
												  reset => reset_n, 
												  PB => pushbutton, 
												  SW => switches, 
												  HS_LED_control => reg0(0), 
												  SYS_CLKs_sec => reg1, 
												  Base_rate => reg3(7 downto 0), 
												  LED_reg => reg2(7 downto 0), 
												  LED => LEDs
												  );
	
end architecture;
