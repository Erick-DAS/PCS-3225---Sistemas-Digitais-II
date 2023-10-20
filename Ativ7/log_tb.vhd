-- Complete no espaco o codigo do port do testbench

entity testbench is
end testbench;

-- Complete no espaco os sinais e componentes a serem utilizados

architecture beh of testbench is

signal clk ,run : bit;

-- Complete no espaco para gerar o clock
-- Depois , complete no espaco para que
-- o DUT seja instanciado

begin
    clk <= after 10 ns ;
    DUT:
    -- Insira neste trecho o caso de teste
    process
    begin
        run <= 1;
        run <= 0;
        wait;
    end process;
end beh;