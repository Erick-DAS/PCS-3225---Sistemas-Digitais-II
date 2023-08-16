LIBRARY ieee;
USE ieee.numeric_bit.ALL;

ENTITY multiplicador_tb_vetorteste IS
END multiplicador_tb_vetorteste;

ARCHITECTURE tb_arch OF multiplicador_tb_vetorteste IS
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

    TYPE pattern IS RECORD
        Va, Vb : bit_vector(3 DOWNTO 0);
        Vresult : bit_vector(7 DOWNTO 0);
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern;
    CONSTANT tests_case : pattern_array := (
    ("0011", "0110", "00010010"),
        ("1111", "1011", "10100101"),
        ("1111", "0000", "00000000"),
        ("0001", "1011", "00001011")
    );

    SIGNAL Clock, Reset, Start, Ready : BIT;
    SIGNAL Va, Vb : bit_vector(3 DOWNTO 0);
    SIGNAL Vresult : bit_vector(7 DOWNTO 0);

    SIGNAL keep_simulating : BIT := '0';
    CONSTANT clockPeriod : TIME := 1 ns;
BEGIN
    Clock <= (NOT Clock) AND keep_simulating AFTER clockPeriod/2;

    dut : multiplicador PORT MAP(
        Clock => Clock,
        Reset => Reset,
        Start => Start,
        Va => Va,
        Vb => Vb,
        Vresult => Vresult,
        Ready => Ready
    );

    stimulus : PROCESS IS
    BEGIN
        keep_simulating <= '1';
        ASSERT false REPORT "Simulation start" SEVERITY note;
        Reset <= '1';
        Start <= '0';
        WAIT FOR clockPeriod;
        FOR i IN tests_case'RANGE LOOP
            Reset <= '0';
            Va <= tests_case(i).Va;
            Vb <= tests_case(i).Vb;
            WAIT UNTIL falling_edge(Clock);
            Start <= '1';
            WAIT UNTIL falling_edge(Clock);
            Start <= '0';
            WAIT UNTIL Ready = '1';
            ASSERT (Vresult /= tests_case(i).Vresult)
            REPORT INTEGER'image(i) & ".OK: " & INTEGER'image(to_integer(unsigned(Va))) & " * " & INTEGER'image(to_integer(unsigned(Vb))) & " = " & INTEGER'image(to_integer(unsigned(Vresult))) SEVERITY note;
            ASSERT (Vresult = tests_case(i).Vresult) REPORT "expected: " & INTEGER'image(to_integer(unsigned(tests_case(i).Vresult))) & " got: " & INTEGER'image(to_integer(unsigned(Vresult))) SEVERITY error;
        END LOOP;

        ASSERT false REPORT "Simulation ended" SEVERITY note;
        keep_simulating <= '0';
        WAIT;
    END PROCESS;

END ARCHITECTURE;