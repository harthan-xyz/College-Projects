library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity memory is 
	port(address : in std_logic_vector(7 downto 0);
	     data_in : in std_logic_vector(7 downto 0);
	     write   : in std_logic;
	     reset   : in std_logic;
	     clock   : in std_logic;
	     port_in_00 : in std_logic_vector(7 downto 0);
	     port_in_01 : in std_logic_vector(7 downto 0);
             port_in_02 : in std_logic_vector(7 downto 0);
	     port_in_03 : in std_logic_vector(7 downto 0);
	     port_in_04 : in std_logic_vector(7 downto 0);
	     port_in_05 : in std_logic_vector(7 downto 0);
	     port_in_06 : in std_logic_vector(7 downto 0);
	     port_in_07 : in std_logic_vector(7 downto 0);
	     port_in_08 : in std_logic_vector(7 downto 0);
	     port_in_09 : in std_logic_vector(7 downto 0);
	     port_in_10 : in std_logic_vector(7 downto 0);
	     port_in_11 : in std_logic_vector(7 downto 0);
	     port_in_12 : in std_logic_vector(7 downto 0);
	     port_in_13 : in std_logic_vector(7 downto 0);
	     port_in_14 : in std_logic_vector(7 downto 0);
	     port_in_15 : in std_logic_vector(7 downto 0);


	     data_out: out std_logic_vector(7 downto 0);
	     port_out_00 : out std_logic_vector(7 downto 0);
	     port_out_01 : out std_logic_vector(7 downto 0);
             port_out_02 : out std_logic_vector(7 downto 0);
	     port_out_03 : out std_logic_vector(7 downto 0);
	     port_out_04 : out std_logic_vector(7 downto 0);
	     port_out_05 : out std_logic_vector(7 downto 0);
	     port_out_06 : out std_logic_vector(7 downto 0);
	     port_out_07 : out std_logic_vector(7 downto 0);
	     port_out_08 : out std_logic_vector(7 downto 0);
	     port_out_09 : out std_logic_vector(7 downto 0);
	     port_out_10 : out std_logic_vector(7 downto 0);
	     port_out_11 : out std_logic_vector(7 downto 0);
	     port_out_12 : out std_logic_vector(7 downto 0);
	     port_out_13 : out std_logic_vector(7 downto 0);
	     port_out_14 : out std_logic_vector(7 downto 0);
	     port_out_15 : out std_logic_vector(7 downto 0));
end entity;

architecture memory_arch of memory is

	-- COMPONENT DECLARATION --

	component rom_128x8_sync
		port(address : in std_logic_vector(7 downto 0);
	     	     clock   : in std_logic;
	             data_out: out std_logic_vector(7 downto 0));
	end component;

	component rw_96x8_sync
		port(data_in : in std_logic_vector(7 downto 0);
	             address : in std_logic_vector(7 downto 0);
	             clock   : in std_logic;
	             write   : in std_logic;
	     	     data_out: out std_logic_vector(7 downto 0));
	end component;

	-- SIGNAL INSTANTIATION --
	
	signal rom_data_out: std_logic_vector(7 downto 0);
	signal rw_data_out : std_logic_vector(7 downto 0);

	begin

	-- COMPONENT INSTANTIATION --

	ROM: rom_128x8_sync
		port map(address      => address,
	     	     	 clock        => clock,
	             	 data_out     => rom_data_out);

	RW: rw_96x8_sync
		port map(data_in    => data_in,
	                 address    => address,
	                 clock      => clock,
	                 write      => write,
	     	         data_out   => rw_data_out);

------------------------------------------------------------------------------------------------------------------------------------------
						-- OUTPUT PORTS --
------------------------------------------------------------------------------------------------------------------------------------------

        -- port_out_00 description : ADDRESS x"E0"
	U3 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_00 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E0" and write = '1') then
			port_out_00 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_01 description : ADDRESS x"E1"
	U4 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_01 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E1" and write = '1') then
			port_out_01 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_02 description : ADDRESS x"E2"
	U5 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_02 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E2" and write = '1') then
			port_out_02 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_03 description : ADDRESS x"E3"
	U6 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_03 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E3" and write = '1') then
			port_out_03 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_04 description : ADDRESS x"E4"
	U7 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_04 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E4" and write = '1') then
			port_out_04 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_05 description : ADDRESS x"E5"
	U8 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_05 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E5" and write = '1') then
			port_out_05 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_06 description : ADDRESS x"E6"
	U9 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_06 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E6" and write = '1') then
			port_out_06 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_07 description : ADDRESS x"E7"
	U10 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_07 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E7" and write = '1') then
			port_out_07 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_08 description : ADDRESS x"E8"
	U11 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_08 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E8" and write = '1') then
			port_out_08 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_09 description : ADDRESS x"E9"
	U12 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_09 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"E9" and write = '1') then
			port_out_09 <= data_in;
	  	   end if;
		end if;
	end process;
	
	-- port_out_10 description : ADDRESS x"EA"
	U13 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_10 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"EA" and write = '1') then
			port_out_10 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_11 description : ADDRESS x"EB"
	U14 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_11 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"EB" and write = '1') then
			port_out_11 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_12 description : ADDRESS x"EC"
	U15 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_12 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"EC" and write = '1') then
			port_out_12 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_13 description : ADDRESS x"ED"
	U16 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_13 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"ED" and write = '1') then
			port_out_13 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_14 description : ADDRESS x"EE"
	U17 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_14 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"EE" and write = '1') then
			port_out_14 <= data_in;
	  	   end if;
		end if;
	end process;

	-- port_out_15 description : ADDRESS x"EF"
	U18 : process (clock, reset)
		begin
		if (reset = '0') then
			port_out_15 <= x"00";
		elsif (rising_edge(clock)) then
		   if (address = x"EF" and write = '1') then
			port_out_15 <= data_in;
	  	   end if;
		end if;
	end process;

------------------------------------------------------------------------------------------------------------------------------------------
						-- MULTIPLEXER --
------------------------------------------------------------------------------------------------------------------------------------------
	MUX1 : process (address, rom_data_out, rw_data_out, 
			port_in_00, port_in_01, port_in_02, port_in_03,
			port_in_04, port_in_05, port_in_06, port_in_07,
			port_in_08, port_in_09, port_in_10, port_in_11,
			port_in_12, port_in_13, port_in_14, port_in_15)

		begin
			if ((to_integer(unsigned(address)) >= 0) and
			     (to_integer(unsigned(address)) <= 127)) then
				data_out <= rom_data_out;
			elsif ((to_integer(unsigned(address)) >= 128) and
				(to_integer(unsigned(address)) <= 223)) then
				data_out <= rw_data_out;

			elsif (address = x"F0") then data_out <= port_in_00;
			elsif (address = x"F1") then data_out <= port_in_01;
			elsif (address = x"F2") then data_out <= port_in_02;
			elsif (address = x"F3") then data_out <= port_in_03;
			elsif (address = x"F4") then data_out <= port_in_04;
			elsif (address = x"F5") then data_out <= port_in_05;
			elsif (address = x"F6") then data_out <= port_in_06;
			elsif (address = x"F7") then data_out <= port_in_07;
			elsif (address = x"F8") then data_out <= port_in_08;
			elsif (address = x"F9") then data_out <= port_in_09;
			elsif (address = x"FA") then data_out <= port_in_10;
			elsif (address = x"FB") then data_out <= port_in_11;
			elsif (address = x"FC") then data_out <= port_in_12;
			elsif (address = x"FD") then data_out <= port_in_13;
			elsif (address = x"FE") then data_out <= port_in_14;
			elsif (address = x"FF") then data_out <= port_in_15;
			
			else data_out <= x"00";

			end if;

		end process;

end architecture;