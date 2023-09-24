LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY unidadeDeControle IS
    PORT (
        clock : IN BIT;
        reset : IN BIT;
        start : IN BIT;
        done : OUT BIT;

        zera_contadores : OUT BIT;
        CF_conta : OUT BIT;
        CR_fim : IN BIT;
        CF_fim : IN BIT;
        CR_Q : IN bit_vector(3 DOWNTO 0);
        CF_Q : IN bit_vector(3 DOWNTO 0);

        D_limpa : OUT BIT;
        D_carrega : OUT BIT;
        D_desloca : OUT BIT
    );
END ENTITY;

ARCHITECTURE UC_behave OF unidadeDeControle IS
    TYPE state IS (s0, s1, s2, s3);
    SIGNAL current_state, next_state : state := s0;
BEGIN
    PROCESS (clock)
    BEGIN
        IF (rising_edge(clock)) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    PROCESS (current_state, start, reset, CF_fim)
    BEGIN
        CASE current_state IS
            WHEN s0 =>
                IF (start = '1') THEN
                    next_state <= s1;
                END IF;
            WHEN s1 =>
                next_state <= s2;
                IF (reset = '1') THEN
                    next_state <= s0;
                END IF;
            WHEN s2 =>
                IF (reset = '1') THEN
                    next_state <= s0;
                ELSIF (CF_fim = '1') THEN
                    next_state <= s3;
                END IF;
            WHEN s3 =>
                next_state <= s0;
        END CASE;
    END PROCESS;

    --descrever as variaveis de saida em cada estado
    PROCESS (current_state)
    BEGIN
        CASE current_state IS
            WHEN s0 =>
                done <= '0';
                zera_contadores <= '0';
                D_limpa <= '0';
                D_carrega <= '0';
                D_desloca <= '0';
                CF_conta <= '0';

            WHEN s1 =>
                done <= '0';
                zera_contadores <= '1';
                D_limpa <= '0';
                D_carrega <= '1';
                D_desloca <= '1';
                CF_conta <= '1';

            WHEN s2 =>
                done <= '0';
                zera_contadores <= '0';
                D_limpa <= '0';
                D_carrega <= '0';
                D_desloca <= '1';
                CF_conta <= '1';

            WHEN s3 =>
                done <= '1';
                zera_contadores <= '0';
                D_limpa <= '0';
                D_carrega <= '0';
                D_desloca <= '0';
                CF_conta <= '0';
        END CASE;
    END PROCESS;

END ARCHITECTURE;