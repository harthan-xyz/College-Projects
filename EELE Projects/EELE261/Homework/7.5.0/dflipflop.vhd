entity Dflipflop is
    port   (Clock           : in   bit;
            Reset           : in   bit;
            D               : in   bit;
            Q, Qn           : out  bit);
end entity;


architecture Dflipflop_arch of Dflipflop is

  begin

     D_FLIP_FLOP  : process (Clock, Reset)
       begin
          if (Reset = '0') then
                   Q <= '0'; Qn <= '1';
          elsif (Clock'event and Clock='1') then
                   Q <= D;   Qn <= not D;
          end if;
       end process D_FLIP_FLOP;  
       
end architecture;
