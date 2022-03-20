library IEEE;
use IEEE.STD_Logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity cpu is
	port(Clock 	: in std_logic;
	     Reset 	: in std_logic;
	     from_memory: in std_logic_vector(7 downto 0);
	
	     write	: out std_logic;
	     to_memory  : out std_logic_vector(7 downto 0);
	     address	: out std_logic_vector(7 downto 0));
end entity;

architecture cpu_arch of cpu is
		
		-- Signal Declaration --
	signal IR_Load : std_logic;
	signal IR      : std_logic_vector(7 downto 0);
	signal MAR_Load: std_logic;
	signal PC_Load : std_logic;
	signal PC_Inc  : std_logic;
	signal A_Load  : std_logic;
	signal B_Load  : std_logic;
	signal ALU_Sel : std_logic_vector(2 downto 0);
	signal CCR_Result : std_logic_vector(3 downto 0);
	signal CCR_Load	  : std_logic;
	signal Bus1_Sel   : std_logic_vector(1 downto 0);
	signal Bus2_Sel   : std_logic_vector(1 downto 0);


		-- Component Declaration --
	component control_unit
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
	end component;

	component data_path
		port(clock      : in std_logic;
	     	     reset      : in std_logic;
	     	     IR_Load    : in std_logic;
	     	     PC_load    : in std_logic;
	     	     PC_inc     : in std_logic;
	     	     A_Load	: in std_logic;
	     	     B_Load	: in std_logic;
	     	     CCR_load	: in std_logic;
	     	     MAR_load	: in std_logic;
	     	     ALU_Sel	: in std_logic_vector(2 downto 0);
	     	     Bus1_Sel   : in std_logic_vector(1 downto 0);
	     	     Bus2_Sel   : in std_logic_vector(1 downto 0);
	     	     from_memory: in std_logic_vector(7 downto 0);

	     	     IR		: out std_logic_vector(7 downto 0);
             	     CCR_Result : out std_logic_vector(3 downto 0);
	     	     address    : out std_logic_vector(7 downto 0);
	     	     to_memory  : out std_logic_vector(7 downto 0));
	end component;
		
	begin

		-- Component Insantiations --
	CU_1 : control_unit
		port map (Clock 	=> Clock,
			  Reset 	=> Reset,
			  CCR_Result 	=> CCR_Result,
			  IR    	=> IR,	  
 		  
		   	  IR_Load 	=> IR_Load,
			  MAR_Load 	=> MAR_Load,
			  PC_Load 	=> PC_Load,
			  PC_Inc  	=> PC_Inc,
			  A_Load  	=> A_Load,
			  B_Load  	=> B_Load,
			  ALU_Sel 	=> ALU_Sel,
			  CCR_Load	=> CCR_Load,
			  Bus1_Sel 	=> Bus1_Sel,
			  Bus2_Sel 	=> Bus2_Sel,
			  write 	=> write);

	DP_1 : data_path
		port map (clock 	=> Clock,
			  reset 	=> Reset,
			  IR_Load 	=> IR_Load,
			  PC_Load 	=> PC_Load,
			  PC_Inc  	=> PC_Inc,
			  A_Load  	=> A_Load,
			  B_Load  	=> B_Load,	
			  CCR_Load 	=> CCR_Load,
			  MAR_Load 	=> MAR_Load,
			  ALU_Sel 	=> ALU_Sel,
			  Bus1_Sel 	=> Bus1_Sel,
			  Bus2_Sel 	=> Bus2_Sel,
			  from_memory 	=> from_memory,
	  		  
			  IR 		=> IR,
			  CCR_Result 	=> CCR_Result,
			  address 	=> address,			
		          to_memory 	=> to_memory);

end architecture;

