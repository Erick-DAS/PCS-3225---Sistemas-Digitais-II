LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY contador4 IS
    PORT (
        clock : IN BIT;
        zera : IN BIT;
        conta : IN BIT;
        fim : OUT BIT;
        Q : OUT bit_vector(3 DOWNTO 0));
END contador4;

ARCHITECTURE contador4_arch OF contador4 IS
    SIGNAL current_count : unsigned(3 DOWNTO 0);
BEGIN
    Q <= bit_vector(current_count);
    fim <= '1' WHEN current_count = "1111" ELSE
        '0';
    PROCESS (clock, zera)
    BEGIN
        IF (zera = '1') THEN
            current_count <= "0000";
        ELSIF (rising_edge(clock)) THEN
            IF (conta = '1') THEN
                current_count <= current_count + 1;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;