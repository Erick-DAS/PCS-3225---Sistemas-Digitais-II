library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity FlipFlopD is
    port (D, clock : in bit;
          Q        : out bit);
end entity;

architecture FlipFlopD_arch of FlipFlopD is
begin
    process(clock)
    begin            
        if (rising_edge(clock)) then Q <= D;
        end if;
    end process;
end architecture;
    