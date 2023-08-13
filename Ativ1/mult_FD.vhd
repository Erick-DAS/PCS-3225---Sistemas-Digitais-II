library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity FluxoDeDados is
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
end entity;

architecture FD_arch of FluxoDeDados is 

component Adder4Bits is
    port (Va, Vb  : in bit_vector (3 downto 0);
          Cout    : out bit;
          Vresult : out bit_vector (3 downto 0));
end component;

component Register4Bits is
    port (clock : in bit;
          clear : in bit;
          load  : in bit;
          entry : in bit_vector(3 downto 0);
          reg   : out bit_vector(3 downto 0));
end component;

component ShiftRegister4Bits is
    
    port (clock       : in bit;
          clear       : in bit;
          parallel_load          : in bit;
          parallel_entry          : in bit_vector(3 downto 0);
          serial_entry : in bit;
          reg_value  : out bit_vector(3 downto 0));
    
   end component;

component ShiftRegister8Bits is
    port (clock           : in bit;
          clear           : in bit;
          parallel_load   : in bit;
          parallel_entry  : in bit_vector(7 downto 0);
          serial_entry    : in bit;
          partial_result  : out bit_vector(7 downto 0));
    
   end component;

component Counter3Bits is
    port (clock          : in bit;
          clear          : in bit;
          load           : in bit;
          entry          : in bit_vector(2 downto 0);
          enable_count   : in bit;
          RCO            : out bit;
          count_variable : out bit_vector(2 downto 0));
end component;

component FlipFlopD is
    port (D, clock : in bit;
          Q        : out bit);
end component;

signal ready_FF_out, change_ready, add_cout, counter_RCO, aux_ready : bit;
signal counter_variable : bit_vector(2 downto 0);
signal Reg_Va, Reg_Vb, added_parcel, add_result : bit_vector(3 downto 0);
signal Reg_Vresult, Vresult_shifter_entry : bit_vector(7 downto 0); 

begin
    FD_ready <= aux_ready;
    aux_ready <= (not ready_FF_out) and (counter_RCO);
    change_ready <= aux_ready and counter_RCO;
    added_parcel <= Reg_Vb when Reg_Va(0) = '1' else "0000";
    Vresult_shifter_entry <= add_result & Reg_Vresult(3 downto 0); 
    Vresult <= Reg_Vresult;

    ready_FF: FlipFlopD port map (change_ready, clock, ready_FF_out);

    counter: Counter3Bits port map (clock, result_and_count_clear , '0', "000", enable_count, counter_RCO, counter_variable);

    adder: Adder4Bits port map (added_parcel, Reg_Vresult(7 downto 4), add_cout, add_result);

    Va_shifter: ShiftRegister4Bits port map (clock, '0', PL_Va, Va, Reg_Va(0), Reg_Va);
    Vb_register: Register4Bits port map (clock, '0', PL_Vb, Vb, Reg_Vb);
    result_shifter: ShiftRegister8Bits port map (clock, result_and_count_clear, PL_Vresult, Vresult_shifter_entry, add_cout, Reg_Vresult);
        
end architecture;