library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity ShiftRegister4Bits is
    
    port (clock       : in bit;
          clear       : in bit;
          parallel_load          : in bit;
          parallel_entry          : in bit_vector(3 downto 0);
          enable_shift : in bit;
          serial_entry : in bit;
          reg_value  : out bit_vector(3 downto 0));
    
   end ShiftRegister4Bits;
   
   architecture ShiftRegister4Bits_arch of ShiftRegister4Bits is
    signal current_value : bit_vector (3 downto 0);
    begin
      reg_value <= current_value(3 downto 0);

    process(clock, clear)
    begin
        if (clear = '1') then
            current_value <= "0000";
        
        elsif (rising_edge(Clock)) then
            if (parallel_load = '1') then
                current_value <= parallel_entry;
            end if;
        
        elsif (falling_edge(clock)) then
            if (enable_shift = '1') then
                current_value(3) <= serial_entry;
                current_value(2) <= current_value(3);
                current_value(1) <= current_value(2);
                current_value(0) <= current_value(1);
            end if;
        end if;
    end process;
  end architecture;