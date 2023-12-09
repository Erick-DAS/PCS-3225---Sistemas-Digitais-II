LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--
-- Banco de 32 Registradores de 64 bits
--
ENTITY banco IS
    PORT (
        clk : IN STD_LOGIC; -- sinal de clock
        we : IN STD_LOGIC; -- habilitacao de escrita
        W : IN STD_LOGIC_VECTOR (63 DOWNTO 0); -- valor de entrada
        Rm : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 1 ( ler )
        Rn : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 2 ( ler )
        Rd : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador a escrever
        Ra : OUT STD_LOGIC_VECTOR (63 DOWNTO 0); -- primeira saida
        Rb : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
    ); -- segunda saida 
END ENTITY;

ARCHITECTURE behavior OF banco IS
    TYPE REGS IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR (63 DOWNTO 0);
    SIGNAL r : REGS := (
        -- alguns valores iniciais para teste :
        0 => x"000000000000AAAA", -- X0
        1 => x"0000000000005555", -- X1
        2 => x"0000000000003333", -- X2
        3 => x"0000000000000001", -- X3 , etc
        OTHERS => (OTHERS => '0')
    );
BEGIN
    -- saidas
    Ra <= (OTHERS => '0') WHEN Rn = "11111" ELSE
        r(to_integer(unsigned(Rn)));
    Rb <= (OTHERS => '0') WHEN Rm = "11111" ELSE
        r(to_integer(unsigned(Rm)));

    -- entrada
    r(to_integer(unsigned(Rd))) <= W WHEN (we = '1') AND rising_edge(clk);
END ARCHITECTURE;