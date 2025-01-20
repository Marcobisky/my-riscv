LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY instruction_decoder_tb IS
END instruction_decoder_tb;

ARCHITECTURE behavior OF instruction_decoder_tb IS

  -- COMPONENT declaration for the Unit Under Test (UUT)
  COMPONENT instruction_decoder
    PORT(
      Instruction_In : IN std_logic_vector(31 downto 0);
      EN : IN std_logic;
      rd : OUT std_logic_vector(4 downto 0);
      rs1 : OUT std_logic_vector(4 downto 0);
      rs2 : OUT std_logic_vector(4 downto 0);
      imm_2531 : OUT std_logic_vector(6 downto 0);
      imm_1231 : OUT std_logic_vector(19 downto 0);
      imm_2032 : OUT std_logic_vector(11 downto 0);
      invalid : OUT std_logic_vector(31 downto 0);
      mechie_op : OUT std_logic_vector(7 downto 0);
      csr_op : OUT std_logic_vector(5 downto 0);
      jmp_op : OUT std_logic_vector(8 downto 0);
      alu_op : OUT std_logic_vector(18 downto 0);
      mem_op : OUT std_logic_vector(8 downto 0);
      cust_op : OUT std_logic
    );
  END COMPONENT;

  -- Signals for driving inputs and capturing outputs
  SIGNAL Instruction_In_tb : std_logic_vector(31 downto 0);
  SIGNAL EN_tb : std_logic;
  SIGNAL rd_tb : std_logic_vector(4 downto 0);
  SIGNAL rs1_tb : std_logic_vector(4 downto 0);
  SIGNAL rs2_tb : std_logic_vector(4 downto 0);
  SIGNAL imm_2531_tb : std_logic_vector(6 downto 0);
  SIGNAL imm_1231_tb : std_logic_vector(19 downto 0);
  SIGNAL imm_2032_tb : std_logic_vector(11 downto 0);
  SIGNAL invalid_tb : std_logic_vector(31 downto 0);
  SIGNAL mechie_op_tb : std_logic_vector(7 downto 0);
  SIGNAL csr_op_tb : std_logic_vector(5 downto 0);
  SIGNAL jmp_op_tb : std_logic_vector(8 downto 0);
  SIGNAL alu_op_tb : std_logic_vector(18 downto 0);
  SIGNAL mem_op_tb : std_logic_vector(8 downto 0);
  SIGNAL cust_op_tb : std_logic;

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
  uut: instruction_decoder
    PORT MAP(
      Instruction_In => Instruction_In_tb,
      EN => EN_tb,
      rd => rd_tb,
      rs1 => rs1_tb,
      rs2 => rs2_tb,
      imm_2531 => imm_2531_tb,
      imm_1231 => imm_1231_tb,
      imm_2032 => imm_2032_tb,
      invalid => invalid_tb,
      mechie_op => mechie_op_tb,
      csr_op => csr_op_tb,
      jmp_op => jmp_op_tb,
      alu_op => alu_op_tb,
      mem_op => mem_op_tb,
      cust_op => cust_op_tb
    );

  -- Stimulus process to drive inputs
  stim_proc: PROCESS
  BEGIN
    -- Initialize all inputs
    Instruction_In_tb <= (others => '0');
    EN_tb <= '0';
    WAIT FOR 10 ns; -- Wait for some time to apply inputs

    -- Test Case 1: Apply a valid instruction with EN = '1'
    Instruction_In_tb <= "00000000000000000000000000000000"; -- Instruction 1
    EN_tb <= '1';
    WAIT FOR 10 ns;
    REPORT "Test Case 1: " & "rd = " & to_string(rd_tb) & " rs1 = " & to_string(rs1_tb) &
           " rs2 = " & to_string(rs2_tb) & " imm_2531 = " & to_string(imm_2531_tb) &
           " imm_1231 = " & to_string(imm_1231_tb) & " imm_2032 = " & to_string(imm_2032_tb) &
           " invalid = " & to_string(invalid_tb);

    -- Test Case 2: Apply another valid instruction with EN = '1'
    Instruction_In_tb <= "00010000001000000000000001110011"; -- Instruction 2
    WAIT FOR 10 ns;
    REPORT "Test Case 2: " & "rd = " & to_string(rd_tb) & " rs1 = " & to_string(rs1_tb) &
           " rs2 = " & to_string(rs2_tb) & " imm_2531 = " & to_string(imm_2531_tb) &
           " imm_1231 = " & to_string(imm_1231_tb) & " imm_2032 = " & to_string(imm_2032_tb) &
           " invalid = " & to_string(invalid_tb);

    -- Test Case 3: Apply invalid instruction with EN = '1'
    Instruction_In_tb <= "11110000000000000000000000000000"; -- Invalid instruction
    WAIT FOR 10 ns;
    REPORT "Test Case 3: " & "rd = " & to_string(rd_tb) & " rs1 = " & to_string(rs1_tb) &
           " rs2 = " & to_string(rs2_tb) & " imm_2531 = " & to_string(imm_2531_tb) &
           " imm_1231 = " & to_string(imm_1231_tb) & " imm_2032 = " & to_string(imm_2032_tb) &
           " invalid = " & to_string(invalid_tb);

    -- Test Case 4: Disable the instruction decoder (EN = '0')
    EN_tb <= '0';
    Instruction_In_tb <= "00000000000000000000000000000000"; -- Instruction (won't be decoded)
    WAIT FOR 10 ns;
    REPORT "Test Case 4: " & "rd = " & to_string(rd_tb) & " rs1 = " & to_string(rs1_tb) &
           " rs2 = " & to_string(rs2_tb) & " imm_2531 = " & to_string(imm_2531_tb) &
           " imm_1231 = " & to_string(imm_1231_tb) & " imm_2032 = " & to_string(imm_2032_tb) &
           " invalid = " & to_string(invalid_tb);

    -- Finish simulation after running all test cases
    WAIT FOR 10 ns;
    ASSERT FALSE REPORT "Testbench complete." SEVERITY FAILURE;
    WAIT;
  END PROCESS;

END behavior;