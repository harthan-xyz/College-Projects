-- Joshua Harthan, Jordan Palmer
-- Qsys file to control the ALU and MUX on the DE-10 Nano
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Qsys_alu is
	port(
		--------------------------------------------------------
			-- Interface with Avalon bus--
		--------------------------------------------------------
		clk		: 	in std_logic;
		reset_n 	: 	in std_logic; --reset asserted low
		avs_s1_address	: 	in std_logic_vector(2 downto 0);
		avs_s1_write	: 	in std_logic;
		avs_s1_writedata:	in std_logic_vector(31 downto 0);
		avs_s1_read	: 	in std_logic;
		avs_s1_readdata	: 	out std_logic_vector(31 downto 0);
		switches	: 	in std_logic_vector(3 downto 0);
		LEDs		: 	out std_logic_vector(7 downto 0)
		);
end Qsys_alu;

architecture Qsys_alu_arch of Qsys_alu is

	--define the 32-bit registers
	signal reg0 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg1 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg2 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg3 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg4 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal reg5 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	
	signal write_en : std_logic;
	
	--define the ALU component
	component alu is
		port(
		     clk	: in std_logic;
		     reset	: in std_logic;
		     A	  	: in std_logic_vector(31 downto 0);
		     B	  	: in std_logic_vector(31 downto 0);
		     Opcode 	: in std_logic_vector(2 downto 0);	
		     Write_en 	: in std_logic;
			
		     Result_High : out std_logic_vector(31 downto 0);
		     Result_Low  : out std_logic_vector(31 downto 0);
		     Status	 : out std_logic_vector(2 downto 0)
		     );
	end component;
	
	-- define the mux component
	component mux is	
		port(
			  A	      : in std_logic_vector(31 downto 0);
			  B	      : in std_logic_vector(31 downto 0);
			  Result_High : in std_logic_vector(31 downto 0);
			  Result_Low  : in std_logic_vector(31 downto 0);
			  SW	      : in std_logic_vector(3 downto 0);
			  
			  LED 	      : out std_logic_vector(7 downto 0)
			  );
	end component;
	
	begin
	
	-- read from each register
	READ_REG: process (clk) is
		begin
			if (rising_edge(clk) and avs_s1_read = '1') then
				case (avs_s1_address) is 
					when "000" => avs_s1_readdata <= reg0;
					when "001" => avs_s1_readdata <= reg1;
					when "010" => avs_s1_readdata <= reg2;
					when "011" => avs_s1_readdata <= reg3;
					when "100" => avs_s1_readdata <= reg4;
					when "101" => avs_s1_readdata <= reg5;
					when others => avs_s1_readdata <= (others=>'0'); --return zeros for undefined registers
				end case;
			end if;
	end process;
	
	-- write to register 0 - 3; we do cannot write to the output signals
	WRITE_REG : process (clk) is
		begin
			if (rising_edge(clk) and avs_s1_write = '1') then
				case (avs_s1_address) is
					when "000" => reg0 <= avs_s1_writedata;
							      write_en <= '0';
					when "001" => reg1 <= avs_s1_writedata;
							      write_en <= '0';
					when "010" => reg2 <= avs_s1_writedata;
							      write_en <= '1'; --only do operation when the opcode is changed
					when others => null; --return null for undefined registers
				end case;
			end if;
	end process;

	--instantiate the ALU component
	ALU1: alu port map(
			   clk => clk,
			   reset => reset_n,
			   A => reg0,
			   B => reg1,
			   Opcode => reg2(2 downto 0),
			   Write_En => Write_En,
			   Result_High => reg4,
			   Result_Low => reg3,
			   Status => reg5(2 downto 0)
			   );

	--instantiate the multiplexer component
	MUX1 : mux port map (
			     A => reg0, 
			     B => reg1, 
			     Result_High => reg4, 
			     Result_Low => reg3, 
			     SW => switches, 
			     LED => LEDs
			     ); 
	
end architecture;
