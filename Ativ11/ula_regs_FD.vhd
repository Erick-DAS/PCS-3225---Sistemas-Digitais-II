LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--
-- Agrupamento da ULA e Banco de Registradores
--
ENTITY ULARegs IS
    PORT (
        --intput signals
        op : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- operacao a realizar
        Rd : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador a escrever
        Rm : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 1 (ler )
        Rn : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 2 (ler )
        we : IN STD_LOGIC; -- habilitacao de escrita
        clk : IN STD_LOGIC; -- sinal de clock
        --output signals 
        zero : OUT STD_LOGIC; -- indica o resultado zero
        y : OUT STD_LOGIC_VECTOR (63 DOWNTO 0) -- saida da ULA
    );
END ENTITY;

ARCHITECTURE ULARegs_arch OF ULARegs IS

    COMPONENT ULA IS
        PORT (
            x1, x2 : IN STD_LOGIC_VECTOR (63 DOWNTO 0); -- entradas
            op : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- operacao a realizar
            y : OUT STD_LOGIC_VECTOR (63 DOWNTO 0); -- saida
            zero : OUT STD_LOGIC); -- indica o resultado zero
    END COMPONENT;

    COMPONENT banco IS
        PORT (
            clk : IN STD_LOGIC; -- sinal de clock
            we : IN STD_LOGIC; -- habilitacao de escrita
            W : IN STD_LOGIC_VECTOR (63 DOWNTO 0); -- valor de entrada
            Rm : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 1 ( ler )
            Rn : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 2 ( ler )
            Rd : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador a escrever
            Ra : OUT STD_LOGIC_VECTOR (63 DOWNTO 0); -- primeira saida
            Rb : OUT STD_LOGIC_VECTOR (63 DOWNTO 0)); -- segunda saida
    END COMPONENT;

    SIGNAL Ra, Rb : STD_LOGIC_VECTOR (63 DOWNTO 0); -- entradas da ULA/Saida do banco de Registradores
    SIGNAL saida : STD_LOGIC_VECTOR (63 DOWNTO 0); -- saida da ULA/Entrada do banco de Registradores

BEGIN
    unidadeLogica : ULA PORT MAP(Ra, Rb, op, saida, zero);
    BancoDeRegistradores : banco PORT MAP(clk, we, saida, Rm, Rn, Rd, Ra, Rb);
    y <= saida;

END ARCHITECTURE;