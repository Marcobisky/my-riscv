LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY boot_rom_tb IS
END boot_rom_tb;

ARCHITECTURE behavior OF boot_rom_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT boot_rom
    PORT(
      Addr: IN std_logic_vector(23 downto 0);
      En: IN std_logic;
      Out_code: OUT std_logic_vector(31 downto 0)
    );
  END COMPONENT;

  -- Signals for the Inputs and Output
  SIGNAL Addr_tb: std_logic_vector(23 downto 0) := (others => '0');
  SIGNAL En_tb: std_logic := '0';
  SIGNAL Out_code_tb: std_logic_vector(31 downto 0);

  -- Clock Period for simulation (if needed for control)
  CONSTANT clk_period: time := 10 ns;

  -- Helper function to convert std_logic_vector to string
  FUNCTION to_string(s: std_logic_vector) RETURN string IS
    VARIABLE result: string(s'range);
  BEGIN
    -- Loop through the std_logic_vector and convert each bit to its character ('0' or '1')
    FOR i IN s'range LOOP
      IF s(i) = '0' THEN
        result(i) := '0';
      ELSE
        result(i) := '1';
      END IF;
    END LOOP;
    RETURN result;
  END FUNCTION;

BEGIN
  -- Instantiate the Unit Under Test (UUT)
  uut: boot_rom PORT MAP (
    Addr => Addr_tb,
    En => En_tb,
    Out_code => Out_code_tb
  );

  -- Stimulus process to drive inputs and observe outputs
  stim_proc: PROCESS
  BEGIN
    -- Initial values
    Addr_tb <= (others => '0');
    En_tb <= '0';
    WAIT FOR 10 ns;  -- Wait for some time before applying inputs

    -- Apply a sequence of addresses with Enable
    En_tb <= '1';  -- Enable the ROM

    -- Test Case 1: Address 0x000000
    Addr_tb <= "000000000000000000000000";  -- 0x000000
    WAIT FOR 10 ns;
    REPORT "Out_code at 0x000000: " & to_string(Out_code_tb);

    -- Test Case 2: Address 0x000004
    Addr_tb <= "000000000000000000000100";  -- 0x000004
    WAIT FOR 10 ns;
    REPORT "Out_code at 0x000004: " & to_string(Out_code_tb);

    -- Test Case 3: Address 0x000008
    Addr_tb <= "000000000000000000001000";  -- 0x000008
    WAIT FOR 10 ns;
    REPORT "Out_code at 0x000008: " & to_string(Out_code_tb);

    -- Test Case 4: Address 0x00000C
    Addr_tb <= "000000000000000000001100";  -- 0x00000C
    WAIT FOR 10 ns;
    REPORT "Out_code at 0x00000C: " & to_string(Out_code_tb);

    -- Test Case 5: Disable the ROM
    En_tb <= '0';  -- Disable the ROM
    Addr_tb <= "000000000000000000000000";  -- Reset address
    WAIT FOR 10 ns;
    REPORT "Out_code after disabling ROM: " & to_string(Out_code_tb);

    -- Finish simulation after 100ns
    WAIT FOR 10 ns;
    ASSERT FALSE REPORT "Testbench complete." SEVERITY FAILURE;
    WAIT;
  END PROCESS;

END behavior;