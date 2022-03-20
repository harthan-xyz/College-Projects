library IEEE;
use IEEE.std_logic_1164.all;

entity fsm2_behavioral is
   port (Clock, Reset : in  std_logic;
         Din          : in  std_logic;
         Dout         : out std_logic);
end entity;

architecture fsm2_behavioral_arch of fsm2_behavioral is
	
	type State_Type is (S0, S1, S2, S3);
	signal current_state, next_state: State_Type;
	
	begin
		
		STATE_MEMORY : process (Clock, Reset)
			begin 
			  if(Reset = '0') then
				current_state <= S0;
			  elsif (rising_edge(Clock)) then
				current_state <= next_state;
			  end if;
		end process;
			
		NEXT_STATE_LOGIC : process (current_state, Din)
			 begin
			   case (current_state) is
			        when S0 => if (Din = '1') then
						next_state <= S1;
       					   else
					        next_state <= S0;
				           end if;
-----------------------------------------------------------------------------			        
                                when S1 => if (Din = '1') then
						next_state <= S3;
					   else
						next_state <= S2;
					   end if;
------------------------------------------------------------------------------				
				when S2 => if (Din = '1') then
						next_state <= S3;
					   else 
						next_state <= S0;
					   end if;
------------------------------------------------------------------------------				
 				when S3 => if (Din = '1') then
						next_state <= S0;
					   else
						next_state <= S3;
					   end if;
-------------------------------------------------------------------------------
				when others => next_state <= S0;
			   end case;
		end process;

		OUTPUT_LOGIC : process (current_state, Din)
			begin
			  case(current_state) is
			        when S0 => if (Din = '1') then
						 Dout <= '1';
       					   else
					         Dout <= '0';
				           end if;
-----------------------------------------------------------------------------			        
                                when S1 => if (Din = '1') then
						Dout <= '0';
					   else
						Dout <= '1';
					   end if;
------------------------------------------------------------------------------				
				when S2 => if (Din = '1') then
						Dout <= '1';
					   else
						Dout <= '0';
					   end if;
------------------------------------------------------------------------------				
 				when S3 => if (Din = '1') then
						Dout <= '1';
					   else
						Dout <= '0';
					   end if;
-------------------------------------------------------------------------------
				when others => Dout <= '0';
			   end case;
		end process;
end architecture;
