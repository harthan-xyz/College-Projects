--! @file
--! 
--! @author Raymond Weber
--! @author Ross Snider


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

library IEEE;
use IEEE.std_logic_1164.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity DE10_Top_Level is
	port(
		----------------------------------------
		--  CLOCK Inputs
		----------------------------------------
		FPGA_CLK1_50  :  in std_logic;										
		FPGA_CLK2_50  :  in std_logic;										
		FPGA_CLK3_50  :  in std_logic;										

		----------------------------------------
		--  Push Button Inputs (signal name = KEY) - vector with 2 inputs
		--  The KEY inputs produce a '0' when pressed (asserted)
		--  and produce a '1' in the rest state
		--  a better label for KEY would be Push_Button_n 
		----------------------------------------
		KEY : in std_logic_vector(1 downto 0);								-- Pushbuttons on the DE10

		
		Reset : in std_logic;
		----------------------------------------
		--  Switch Inputs (SW) - 4 inputs
		----------------------------------------
		SW  : in std_logic_vector(3 downto 0);								-- Slide Switches on the DE10

		----------------------------------------
		--  LED Outputs - 8 outputs
		----------------------------------------
		LED : out std_logic_vector(7 downto 0);							-- LEDs on the DE10
		
		----------------------------------------
		--  GPIO
		----------------------------------------
		GPIO_0 : inout std_logic_vector(35 downto 0);					-- The 40 pin header on the   top  of the DE10 board
		GPIO_1 : inout std_logic_vector(35 downto 0)					   -- The 40 pin header on the bottom of the DE10 board 
		
	);
end entity DE10_Top_Level;


architecture DE10_arch of DE10_Top_Level is
	
	--define the LED_control component
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

	--create signals for easy manipulation and for legibility
	signal HS_LED_CONTROL : std_logic := '0';
	signal SYSTEM_CLOCKS_PER_SECOND : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(50000000, 32)); --50000000 in binary, typecast
	signal BASE_RATE : std_logic_vector(7 downto 0) := "00010000"; --base rate of 1 Hz in fixed point
	signal LED_REGISTER : std_logic_vector(7 downto 0) := "00000000";
	
	  
begin

	--instantiate the LED control component
	LEDCONTROL : LED_control port map (clk => FPGA_CLK1_50, 
												  reset => KEY(0), 
												  PB => KEY(1), 
												  SW => SW, 
												  HS_LED_control => HS_LED_CONTROL, 
												  SYS_CLKs_sec => SYSTEM_CLOCKS_PER_SECOND, 
												  Base_rate => BASE_RATE, 
												  LED_reg => LED_REGISTER, 
												  LED => LED
												  );
	
end architecture DE10_arch;
