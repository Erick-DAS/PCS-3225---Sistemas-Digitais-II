-- Complete no espaco o codigo do port do testbench
LIBRARY IEEE;
USE IEEE.numeric_bit.ALL;

ENTITY testbench IS
END testbench;

-- Complete nogg espaco os sinais e componentes a serem utilizados

ARCHITECTURE beh OF testbench IS

    COMPONENT log IS
        PORT (
            clock, inicio : IN BIT;
            x : IN bit_vector(7 DOWNTO 0);
            R : OUT bit_vector(7 DOWNTO 0);
            fim : OUT BIT
        );
    END COMPONENT;

    SIGNAL clk, run : BIT;

    -- Complete no espaco para gerar o clock
    -- Depois , complete no espaco para que
    -- o DUT seja instanciado
    SIGNAL X, r : bit_vector(7 DOWNTO 0);
    SIGNAL Inicio, Fim : BIT;

BEGIN
    ASSERT false REPORT "Inicio da simulacao" SEVERITY note;
    clk <= (NOT clk) AND run AFTER 10 ns;
    DUT : log PORT MAP(
        clock => clk,
        inicio => Inicio,
        x => X,
        R => r,
        fim => Fim
    );

    -- Insira neste trecho o caso de teste
    PROCESS
    BEGIN
        run <= '1';
        x <= "11000001";
        WAIT FOR 1 ns;
        inicio <= '1';

        ASSERT (R = "01001010") REPORT "Houve um erro. O resultado esperado era 01001010, o obtido foi " & INTEGER'image(to_integer(unsigned(R))) SEVERITY error;
        run <= '0';
        WAIT;
    END PROCESS;
END beh;