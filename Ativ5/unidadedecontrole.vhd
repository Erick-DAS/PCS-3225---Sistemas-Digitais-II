library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity unidadeDeControle is 
    port (
        clock : in bit;
        reset : in bit;
        start : in bit
    );
end entity;

architecture behave of unidadeDeControle is 
    type state is (s0, s1, s2, s3, s4);
    signal current_state, next_state : state := s0;
begin
    process(clock)
    begin
        if (rising_edge(clock)) then
            current_state <= next_state;
        end if;
    end process;
        
    process(current_state, start)
    begin
        case current_state is 
            when s0 =>
                if (start = '1') then
                    next_state <= s1;
                end if;
            when s1 => 
                next_state <= s2;
            when s2 =>
                if (conta = '1') then -- conta eh o bit menos significativo do registrador
                    next_state <= s3;
                end if;
            when s3 =>
                if (fim = '1') then --fim eh a saida do contador de 4 bits q conta ate 15
                    next_state <= s4;
                else 
                    next_state <= s3;
                end if;
            when s4 =>
                    next_state <= s0;
        end case;
    end process;

    --descrever as variaveis de saida em cada estado
    process(current_state) 
    begin
        case current_state is 
            when s0 =>

    end process; 

end architecture