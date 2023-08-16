-------------------------------------------------------
--! @file multiplicador_tb.vhd
--! @brief testbench for synchronous multiplier
--! @author Edson Midorikawa (emidorik@usp.br)
--! @date 2020-06-15
-------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity multiplicador_tb is
end entity;

architecture tb of multiplicador_tb is
  
  -- Componente a ser testado (Device Under Test -- DUT)
  component multiplicador_modificado
    port (
      Clock:    in  bit;
      Reset:    in  bit;
      Start:    in  bit;
      Va, Vb:    in  bit_vector(3 downto 0);
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
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período
  -- especificado. Quando keep_simulating=0, clock é interrompido, bem como a 
  -- simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
  
  ---- O código abaixo, sem o "keep_simulating", faria com que o clock executasse
  ---- indefinidamente, de modo que a simulação teria que ser interrompida manualmente
  -- clk_in <= (not clk_in) after clockPeriod/2; 
  
  -- Conecta DUT (Device Under Test)
  dut: multiplicador_modificado
       port map(Clock=>   clk_in,
                Reset=>   rst_in,
                Start=>   start_in,
                Va=>      va_in,
                Vb=>      vb_in,
                Vresult=> result_out,
                Ready=>   ready_out
      );

  ---- Gera sinais de estimulo
  stimulus: process is
  begin
  
    assert false report "simulation start" severity note;
    keep_simulating <= '1';
    
    ----------------------------------------------------------------------------------

    ---- Caso de teste 2: A=15, B=11
    Va_in <= "1111"; 
    Vb_in <= "1011"; 
    -- pulso do sinal de Start
    wait until falling_edge(clk_in);
    start_in <= '1';
    wait until falling_edge(clk_in);
    start_in <= '0';
    -- espera pelo termino da multiplicacao
    wait until ready_out='1';
    wait for 1 ps;
    -- verifica resultado
    assert (result_out/="10100101") report "2.OK: 15x11=10100101 (165)" severity note;
    assert false report "result: " & integer'image(to_integer(unsigned(result_out))) severity note;
    
    wait for clockPeriod;    

    ----------------------------------------------------------------------------------

    ---- Caso de teste 3: A=15, B=0
    Va_in <= "1111"; 
    Vb_in <= "0000"; 
    -- pulso do sinal de Start
    wait until falling_edge(clk_in);
    start_in <= '1';
    wait until falling_edge(clk_in);
    start_in <= '0';
    -- espera pelo termino da multiplicacao
    wait until ready_out='1';
    wait for 1 ps;
    -- verifica resultado
    assert (result_out/="00000000") report "3.OK: 15x0=00000000 (0)" severity note;
    assert false report "result: " & integer'image(to_integer(unsigned(result_out))) severity note;

    
    wait for clockPeriod;    
 
    ----------------------------------------------------------------------------------

    ---- Caso de teste 4: A=1, B=11
    Va_in <= "0001"; 
    Vb_in <= "1011"; 
    -- pulso do sinal de Start
    wait until falling_edge(clk_in);
    start_in <= '1';
    wait until falling_edge(clk_in);
    start_in <= '0';
    -- espera pelo termino da multiplicacao
    wait until ready_out='1';
    wait for 1 ps;
    -- verifica resultado
    assert (result_out/="00001011") report "4.OK: 1x11=00001011 (11)" severity note;
    assert false report "result: " & integer'image(to_integer(unsigned(result_out))) severity note;
    
    wait for clockPeriod;  
    ----------------------------------------------------------------------------------

    ---- inserir outros casos de teste aqui

    ----------------------------------------------------------------------------------
 
    -- final do testbench
    assert false report "simulation end" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: aguarda indefinidamente
  end process;


end architecture;