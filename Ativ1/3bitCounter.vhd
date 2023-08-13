library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity Counter3Bits is
    port (clock  : in bit;
          clear  : in bit;
          load : in bit;
          entry: in bit_vector(2 downto 0);
          enable_count : in bit;
          RCO : out bit;
          count_variable : out bit_vector(2 downto 0));
end entity;

architecture Counter3Bits_arch of Counter3Bits is
    signal current_count : unsigned(2 downto 0);
    
begin
    count_variable <= bit_vector(current_count);
    RCO <= '1' when current_count = "100" else '0';
    process (clock, clear)
    begin
        if (clear = '1') then
            current_count <= "000";
        elsif (rising_edge(clock)) then
            if (load = '1') then
                current_count <= unsigned(entry);
            elsif (enable_count = '1') then
                current_count <= current_count + 1;
            end if;
        end if;
    end process;
end architecture;