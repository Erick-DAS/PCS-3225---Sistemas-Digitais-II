library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity UnidadeDeControle is
    port (
        clock : in bit;
        start : in bit;
        reset : in bit;
        ready : out bit;
    
        result_and_count_clear: out bit;
        enable_count : out bit;
        PL_Va : out bit;
        PL_Vb : out bit;
        PL_Vresult : out bit;
        calculate : out bit;
        FD_ready : in bit
        
    );
end UnidadeDeControle;
   
architecture UC_arch of UnidadeDeControle is
type state_t is (s_wait, s_init, s_calculate, s_end);
signal current_state, next_state : state_t;
signal internal_ready, internal_calculating : bit;

begin
    ready <= internal_ready;

    state_machine: process(clock)
    begin
        if (reset = '1') then
            current_state <= s_init;
        elsif (rising_edge(clock)) then
            current_state <= next_state;
        end if;
    end process;

    next_state <= s_wait when (current_state = s_end) else
                  s_init when (current_state = s_wait and start = '1') else
                  s_calculate when (current_state = s_init) else
                  s_end when (current_state = s_calculate and FD_ready = '1');

    internal_ready <= '1' when current_state = s_end else '0';
    internal_calculating <= '1' when current_state = s_calculate else '0';

    process (current_state) is 
    begin 
    case current_state is
        when s_wait =>
            enable_count <= '0';
            result_and_count_clear <= '0';
            PL_Va <= '0';
            PL_Vb <= '0';
            PL_Vresult <= '0';
            calculate <= '0';
        when s_init =>
            enable_count <= '0';
            result_and_count_clear <= '1';
            PL_Va <= '1';
            PL_Vb <= '1';
            PL_Vresult <= '0';
            calculate <= '0';
        when s_calculate =>
            enable_count <= '1';
            result_and_count_clear <= '0';
            PL_Va <= '0';
            PL_Vb <= '0';
            PL_Vresult <= '1';
            calculate <= '1';
        when s_end =>
            enable_count <= '0';
            result_and_count_clear <= '0';
            PL_Va <= '0';
            PL_Vb <= '0';
            PL_Vresult <= '0';
            calculate <= '0';
        end case;
    end process;
            
end architecture;