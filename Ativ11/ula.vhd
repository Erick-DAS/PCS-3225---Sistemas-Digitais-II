library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
--
-- ULA para o LegV8
--
entity ULA is
    port (
        x1, x2 : in std_logic_vector (63 downto 0); -- entradas
        op : in std_logic_vector (3 downto 0); -- operacao a realizar
        y: out std_logic_vector (63 downto 0); -- saida
        zero : out std_logic); -- indica o resultado zero
end entity;

architecture behavior of ULA is
    signal op_and, op_or, op_soma, op_sub, op_nor: std_logic_vector (63 downto 0);
    
    begin
        -- Operacoes
        op_and <= x1 and x2 ;
        op_or <= x1 or x2 ;
        op_soma <= std_logic_vector ( unsigned ( x1 ) + unsigned ( x2 ));
        op_sub <= std_logic_vector ( unsigned ( x1 ) - unsigned ( x2 ));
        op_nor <= x1 nor x2 ;
        
        -- selecao da saida
        with op select y <=
            op_and when "0000", -- and
            op_or when "0001", -- or
            op_soma when "0010", -- soma
            op_sub when "0110", -- subtracao
            x2 when "0011", -- passa x2
            op_nor when "1100", -- nor
            (others => '0') when others; -- outros casos
        
        -- Verifica resultado igual a zero
        zero <= nor y ;
        -- outra opcao
        -- zero <= '1 ' when unsigned (y) = 0 else '0 ';
end architecture;