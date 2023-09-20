library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity contador4 is
    port (clock : in bit;
          zera  : in bit;
          conta : in bit;
          fim   : out bit;
          Q     : out bit_vector(3 downto 0));
end entity;

architecture contador4_arch of contador4 is
    signal current_count : unsigned(3 downto 0);
begin
    Q <= bit_vector(current_count);
    fim <= '1' when current_count = "1111" else '0';
    process (clock, zera)
    begin
        if (zera = '1') then
            current_count <= "000";
        elsif (rising_edge(clock)) then
            if (conta = '1') then
                current_count <= current_count + 1;
            end if;
        end if;
    end process;
end architecture;