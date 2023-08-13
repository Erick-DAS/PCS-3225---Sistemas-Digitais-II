library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity Register4Bits is
    port (clock : in bit;
          clear : in bit;
          load  : in bit;
          entry : in bit_vector(3 downto 0);
          reg   : out bit_vector(3 downto 0));
end entity;

architecture Register4Bits_arch of Register4Bits is
signal current_value : bit_vector(3 downto 0);
begin
    reg <= current_value;
    process(clock, clear)
    begin
        if (clear = '1') then
            current_value <= "0000";
        elsif (rising_edge(clock)) then
            if (load = '1') then
                current_value <= entry;
            end if;
        end if;
    end process;
end architecture;