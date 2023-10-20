LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY fluxoDeDados IS
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
END ENTITY;

ARCHITECTURE FD_behave OF fluxoDeDados IS

    COMPONENT contador4 IS
        PORT (
            clock : IN BIT;
            zera : IN BIT;
            conta : IN BIT;
            fim : OUT BIT;
            Q : OUT bit_vector(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT deslocador15 IS
        PORT (
            clock : IN BIT;
            limpa : IN BIT;
            carrega : IN BIT;
            dados : IN bit_vector(14 DOWNTO 0);
            entrada : IN BIT;
            desloca : IN BIT;
            saida : OUT bit_vector(14 DOWNTO 0));
    END COMPONENT;

    SIGNAL CR_conta : BIT;
    SIGNAL reg_value : bit_vector(14 DOWNTO 0);
BEGIN

    CR_conta <= inport(0) WHEN D_carrega = '1' ELSE
        reg_value(0);
    contadorReal : contador4 PORT MAP(clock, zera_contadores, CR_conta, CR_fim, outport);
    contadorFinal : contador4 PORT MAP(clock, zera_contadores, CF_conta, CF_fim, CF_Q);
    deslocador : deslocador15 PORT MAP(clock, D_limpa, D_carrega, inport, '0', D_desloca, reg_value);

END ARCHITECTURE;