library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity Adder4Bits is
    port (Va, Vb  : in bit_vector (3 downto 0);
          Cout    : out bit;
          Vresult : out bit_vector (3 downto 0));
end entity;
  
architecture Adder4Bits_arch of Adder4Bits is
    signal Va_5bits, Vb_5bits, Vresult_5bits: unsigned (4 downto 0);
    begin 
      process(Va, Vb)
      begin
        Va_5bits <= unsigned ('0' & Va);
        Vb_5bits <= unsigned ('0' & Vb);
        Vresult_5bits <= Va_5bits + Vb_5bits;
        Vresult <= bit_vector(Vresult_5bits(3 downto 0));
        Cout <= bit(Vresult_5bits(4));
      end process;
end architecture;