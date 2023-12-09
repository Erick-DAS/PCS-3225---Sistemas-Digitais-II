LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END ENTITY;

ARCHITECTURE testbench_behave OF testbench IS
    COMPONENT ULARegs IS
        PORT (
            --intput signals
            op : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- operacao a realizar
            Rd : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador a escrever
            Rm : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 1 (ler )
            Rn : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 2 (ler )
            we : IN STD_LOGIC; -- habilitacao de escrita
            clk : IN STD_LOGIC; -- sinal de clock
            --output signals 
            zero : OUT STD_LOGIC; -- indica o resultado zero
            y : OUT STD_LOGIC_VECTOR (63 DOWNTO 0) -- saida da ULA
        );
    END COMPONENT;

    TYPE test IS RECORD
        op : STD_LOGIC_VECTOR (3 DOWNTO 0); -- operacao a realizar
        Rd : STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador a escrever
        Rm : STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 1 (ler )
        Rn : STD_LOGIC_VECTOR (4 DOWNTO 0); -- indice do registrador 2 (ler )
        we : STD_LOGIC; -- habilitacao de escrita
        zero : STD_LOGIC; -- indica o resultado zero
        y : STD_LOGIC_VECTOR (63 DOWNTO 0); -- saida da ULA
    END RECORD;

    TYPE test_array IS ARRAY (NATURAL RANGE <>) OF test;
    CONSTANT tests_case : test_array := (
    ("0000", "00100", "00000", "00001", '1', '1', x"0000000000000000"),
        ("0001", "00100", "0000", "00001", '1', '0', x"00000000000AFFF5"),
        ("0010", "00100", "0000", "00001", '1', '0', x"000000000000FFFF"),
        ("0110", "00100", "0000", "00001", '1', '0', x"0000000000005555"),
        ("0011", "00100", "0000", "00001", '1', '0', x"0000000000005555"),
        ("1100", "00100", "0000", "00001", '1', '0', x"000000000000FFFF")
    );

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL keep_simulating : BIT := '0';
    SIGNAL clockPeriod : TIME := 10 ns;
    SIGNAL op : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Rd : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL Rm : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL Rn : STD_LOGIC_VECTOR (4 DOWNTO 0);
    SIGNAL we : STD_LOGIC;
    SIGNAL zero : STD_LOGIC;
    SIGNAL y : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
    ASSERT false REPORT "Simulation start" SEVERITY note;
    clk <= (NOT clk) AND keep_simulating AFTER clockPeriod/2;

    DUT : ULARegs PORT MAP(
        op => op,
        Rd => Rd,
        Rm => Rm,
        Rn => Rn,
        we => we,
        clk => clk,
        zero => zero,
        y => y
    );

    simulation : PROCESS IS BEGIN
        keep_simulating <= '1';
        FOR i IN tests_case'RANGE LOOP
            WAIT FOR clockPeriod;
            op <= tests_case(i).op;
            Rd <= tests_case(i).Rd;
            Rm <= tests_case(i).Rm;
            Rn <= tests_case(i).Rn;
            we <= tests_case(i).we;
            WAIT FOR clockPeriod;
            ASSERT zero = tests_case(i).zero REPORT INTEGER'IMAGE(i) & ": Zero error" SEVERITY error;
            ASSERT y = tests_case(i).y REPORT INTEGER'IMAGE(i) & ": Y error" SEVERITY error;
        END LOOP;

        keep_simulating <= '0';
        WAIT;
    END PROCESS simulation;
END ARCHITECTURE;