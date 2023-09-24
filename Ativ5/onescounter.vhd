LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY onescounter IS
    PORT (
        clock : IN BIT;
        reset : IN BIT;
        start : IN BIT;
        inport : IN bit_vector(14 DOWNTO 0);
        outport : OUT bit_vector(3 DOWNTO 0);
        done : OUT BIT
    );
END ENTITY;

ARCHITECTURE onescounter_behave OF onescounter IS

    COMPONENT fluxoDeDados IS
        PORT (
            clock : IN BIT;
            inport : IN bit_vector(14 DOWNTO 0);
            outport : OUT bit_vector(3 DOWNTO 0);

            zera_contadores : IN BIT;
            CF_conta : IN BIT;
            CR_fim : OUT BIT;
            CF_fim : OUT BIT;
            CR_Q : OUT bit_vector(3 DOWNTO 0);
            CF_Q : OUT bit_vector(3 DOWNTO 0);

            D_limpa : IN BIT;
            D_carrega : IN BIT;
            D_desloca : IN BIT
        );
    END COMPONENT;

    COMPONENT unidadeDeControle IS
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
    END COMPONENT;

    SIGNAL zera_contadores, CF_conta, D_limpa, D_carrega, D_desloca, CR_fim, CF_fim : BIT;
    SIGNAL CR_Q, CF_Q : bit_vector(3 DOWNTO 0);
BEGIN

    FD : fluxoDeDados PORT MAP(clock, inport, outport, zera_contadores, CF_conta, CR_fim, CF_fim, CR_Q, CF_Q, D_limpa, D_carrega, D_desloca);
    UC : unidadeDeControle PORT MAP(clock, reset, start, done, zera_contadores, CF_conta, CR_fim, CF_fim, CR_Q, CF_Q, D_limpa, D_carrega, D_desloca);

END ARCHITECTURE;