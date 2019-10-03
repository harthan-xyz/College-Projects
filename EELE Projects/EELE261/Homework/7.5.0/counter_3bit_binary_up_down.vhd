entity counter_3bit_binary_up_down is
	port (Clock : in bit;
	Reset : in bit;
	Up	: in bit;
	Count : out bit_vector (2 downto 0));
end entity;

architecture counter_3bit_binary_up_down_arch of counter_3bit_binary_up_down is
		
	signal Q2_nxt, Q1_nxt, Q0_nxt : bit;
	signal Q2_cur, Q1_cur, Q0_cur : bit;
	signal Q2n_cur, Q1n_cur, Q0n_cur : bit;
	signal current_state : bit_vector (3 downto 0);
	
	component Dflipflop 
		port (Clock : in bit;
				Reset : in bit;
				D : in bit;
				Q, Qn : out bit);
	end component;
	
	begin
	
	U0 : Dflipflop port map (Clock, Reset, Q0_nxt, Q0_cur, Q0n_cur);
	U1 : Dflipflop port map (Clock, Reset, Q1_nxt, Q1_cur, Q1n_cur);
	U2 : Dflipflop port map (Clock, Reset, Q2_nxt, Q2_cur, Q2n_cur);
	
	current_state <= Q2_cur & Q1_cur & Q0_cur & Up;
	
	with (current_state) select
		Q2_nxt <= '1' when "0000"|"0111"|"1001"|"1010"|"1011"|"1100"|"1101"|"1110",
		'0' when others;
	
	with (current_state) select	
		Q1_nxt <= '1' when "0000"|"0011"|"0101"|"0110"|"1000"|"1011"|"1101"|"1110",
		'0' when others;
		
	with (current_state) select
		Q0_nxt <= '1' when "0000"|"0001"|"0100"|"0101"|"1000"|"1001"|"1100"|"1101",
		'0' when others;
		
		Count <= Q2_cur & Q1_cur & Q0_cur;
		
end architecture;