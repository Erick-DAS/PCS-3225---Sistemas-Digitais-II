library ieee;
use ieee.numeric_bit.all;

entity multiplicador_modificado is
    port (
      Clock : in bit ;
      Reset : in bit ;
      Start : in bit ;
      Va, Vb : in bit_vector (3 downto 0 ) ;
      Vresult : out bit_vector (7 downto 0 ) ;
      Ready : out bit
    );
end entity;
 
architecture MM_arch of multiplicador_modificado is

    component FluxoDeDados is
        port (
            clock : in bit;
            Va : in bit_vector (3 downto 0);
            Vb : in bit_vector (3 downto 0);
            Vresult : out bit_vector (7 downto 0);
            
            result_and_count_clear: in bit;
            enable_count : in bit;
            PL_Va : in bit;
            PL_Vb : in bit;
            PL_Vresult : in bit;
            calculate : in bit;
            FD_ready : out bit
        );
    end component;
    
    component UnidadeDeControle is
        port (
            clock : in bit;
            start : in bit;
            reset : in bit;
            ready : out bit;
        
            result_and_count_clear: out bit;
            enable_count : out bit;
            PL_Va : out bit;
            PL_Vb : out bit;
            PL_Vresult : out bit;
            calculate : out bit;
            FD_ready : in bit
        );
    end component;

    signal result_and_count_clear, enable_count, PL_Va, PL_Vb, PL_Vresult, calculate, FD_ready, invert_clock : bit;
    begin
        invert_clock <= not clock;
        FD: FluxoDeDados port map (invert_clock, Va, Vb, Vresult, result_and_count_clear, enable_count, PL_Va, PL_Vb, PL_Vresult, calculate, FD_ready);
        UC: UnidadeDeControle port map (clock, start, reset, ready, result_and_count_clear, enable_count, PL_Va, PL_Vb, PL_Vresult, calculate, FD_ready);


end architecture;