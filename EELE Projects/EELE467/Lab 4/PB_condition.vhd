library IEEE;
use IEEE.std_logic_1164.all;

entity PB_condition is
	port   (clock : in std_logic;
	        PB_In : in std_logic;
			  PB_Out: out std_logic);
end entity;

architecture PB_condition_arch of PB_condition is
	--define signals to be used for the different processes of the push button
	signal sync	 : std_logic;
	signal PBPush: std_logic;
	signal PBdb	 : std_logic;
	signal PBOut : std_logic;

begin
	
	--process that debounces the push button to ignore changes > 100 ms
	DEBOUNCE : process(clock)
	variable count : integer := 0;
	begin
		if(rising_edge(clock)) then
			count := count + 1;
			PBPush <= Pbdb;
			if (count = 100) then
				count := 0;
				if (rising_edge(clock) and PB_In = '0') then
				PBdb <= PB_In;
				end if;
			end if;
		 end if;
	end process;
	
	--process that creates a sinlge pulse for an extended press
	SINGLEPULSE : process(clock)
	begin
		if (PBdb = '0' and PBPush = '0') then
			PBout <= '1';
		elsif(PBdb = '0' and PBPush = '1') then
			PBout <= '0';
		end if;
	end process;
	
	--process that synchronizes push to the clock, equivalent to running the clock through two d-flip-flops
	SYNCHRONIZE : process(clock)
	begin
		if(rising_edge(clock)) then
			sync <= PBout;
			PB_Out <= sync;
		end if;
	end process;
	
end architecture;