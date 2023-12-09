LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--
-- ULA para o LegV8
--
ENTITY ULA IS
    PORT (
        x1, x2 : IN STD_LOGIC_VECTOR (63 DOWNTO 0); -- entradas
        op : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- operacao a realizar
        y : OUT STD_LOGIC_VECTOR (63 DOWNTO 0); -- saida
        zero : OUT STD_LOGIC); -- indica o resultado zero
END ENTITY;

ARCHITECTURE behavior OF ULA IS
    SIGNAL op_and, op_or, op_soma, op_sub, op_nor : STD_LOGIC_VECTOR (63 DOWNTO 0);
    SIGNAL saida : STD_LOGIC_VECTOR (63 DOWNTO 0);
BEGIN
    -- Operacoes
    op_and <= x1 AND x2;
    op_or <= x1 OR x2;
    op_soma <= STD_LOGIC_VECTOR (unsigned (x1) + unsigned (x2));
    op_sub <= STD_LOGIC_VECTOR (unsigned (x1) - unsigned (x2));
    op_nor <= x1 NOR x2;

    -- selecao da saida
    WITH op SELECT saida <=
        op_and WHEN "0000", -- and
        op_or WHEN "0001", -- or
        op_soma WHEN "0010", -- soma
        op_sub WHEN "0110", -- subtracao
        x2 WHEN "0011", -- passa x2
        op_nor WHEN "1100", -- nor
        (OTHERS => '0') WHEN OTHERS; -- outros casos

    -- Verifica resultado igual a zero
    -- zero <= saida NOR saida;
    y <= saida;
    -- outra opcao
    zero <= '1' WHEN unsigned (saida) = 0 ELSE
        '0';
END ARCHITECTURE;