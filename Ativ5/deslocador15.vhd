library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity deslocador15 is
    
    port (clock   : in bit;
          limpa   : in bit;
          carrega : in bit;
          dados   : in bit_vector(14 downto 0);
          entrada : in bit;
          desloca : in bit;
          saida   : out bit_vector(14 downto 0));
    
end deslocador15;
   
   architecture deslocador15_arch of deslocador15 is
    signal current_value : bit_vector (14 downto 0);
    begin
      saida <= current_value(14 downto 0);

    process(clock, limpa)
    begin
        if (limpa = '1') then
            current_value <= "00000000";
        
        elsif (falling_edge(clock)) then
            if (carrega = '1') then
                current_value <= dados;
            end if;
        
        elsif (rising_edge(clock) and desloca = '1') then
            current_value(0) <= current_value(1);
            current_value(1) <= current_value(2);
            current_value(2) <= current_value(3);
            current_value(3) <= current_value(4);
            current_value(4) <= current_value(5);
            current_value(5) <= current_value(6);
            current_value(6) <= current_value(7);
            current_value(7) <= current_value(8);
            current_value(8) <= current_value(9);
            current_value(9) <= current_value(10);
            current_value(10) <= current_value(11);
            current_value(11) <= current_value(12);
            current_value(12) <= current_value(13);
            current_value(13) <= current_value(14);
            current_value(14) <= entrada;
        end if;
    end process;
  end architecture;