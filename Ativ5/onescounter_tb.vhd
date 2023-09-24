LIBRARY ieee;
USE ieee.numeric_bit.ALL;

ENTITY onescounter_tb IS
END onescounter_tb;

ARCHITECTURE tb_arch OF onescounter_tb IS
    COMPONENT onescounter IS
        PORT (
            clock : IN BIT;
            reset : IN BIT;
            start : IN BIT;
            inport : IN bit_vector(14 DOWNTO 0);
            outport : OUT bit_vector(3 DOWNTO 0);
            done : OUT BIT
        );
    END COMPONENT;
    TYPE pattern IS RECORD
        inport : bit_vector(14 DOWNTO 0);
        outport : bit_vector(3 DOWNTO 0);
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern;
    CONSTANT tests_case : pattern_array := (
    ("000000000000000", "0000"),
        ("111111111111111", "1111"),
        ("101010101010101", "0100"),
        ("010101010101010", "0011"),
        ("100000000000000", "0001"),
        ("011111111111111", "1110"),
        ("000000000000001", "0001"),
        ("111111111111110", "1110")
    );

    SIGNAL Clock, Reset, Start, Done : BIT;
    SIGNAL inport : bit_vector(14 DOWNTO 0);
    SIGNAL outport : bit_vector(3 DOWNTO 0);

    SIGNAL keep_simulating : BIT := '0';
    CONSTANT clockPeriod : TIME := 1 ns;
BEGIN
    ASSERT false REPORT "Simulation start" SEVERITY note;
    Clock <= (NOT Clock) AND keep_simulating AFTER clockPeriod/2;

    dut : onescounter PORT MAP(
        Clock => clock,
        Reset => reset,
        Start => start,
        inport => inport,
        outport => outport,
        Done => done
    );

    stimulus : PROCESS IS
    BEGIN
        keep_simulating <= '1';
        Reset <= '1';
        Start <= '0';
        FOR i IN tests_case'RANGE LOOP
            WAIT FOR clockPeriod;
            Reset <= '0';
            inport <= tests_case(i).inport;
            WAIT UNTIL falling_edge(Clock);
            Start <= '1';
            WAIT UNTIL falling_edge(Clock);
            Start <= '0';
            WAIT UNTIL Done = '1';
            ASSERT (outport /= tests_case(i).outport)
            REPORT INTEGER'image(i) & ".OK: " & INTEGER'image(to_integer(unsigned(inport))) & " -> " & INTEGER'image(to_integer(unsigned(outport))) SEVERITY note;
            ASSERT (outport = tests_case(i).outport) REPORT "expected: " & INTEGER'image(to_integer(unsigned(tests_case(i).outport))) & " got: " & INTEGER'image(to_integer(unsigned(outport))) SEVERITY error;
        END LOOP;

        ASSERT false REPORT "Simulation ended" SEVERITY note;
        keep_simulating <= '0';
        WAIT;
    END PROCESS;

END ARCHITECTURE;