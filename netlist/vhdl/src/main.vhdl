LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity main is
  port (
    Clock: in std_logic);
end main;

architecture Behavioral of main is
  signal s0: std_logic_vector(31 downto 0);
  signal addr_real: std_logic_vector(23 downto 0);
  signal addrflag_memtmp: std_logic;
  signal addrflag_boot: std_logic;
  signal instruction_code: std_logic_vector(31 downto 0);
  signal rd: std_logic_vector(4 downto 0);
  signal rs1: std_logic_vector(4 downto 0);
  signal rs2: std_logic_vector(4 downto 0);
  signal imm_7: std_logic_vector(6 downto 0);
  signal imm_20: std_logic_vector(19 downto 0);
  signal imm_12: std_logic_vector(11 downto 0);
  signal Invalid_op: std_logic_vector(31 downto 0);
  signal mechine_op: std_logic_vector(7 downto 0);
  signal csr_op: std_logic_vector(5 downto 0);
  signal jmp_op: std_logic_vector(8 downto 0);
  signal alu_op: std_logic_vector(18 downto 0);
  signal mem_op: std_logic_vector(8 downto 0);
  signal Cust_op: std_logic;
  signal s1: std_logic;
begin
  gate0: entity work.instruction_decoder
    port map (
      Instruction_In => instruction_code,
      EN => '1',
      rd => rd,
      rs1 => rs1,
      rs2 => rs2,
      imm_2531 => imm_7,
      imm_1231 => imm_20,
      imm_2032 => imm_12,
      invalid => Invalid_op,
      mechie_op => mechine_op,
      csr_op => csr_op,
      jmp_op => jmp_op,
      alu_op => alu_op,
      mem_op => mem_op,
      cust_op => Cust_op);
  gate1: entity work.boot_rom
    port map (
      Addr => addr_real,
      En => addrflag_boot,
      Out_code => instruction_code);
  gate2: entity work.program_counter
    port map (
      PC_inited => s1,
      En => '1',
      Clock => Clock,
      Addr_jmp => "00000000000000000000000000000000",
      En_jmp => '0',
      PC_exec => s0);
  gate3: entity work.cust_ctrl
    port map (
      op_code => instruction_code,
      cust_code => Cust_op,
      Clock => Clock,
      PC_init => s1);
  addr_real <= s0(23 downto 0);
  addrflag_memtmp <= s0(25);
  addrflag_boot <= s0(31);
end Behavioral;