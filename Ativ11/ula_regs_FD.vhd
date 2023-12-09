library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
--
-- Agrupamento da ULA e Banco de Registradores
--
entity ULARegs is
    port (
        y: out std_logic_vector (63 downto 0); -- saida da ULA
        op : in std_logic_vector (3 downto 0); -- operacao a realizar
        zero : out std_logic; -- indica o resultado zero
        Rd : in std_logic_vector (4 downto 0); -- indice do registrador a escrever
        Rm : in std_logic_vector (4 downto 0); -- indice do registrador 1 (ler )
        Rn : in std_logic_vector (4 downto 0); -- indice do registrador 2 (ler )
        we : in std_logic; -- habilitacao de escrita
        clk : in std_logic); -- sinal de clock
end entity ;

architecture ULARegs_arch of ULARegs is

    component ULA is
        port (
            y: out std_logic_vector (63 downto 0); -- saida
            x1 , x2 : in std_logic_vector (63 downto 0); -- entradas
            op : in std_logic_vector (3 downto 0); -- operacao a realizar
            zero : out std_logic); -- indica o resultado zero
    end component;

    component banco is
        port (
            W: in std_logic_vector (63 downto 0); -- valor de entrada
            Ra : out std_logic_vector (63 downto 0); -- primeira saida
            Rb : out std_logic_vector (63 downto 0); -- segunda saida
            Rd : in std_logic_vector (4 downto 0); -- indice do registrador a escrever
            Rm : in std_logic_vector (4 downto 0); -- indice do registrador 1 ( ler )
            Rn : in std_logic_vector (4 downto 0); -- indice do registrador 2 ( ler )
            we : in std_logic ; -- habilitacao de escrita
            clk : in std_logic); -- sinal de clock
    end component;

begin

end architecture;
