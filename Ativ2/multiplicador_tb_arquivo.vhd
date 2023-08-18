LIBRARY ieee;
USE ieee.numeric_bit.ALL;
USE std.textio.ALL;

ENTITY multiplicador_tb_arquivo IS
END multiplicador_tb_arquivo;

ARCHITECTURE multiplicador_tb_arquivo_arch OF multiplicador_tb_arquivo IS

  -- DUT
  COMPONENT multiplicador IS
    PORT (
      Clock : IN BIT;
      Reset : IN BIT;
      Start : IN BIT;
      Va, Vb : IN bit_vector(3 DOWNTO 0);
      Vresult : OUT bit_vector(7 DOWNTO 0);
      Ready : OUT BIT
    );
  END COMPONENT;

  -- Declaração de sinais para conectar a componente
  SIGNAL clk_in : BIT := '0';
  SIGNAL rst_in, start_in, ready_out : BIT := '0';
  SIGNAL va_in, vb_in : bit_vector(3 DOWNTO 0);
  SIGNAL result_out : bit_vector(7 DOWNTO 0);

  -- Configurações do clock
  SIGNAL keep_simulating : BIT := '0'; -- delimita o tempo de geração do clock
  CONSTANT clockPeriod : TIME := 1 ns;

BEGIN

  ASSERT false REPORT "simulation start" SEVERITY note;
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período
  -- especificado. Quando keep_simulating=0, clock é interrompido, bem como a 
  -- simulação de eventos
  clk_in <= (NOT clk_in) AND keep_simulating AFTER clockPeriod/2;

  ---- O código abaixo, sem o "keep_simulating", faria com que o clock executasse
  ---- indefinidamente, de modo que a simulação teria que ser interrompida manualmente
  -- clk_in <= (not clk_in) after clockPeriod/2; 

  -- Conecta DUT (Device Under Test)
  dut : multiplicador
  PORT MAP(
    Clock => clk_in,
    Reset => rst_in,
    Start => start_in,
    Va => va_in,
    Vb => vb_in,
    Vresult => result_out,
    Ready => ready_out
  );

  gerador_estimulos : PROCESS IS

    FILE tb_file : text OPEN read_mode IS "multiplicador_tb_arquivo.dat";
    VARIABLE tb_line : line;
    VARIABLE space : CHARACTER;
    VARIABLE op1, op2 : bit_vector(3 DOWNTO 0);
    VARIABLE resultado_esperado : bit_vector(7 DOWNTO 0);
    VARIABLE ready_esperado : BIT;

  BEGIN
    rst_in <= '1';
    start_in <= '0';
    keep_simulating <= '1';

    WHILE NOT endfile(tb_file) LOOP -- Enquanto não chegar no final do arquivo ...
      readline(tb_file, tb_line); -- Lê a próxima linha
      read(tb_line, op1); -- Da linha que foi lida, lê o primeiro parâmetro (op1)
      read(tb_line, space); -- Lê o espaço após o primeiro parâmetro (separador)
      read(tb_line, op2); -- Da linha que foi lida, lê o segundo parâmetro (op2)
      read(tb_line, space); -- Lê o próximo espaço usado como separador
      read(tb_line, resultado_esperado); -- Da linha que foi lida, lê o quarto parâmetro (carry_esperado)

      -- Agora que já lemos o caso de teste (par estímulo/saída esperada), vamos aplicar os sinais.
      Va_in <= op1;
      Vb_in <= op2;

      WAIT FOR clockPeriod;
      rst_in <= '0';

      WAIT UNTIL falling_edge(clk_in);
      -- pulso do sinal de Start
      start_in <= '1';

      WAIT UNTIL falling_edge(clk_in);
      start_in <= '0';

      WAIT UNTIL ready_out = '1';
      ASSERT (result_out /= resultado_esperado) REPORT INTEGER'image(to_integer(unsigned(op1))) & " x " & INTEGER'image(to_integer(unsigned(op2)))
      & " = " & INTEGER'image(to_integer(unsigned(result_out))) SEVERITY note;

    END LOOP;
    keep_simulating <= '0';
    ASSERT false REPORT "Teste concluido." SEVERITY note;
    WAIT; -- pára a execução do simulador, caso contrário este process é reexecutado indefinidamente.
  END PROCESS;
END multiplicador_tb_arquivo_arch;