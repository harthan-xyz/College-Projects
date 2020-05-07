library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataplane_avalon is
  port (
    clk                       : in  std_logic;
    reset                     : in  std_logic;
    avalon_sink_valid         : in  std_logic; --boolean
    avalon_sink_data          : in  std_logic_vector(31  downto 0); --sfix32_En28
    avalon_sink_channel       : in  std_logic_vector(1   downto 0); --ufix2
    avalon_sink_error         : in  std_logic_vector(1   downto 0); --ufix2
    avalon_source_valid       : out std_logic; --boolean
    avalon_source_data        : out std_logic_vector(31  downto 0); --sfix32_En28
    avalon_source_channel     : out std_logic_vector(1   downto 0); --ufix2
    avalon_source_error       : out std_logic_vector(1   downto 0); --ufix2
    avalon_slave_address      : in  std_logic_vector(1   downto 0);            
    avalon_slave_read         : in  std_logic;
    avalon_slave_readdata     : out std_logic_vector(31  downto 0);
    avalon_slave_write        : in  std_logic;
    avalon_slave_writedata    : in  std_logic_vector(31  downto 0);
	 LED                       : out std_logic_vector(7   DOWNTO 0)  -- uint8
  );
end entity dataplane_avalon;

architecture dataplane_avalon_arch of dataplane_avalon is

  -- Internal signals with default power up values
  signal max_reset_threshold       : std_logic_vector(17 DOWNTO 0)  :=  "000011100001000000";               -- 14400 -- ufix18
  signal LED_persistence           : std_logic_vector(14 DOWNTO 0)  :=  "001001011000000";                  -- 4800  -- ufix15


  -- component created by HDL Coder
component dataplane_src_dataplane
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        avalon_sink_valid                 :   IN    std_logic;
        avalon_sink_data                  :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_sink_channel               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_sink_error                 :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        register_control_reset_threshold  :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18
        register_control_LED_persistence  :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
        ce_out                            :   OUT   std_logic;
        avalon_source_valid               :   OUT   std_logic;
        avalon_source_data                :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_source_channel             :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_source_error               :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        LED                               :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
end component;


begin

u_dataplane : dataplane_src_dataplane
  port map(
    clk                                  =>  clk,
    reset                                =>  reset,
    clk_enable                           =>  '1',
    avalon_sink_valid                    =>  avalon_sink_valid,               
    avalon_sink_data                     =>  avalon_sink_data,                
    avalon_sink_channel                  =>  avalon_sink_channel,             
    avalon_sink_error                    =>  avalon_sink_error,               
	register_control_reset_threshold 	 =>  max_reset_threshold,
    register_control_LED_persistence     =>  LED_persistence,
    avalon_source_valid                  =>  avalon_source_valid,             
    avalon_source_data                   =>  avalon_source_data,              
    avalon_source_channel                =>  avalon_source_channel,           
    avalon_source_error                  =>  avalon_source_error,
	LED                                  =>  LED
  );

  bus_read : process(clk)
  begin
    if rising_edge(clk) and avalon_slave_read = '1' then
      case avalon_slave_address is
        when "00" => avalon_slave_readdata <= "00000000000000" & max_reset_threshold;
        when "01" => avalon_slave_readdata <= "00000000000000000" & LED_persistence;
        when others => avalon_slave_readdata <= (others => '0');
      end case;
    end if;
  end process;

  
  bus_write : process(clk, reset)
  begin
    if reset = '1' then
	  max_reset_threshold       <=  "000011100001000000";               -- 14400 
      LED_persistence           <=  "001001011000000";                  -- 4800  
    elsif rising_edge(clk) and avalon_slave_write = '1' then
      case avalon_slave_address is
        when "00" => max_reset_threshold <= avalon_slave_writedata(17 DOWNTO 0);
        when "01" => LED_persistence     <= avalon_slave_writedata(14 downto 0);
        when others => null;
      end case;
    end if;
  end process;

end architecture;