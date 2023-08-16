library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity multiplicador_tb_arquivo is
end multiplicador_tb_arquivo;

architecture multiplicador_tb_arquivo_arch of multiplicador_tb_arquivo is

    -- DUT
    component multiplicador is
        port (
          Clock:    in  bit;
          Reset:    in  bit;
          Start:    in  bit;
          Va,Vb:    in  bit_vector(3 downto 0);
          Vresult:  out bit_vector(7 downto 0);
          Ready:    out bit
        );
      end component;

    -- Declaração de sinais para conectar a componente
  signal clk_in: bit := '0';
  signal rst_in, start_in, ready_out: bit := '0';
  signal va_in, vb_in: bit_vector(3 downto 0);
  signal result_out: bit_vector(7 downto 0);

  -- Configurações do clock
  signal keep_simulating: bit := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 1 ns;

begin

    assert false report "simulation start" severity note;
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período
  -- especificado. Quando keep_simulating=0, clock é interrompido, bem como a 
  -- simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
  
  ---- O código abaixo, sem o "keep_simulating", faria com que o clock executasse
  ---- indefinidamente, de modo que a simulação teria que ser interrompida manualmente
  -- clk_in <= (not clk_in) after clockPeriod/2; 
  
  -- Conecta DUT (Device Under Test)
  dut: multiplicador
       port map(Clock=>   clk_in,
                Reset=>   rst_in,
                Start=>   start_in,
                Va=>      va_in,
                Vb=>      vb_in,
                Vresult=> result_out,
                Ready=>   ready_out
      );

    gerador_estimulos: process is
    
        file tb_file : text open read_mode is "multiplicador_tb_arquivo.dat";
        variable tb_line: line;
        variable space: character;
        variable op1, op2 : bit_vector(3 downto 0);
        variable resultado_esperado: bit_vector(7 downto 0);
        variable ready_esperado: bit;
    
    begin
        rst_in <= '1';
        start_in <= '0';
        keep_simulating <= '1';

        while not endfile(tb_file) loop  -- Enquanto não chegar no final do arquivo ...
            readline(tb_file, tb_line);  -- Lê a próxima linha
            read(tb_line, op1);   -- Da linha que foi lida, lê o primeiro parâmetro (op1)
            read(tb_line, space); -- Lê o espaço após o primeiro parâmetro (separador)
            read(tb_line, op2);   -- Da linha que foi lida, lê o segundo parâmetro (op2)
            read(tb_line, space); -- Lê o próximo espaço usado como separador
            read(tb_line, resultado_esperado); -- Da linha que foi lida, lê o quarto parâmetro (carry_esperado)
        
		    -- Agora que já lemos o caso de teste (par estímulo/saída esperada), vamos aplicar os sinais.
            Va_in <= op1;
		    Vb_in <= op2;

            wait for clockPeriod;
            rst_in <= '0';
            
            wait until falling_edge(clk_in);
            -- pulso do sinal de Start
            start_in <= '1';
            
            wait until falling_edge(clk_in);
            start_in <= '0';
            
            wait until ready_out = '1';
            assert (result_out /= resultado_esperado) report integer'image(to_integer(unsigned(op1))) & " x " & integer'image(to_integer(unsigned(op2))) 
                                        &  " = " & integer'image(to_integer(unsigned(result_out))) severity note;
        
            end loop;
            keep_simulating <= '0';
            assert false report "Teste concluido." severity note;	  
            wait;  -- pára a execução do simulador, caso contrário este process é reexecutado indefinidamente.
    end process;   
end multiplicador_tb_arquivo_arch;












