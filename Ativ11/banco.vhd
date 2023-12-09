library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
--
-- Banco de 32 Registradores de 64 bits
--
entity banco is
    port (
        clk : in std_logic -- sinal de clock
        we : in std_logic; -- habilitacao de escrita
        W: in std_logic_vector (63 downto 0); -- valor de entrada
        Rm : in std_logic_vector (4 downto 0); -- indice do registrador 1 ( ler )
        Rn : in std_logic_vector (4 downto 0); -- indice do registrador 2 ( ler )
        Rd : in std_logic_vector (4 downto 0); -- indice do registrador a escrever
        Ra : out std_logic_vector (63 downto 0); -- primeira saida
        Rb : out std_logic_vector (63 downto 0)); -- segunda saida 
end entity;

architecture behavior of banco is
    type REGS is array (0 to 31) of std_logic_vector (63 downto 0);
    signal r: REGS := (
        -- alguns valores iniciais para teste :
        0 => x"000000000000AAAA", -- X0
        1 => x"0000000000005555", -- X1
        2 => x"0000000000003333", -- X2
        3 => x"0000000000000001", -- X3 , etc
        others => (others => '0')
    );
    begin
        -- saidas
        Ra <= (others => '0') when Rn = "11111" else r(to_integer(unsigned(Rn)));
        Rb <= (others => '0') when Rm = "11111" else r(to_integer(unsigned(Rm)));
        
        -- entrada
        r(to_integer(unsigned(Rd))) <= W when (we='1') and rising_edge(clk);
end architecture ;
