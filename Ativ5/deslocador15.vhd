LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY deslocador15 IS

    PORT (
        clock : IN BIT;
        limpa : IN BIT;
        carrega : IN BIT;
        dados : IN bit_vector(14 DOWNTO 0);
        entrada : IN BIT;
        desloca : IN BIT;
        saida : OUT bit_vector(14 DOWNTO 0));

END deslocador15;

ARCHITECTURE deslocador15_arch OF deslocador15 IS
    SIGNAL current_value : bit_vector (14 DOWNTO 0);
BEGIN
    saida <= current_value(14 DOWNTO 0);

    PROCESS (clock, limpa)
    BEGIN
        IF (limpa = '1') THEN
            current_value <= "000000000000000";

        ELSIF (falling_edge(clock)) THEN
            IF (carrega = '1') THEN
                current_value <= dados;
            END IF;

        ELSIF (rising_edge(clock) AND desloca = '1') THEN
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
        END IF;
    END PROCESS;
END ARCHITECTURE;