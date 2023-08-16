library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity ShiftRegister8Bits is
    
    port (clock       : in bit;
          clear       : in bit;
          parallel_load          : in bit;
          parallel_entry          : in bit_vector(7 downto 0);
          serial_entry : in bit;
          partial_result  : out bit_vector(7 downto 0));
    
   end ShiftRegister8Bits;
   
   architecture ShiftRegister8Bits_arch of ShiftRegister8Bits is
    signal current_value : bit_vector (7 downto 0);
    begin
      partial_result <= current_value(7 downto 0);

    process(clock, clear)
    begin
        if (clear = '1') then
            current_value <= "00000000";
        
        elsif (rising_edge(clock)) then
            if (parallel_load = '1') then
                current_value <= parallel_entry;
            end if;
        
        elsif (falling_edge(clock)) then
            current_value(0) <= current_value(1);
            current_value(1) <= current_value(2);
            current_value(2) <= current_value(3);
            current_value(3) <= current_value(4);
            current_value(4) <= current_value(5);
            current_value(5) <= current_value(6);
            current_value(6) <= current_value(7);
            current_value(7) <= serial_entry;
        
        end if;
    end process;
  end architecture;