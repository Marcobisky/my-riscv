LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity program_counter_tb is
end program_counter_tb;

architecture behavior of program_counter_tb is
    -- Component Declaration
    component program_counter
        port (
            PC_inited: in std_logic;
            En: in std_logic;
            Clock: in std_logic;
            Addr_jmp: in std_logic_vector(31 downto 0);
            En_jmp: in std_logic;
            PC_next: out std_logic_vector(31 downto 0);
            PC_exec: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Input Signals
    signal PC_inited : std_logic := '0';
    signal En : std_logic := '0';
    signal Clock : std_logic := '0';
    signal Addr_jmp : std_logic_vector(31 downto 0) := (others => '0');
    signal En_jmp : std_logic := '0';

    -- Output Signals
    signal PC_next : std_logic_vector(31 downto 0) := (others => '0');
    signal PC_exec : std_logic_vector(31 downto 0) := (others => '0');

    -- Clock period definition
    constant CLOCK_PERIOD : time := 10 ns;
    
    -- Signal to control clock process
    signal done : boolean := false;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: program_counter port map (
        PC_inited => PC_inited,
        En => En,
        Clock => Clock,
        Addr_jmp => Addr_jmp,
        En_jmp => En_jmp,
        PC_next => PC_next,
        PC_exec => PC_exec
    );

    -- Clock process with finite number of cycles
    clock_process: process
    begin
        while not done loop
            Clock <= '0';
            wait for CLOCK_PERIOD/2;
            Clock <= '1';
            wait for CLOCK_PERIOD/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize inputs
        PC_inited <= '0';
        En <= '1';
        En_jmp <= '0';
        Addr_jmp <= (others => '0');
        wait for CLOCK_PERIOD;

        -- Test 1: Initial state
        PC_inited <= '0';
        wait for CLOCK_PERIOD;
        assert PC_next = x"80000004" 
            report "Test 1 Failed: Incorrect initial PC_next value"
            severity error;
        assert PC_exec = x"80000000"
            report "Test 1 Failed: Incorrect initial PC_exec value"
            severity error;

        -- Test 2: Enable normal operation
        wait for 2 ns;
        PC_inited <= '1';
        wait for CLOCK_PERIOD;
        assert PC_next = x"80000004"
            report "Test 2 Failed: Incorrect PC_next value during normal operation"
            severity error;
        assert PC_exec = x"80000004"
            report "Test 2 Failed: Incorrect PC_exec value during normal operation"
            severity error;

        -- Test 3: Test jump operation
        Addr_jmp <= x"80000020";
        En_jmp <= '1';
        wait for CLOCK_PERIOD;
        assert PC_next = x"80000020"
            report "Test 3 Failed: Jump address not properly loaded"
            severity error;

        -- Test 4: Continue normal operation after jump
        En_jmp <= '0';
        wait for CLOCK_PERIOD;
        assert PC_next = x"80000024"
            report "Test 4 Failed: Incorrect PC_next value after jump"
            severity error;

        -- Test 5: Disable enable
        En <= '1';
        wait for CLOCK_PERIOD;
        -- PC should maintain its value when disabled
        wait for CLOCK_PERIOD;

        -- End simulation
        report "Simulation completed successfully";
        done <= true;  -- Stop the clock process
        wait;
    end process;

end behavior;