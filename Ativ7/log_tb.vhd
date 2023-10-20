-- Complete no espaco o codigo do port do testbench

entity testbench is
end testbench;

-- Complete no espaco os sinais e componentes a serem utilizados

architecture beh of testbench is

    component log is 
        port (
            clock, inicio : in bit;
            x             : in bit_vector(7 downto 0);
            R             : out bit_vector(7 downto 0);
            fim           : out bit;
        );
    end component;

    signal clk, run : bit;

-- Complete no espaco para gerar o clock
-- Depois , complete no espaco para que
-- o DUT seja instanciado
    signal X, r : bit_vector(7 downto 0);
    signal Inicio, Fim : bit;

begin
    assert false report "Inicio da simulacao" severity note;
    clk <= (not clk) and run after 10 ns;
    DUT: log port map(
        clk => clock,
        Inicio => inicio,
        X => x,
        r => r,
        Fim => fim
    );
    
    -- Insira neste trecho o caso de teste
    process
    begin
        run <= 1;
        x <= "11000001";
        wait for 1 ns;
        inicio <= 1;
            


        assert (R = "01001010") report "Houve um erro. O resultado esperado era 01001010, o obtido foi " & INTEGER'image(to_integer(unsigned(R))) severity error; 
        run <= 0;
        wait;
    end process;
end beh;