library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity rw_96x8_sync is 
	port(data_in : in std_logic_vector(7 downto 0);
	     address : in std_logic_vector(7 downto 0);
	     clock   : in std_logic;
	     write   : in std_logic;
	     data_out: out std_logic_vector(7 downto 0));
end entity;

architecture rw_96x8_sync_arch of rw_96x8_sync is

type rw_type is array (128 to 223) of std_logic_vector(7 downto 0); -- from x"80" to x"DF"
signal RW : rw_type;
signal EN : std_logic;

begin

	enable : process (address)
		begin
		  if ((to_integer(unsigned(address)) >= 128) and
		      (to_integer(unsigned(address)) <= 223)) then
			EN <= '1';
		  else
			EN <= '0';
		  end if;
		end process;

	memory : process (clock)
		begin
		  if (rising_edge(clock)) then
			if (EN = '1' and write = '1') then
			  RW(to_integer(unsigned(address))) <= data_in; -- write
		        elsif (EN ='1' and write = '0') then
			  data_out <= RW(to_integer(unsigned(address))); -- read
			end if;
		  end if;
		end process;
			
end architecture; 
