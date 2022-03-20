library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity computer is 
	port(clock          : in   std_logic;
             reset          : in   std_logic;
             port_in_00     : in   std_logic_vector (7 downto 0);
             port_in_01     : in   std_logic_vector (7 downto 0);
             port_in_02     : in   std_logic_vector (7 downto 0);
             port_in_03     : in   std_logic_vector (7 downto 0);
             port_in_04     : in   std_logic_vector (7 downto 0);
             port_in_05     : in   std_logic_vector (7 downto 0);
             port_in_06     : in   std_logic_vector (7 downto 0);               
             port_in_07     : in   std_logic_vector (7 downto 0);
             port_in_08     : in   std_logic_vector (7 downto 0);
             port_in_09     : in   std_logic_vector (7 downto 0);
             port_in_10     : in   std_logic_vector (7 downto 0);
             port_in_11     : in   std_logic_vector (7 downto 0);
             port_in_12     : in   std_logic_vector (7 downto 0);
             port_in_13     : in   std_logic_vector (7 downto 0);
             port_in_14     : in   std_logic_vector (7 downto 0);
             port_in_15     : in   std_logic_vector (7 downto 0);                                                                   
             port_out_00    : out  std_logic_vector (7 downto 0);
             port_out_01    : out  std_logic_vector (7 downto 0);
             port_out_02    : out  std_logic_vector (7 downto 0);
             port_out_03    : out  std_logic_vector (7 downto 0);
             port_out_04    : out  std_logic_vector (7 downto 0);
             port_out_05    : out  std_logic_vector (7 downto 0);
             port_out_06    : out  std_logic_vector (7 downto 0);
             port_out_07    : out  std_logic_vector (7 downto 0);
             port_out_08    : out  std_logic_vector (7 downto 0);
             port_out_09    : out  std_logic_vector (7 downto 0);
             port_out_10    : out  std_logic_vector (7 downto 0);
             port_out_11    : out  std_logic_vector (7 downto 0);
             port_out_12    : out  std_logic_vector (7 downto 0);
             port_out_13    : out  std_logic_vector (7 downto 0);
             port_out_14    : out  std_logic_vector (7 downto 0);
             port_out_15    : out  std_logic_vector (7 downto 0));
end entity;


architecture computer_arch of computer is

	component cpu 
		port(Clock 	: in std_logic;
	    	     Reset 	: in std_logic;
	     	     from_memory: in std_logic_vector(7 downto 0);
	
	     	     write	: out std_logic;
	     	     to_memory  : out std_logic_vector(7 downto 0);
	     	     address	: out std_logic_vector(7 downto 0));
	end component;

	component memory 
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
	end component;

	signal address		: std_logic_vector(7 downto 0);
	signal to_memory	: std_logic_vector(7 downto 0);
	signal from_memory	: std_logic_vector(7 downto 0);		
	signal write		: std_logic;

	begin

---------------------------------------------------------------------------------
-- CPU INSTANTIATION
---------------------------------------------------------------------------------
	CPU_1 : cpu
	   port map (Clock 	 => Clock,
		     Reset  	 => Reset,
	     	     from_memory => from_memory,
	     	     write 	 => write,
	     	     to_memory   => to_memory,
	     	     address 	 => address);

---------------------------------------------------------------------------------
-- MEMORY INSTANTIATION
---------------------------------------------------------------------------------
	MEM_1 : memory
	    port map (address    => address,
		      data_in    => to_memory,
		      write      => write,
		      reset  	 => Reset,		     
	 	      clock 	 => Clock,
 
		      port_in_00 => port_in_00,
		      port_in_01 => port_in_01,
		      port_in_02 => port_in_02,
		      port_in_03 => port_in_03,
		      port_in_04 => port_in_04,
		      port_in_05 => port_in_05,
		      port_in_06 => port_in_06,
		      port_in_07 => port_in_07,
		      port_in_08 => port_in_08,
		      port_in_09 => port_in_09,
		      port_in_10 => port_in_10,
		      port_in_11 => port_in_11,
		      port_in_12 => port_in_12,
		      port_in_13 => port_in_13,
		      port_in_14 => port_in_14,
		      port_in_15 => port_in_15,

		      data_out   => from_memory,
		      port_out_00 => port_out_00,
		      port_out_01 => port_out_01,
		      port_out_02 => port_out_02,
		      port_out_03 => port_out_03,
		      port_out_04 => port_out_04,
		      port_out_05 => port_out_05,
		      port_out_06 => port_out_06,
		      port_out_07 => port_out_07,
		      port_out_08 => port_out_08,
		      port_out_09 => port_out_09,
		      port_out_10 => port_out_10,
		      port_out_11 => port_out_11,
		      port_out_12 => port_out_12,
		      port_out_13 => port_out_13,
		      port_out_14 => port_out_14,
		      port_out_15 => port_out_15);

end architecture; 