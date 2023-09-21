library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity onescounter is
    port (
        clock : in bit;
        reset : in bit;
        start : in bit;
        inport : in bit_vector(14 downto 0);
        outport : out bit_vector(3 downto 0);
        done : out bit
    );
end entity;

architecture onescounter_behave of onescounter is
    signal zera_contadores, CF_conta, D_limpa, D_carrega, D_desloca, CR_fim, CF_fim : bit;
    signal CR_Q, CR_F : bit_vector(3 downto 0);
    signal D_saida : bit_vector(14 downto 0);
begin

FD: fluxoDeDados port map(clock, inport, outport, zera_contadores, CF_conta, CR_fim, CF_fim, CR_Q, CR_F, D_limpa, D_carrega, D_desloca, D_saida);
UC: unidadeDeControle port map(clock, reset, start, done, zera_contadores, CF_conta, D_limpa, D_carrega, D_desloca);

end architecture;

