LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;

ENTITY Adder4Bits IS
  PORT (
    Va, Vb : IN bit_vector (3 DOWNTO 0);
    Cout : OUT BIT;
    Vresult : OUT bit_vector (3 DOWNTO 0));
END ENTITY;

ARCHITECTURE Adder4Bits_arch OF Adder4Bits IS
  SIGNAL Va_5bits, Vb_5bits, Vresult_5bits : unsigned (4 DOWNTO 0);
BEGIN
  Va_5bits <= unsigned ('0' & Va);
  Vb_5bits <= unsigned ('0' & Vb);
  Vresult_5bits <= Va_5bits + Vb_5bits;
  Vresult <= bit_vector(Vresult_5bits(3 DOWNTO 0));
  Cout <= BIT(Vresult_5bits(4));
END ARCHITECTURE;