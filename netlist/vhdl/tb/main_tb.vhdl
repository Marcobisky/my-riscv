LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY main_tb IS
END main_tb;

ARCHITECTURE behavior OF main_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT main
    PORT(
      Clock: IN std_logic
    );
  END COMPONENT;

  -- Signals for the Clock and other signals used in the UUT
  SIGNAL Clock_tb: std_logic := '0';
  SIGNAL s0: std_logic_vector(31 downto 0) := (others => '0');
  SIGNAL addr_real: std_logic_vector(23 downto 0) := (others => '0');
  SIGNAL addrflag_memtmp: std_logic := '0';
  SIGNAL addrflag_boot: std_logic := '0';
  SIGNAL instruction_code: std_logic_vector(31 downto 0) := (others => '0');
  SIGNAL rd: std_logic_vector(4 downto 0) := "00000";
  SIGNAL rs1: std_logic_vector(4 downto 0) := "00000";
  SIGNAL rs2: std_logic_vector(4 downto 0) := "00000";
  SIGNAL imm_7: std_logic_vector(6 downto 0) := "0000000";
  SIGNAL imm_20: std_logic_vector(19 downto 0) := "00000000000000000000";
  SIGNAL imm_12: std_logic_vector(11 downto 0) := "000000000000";
  SIGNAL Invalid_op: std_logic_vector(31 downto 0) := (others => '0');
  SIGNAL mechine_op: std_logic_vector(7 downto 0) := "00000000";
  SIGNAL csr_op: std_logic_vector(5 downto 0) := "000000";
  SIGNAL jmp_op: std_logic_vector(8 downto 0) := "000000000";
  SIGNAL alu_op: std_logic_vector(18 downto 0) := "0000000000000000000";
  SIGNAL mem_op: std_logic_vector(8 downto 0) := "000000000";
  SIGNAL Cust_op: std_logic := '0';
  SIGNAL s1: std_logic := '0';

  -- Clock Period
  CONSTANT clk_period: time := 10 ns;

BEGIN
  -- Instantiate the Unit Under Test (UUT)
  uut: main PORT MAP (
    Clock => Clock_tb
  );

  -- Clock process with a loop for 100 clock cycles
  clk_process : PROCESS
  BEGIN
    FOR i IN 1 TO 100 LOOP
      -- Toggle clock signal
      Clock_tb <= '0';
      WAIT FOR clk_period / 2;
      Clock_tb <= '1';
      WAIT FOR clk_period / 2;
    END LOOP;

    -- After 100 cycles, stop the simulation
    ASSERT FALSE REPORT "Simulation completed after 100 cycles." SEVERITY FAILURE;
    WAIT;
  END PROCESS;

END behavior;