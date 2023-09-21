library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity fluxoDeDados is
    port (
        clock   : in bit;
        inport  : in bit_vector(14 downto 0);
        outport : out bit_vector(3 downto 0);

        zera_contadores: in bit;
        CF_conta: in bit;
        CR_fim: out bit;
        CF_fim: out bit;
        CR_Q: out bit_vector(3 downto 0);
        CR_F: out bit_vector(3 downto 0);
        
        D_limpa: in bit;
        D_carrega: in bit;
        D_desloca: in bit;
        D_saida: out bit_vector(14 downto 0);

    );
end entity;

architecture FD_behave of fluxoDeDados is

component contador4 is
    port (clock : in bit;
          zera  : in bit;
          conta : in bit;
          fim   : out bit;
          Q     : out bit_vector(3 downto 0));
end component;

component deslocador15 is
    port (clock   : in bit;
          limpa   : in bit;
          carrega : in bit;
          dados   : in bit_vector(14 downto 0);
          entrada : in bit;
          desloca : in bit;
          saida   : out bit_vector(14 downto 0));
end component;

signal CR_conta: bit;

begin

    CR_conta <= inport(0);

    contadorReal: contador4 port map (clock, zera_contador, CR_conta, CR_fim, outport);
    contadorFinal: contador4 port map (clock, zera_contador, CF_conta, CF_fim, CF_Q);
    deslocador: deslocador15 port map (clock, D_limpa, D_carrega, inport, '0', D_desloca, D_saida);

end architecture
