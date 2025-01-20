LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity instruction_decoder is
  port (
    Instruction_In: in std_logic_vector(31 downto 0);
    EN: in std_logic;
    rd: out std_logic_vector(4 downto 0);
    rs1: out std_logic_vector(4 downto 0);
    rs2: out std_logic_vector(4 downto 0);
    imm_2531: out std_logic_vector(6 downto 0);
    imm_1231: out std_logic_vector(19 downto 0);
    imm_2032: out std_logic_vector(11 downto 0);
    invalid: out std_logic_vector(31 downto 0);
    mechie_op: out std_logic_vector(7 downto 0);
    csr_op: out std_logic_vector(5 downto 0);
    jmp_op: out std_logic_vector(8 downto 0);
    alu_op: out std_logic_vector(18 downto 0);
    mem_op: out std_logic_vector(8 downto 0);
    cust_op: out std_logic);
end instruction_decoder;

architecture Behavioral of instruction_decoder is
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic_vector(3 downto 0);
  signal s8: std_logic_vector(31 downto 0);
  signal funct3: std_logic_vector(2 downto 0);
  signal rs1_temp: std_logic_vector(4 downto 0);
  signal rs2_temp: std_logic_vector(4 downto 0);
  signal imm_2531_temp: std_logic_vector(6 downto 0);
  signal n30: std_logic;
  signal s9: std_logic;
  signal s10: std_logic;
  signal s11: std_logic;
  signal imm_2032_temp: std_logic_vector(11 downto 0);
  signal invalid_op0: std_logic;
  signal s12: std_logic;
  signal s13: std_logic;
  signal s14: std_logic;
  signal jalr: std_logic;
  signal s15: std_logic;
  signal jal: std_logic;
  signal s16: std_logic;
  signal s17: std_logic;
  signal auipc: std_logic;
  signal lui: std_logic;
  signal s18: std_logic;
  signal s19: std_logic;
  signal ebreak: std_logic;
  signal ecall: std_logic;
  signal mret: std_logic;
  signal sfence_vma: std_logic;
  signal sret: std_logic;
  signal wfi: std_logic;
  signal fence: std_logic;
  signal fence_i: std_logic;
  signal csrrw: std_logic;
  signal csrrs: std_logic;
  signal csrrc: std_logic;
  signal csrrwi: std_logic;
  signal csrrsi: std_logic;
  signal csrrci: std_logic;
  signal beq: std_logic;
  signal bne: std_logic;
  signal blt: std_logic;
  signal bge: std_logic;
  signal bltu: std_logic;
  signal bgeu: std_logic;
  signal add: std_logic;
  signal sub: std_logic;
  signal p_sll: std_logic;
  signal slt: std_logic;
  signal sltu: std_logic;
  signal p_xor: std_logic;
  signal p_sra: std_logic;
  signal p_srl: std_logic;
  signal p_or: std_logic;
  signal p_and: std_logic;
  signal addi: std_logic;
  signal slli: std_logic;
  signal slti: std_logic;
  signal sltiu: std_logic;
  signal xori: std_logic;
  signal srli: std_logic;
  signal srai: std_logic;
  signal ori: std_logic;
  signal andi: std_logic;
  signal lb: std_logic;
  signal lh: std_logic;
  signal lw: std_logic;
  signal lbu: std_logic;
  signal lhu: std_logic;
  signal sb: std_logic;
  signal sh: std_logic;
  signal sw: std_logic;
  signal s20: std_logic;
  signal s21: std_logic;
  signal invalid_op3: std_logic;
  signal s22: std_logic;
  signal s23: std_logic;
  signal s24: std_logic;
  signal s25: std_logic;
  signal s26: std_logic;
  signal s27: std_logic;
  signal s28: std_logic;
  signal s29: std_logic;
  signal s30: std_logic;
  signal s31: std_logic;
  signal s32: std_logic;
  signal s33: std_logic;
  signal s34: std_logic;
  signal s35: std_logic;
  signal s36: std_logic;
  signal s37: std_logic;
  signal s38: std_logic;
  signal s39: std_logic;
  signal s40: std_logic;
  signal s41: std_logic;
begin
  gate0: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 32)
    port map (
      sel => EN,
      in_0 => "00000000000000000000000000000000",
      in_1 => Instruction_In,
      p_out => s8);
  gate1: entity work.COMP_GATE_UNSIGNED
    generic map (
      Bits => 32)
    port map (
      a => s8,
      b => "00010000001000000000000001110011",
      eq => sret);
  gate2: entity work.COMP_GATE_UNSIGNED
    generic map (
      Bits => 32)
    port map (
      a => s8,
      b => "00110000001000000000000001110011",
      eq => mret);
  gate3: entity work.COMP_GATE_UNSIGNED
    generic map (
      Bits => 32)
    port map (
      a => s8,
      b => "00010000010100000000000001110011",
      eq => wfi);
  s0 <= s8(0);
  s1 <= s8(1);
  s2 <= s8(2);
  s3 <= s8(3);
  s4 <= s8(4);
  s5 <= s8(5);
  s6 <= s8(6);
  rd <= s8(11 downto 7);
  funct3 <= s8(14 downto 12);
  rs1_temp <= s8(19 downto 15);
  rs2_temp <= s8(24 downto 20);
  imm_2531_temp <= s8(31 downto 25);
  gate4: entity work.DIG_LUT_LUT_inst_Decoder -- LUT_inst_Decoder
    port map (
      n0 => s0,
      n1 => s1,
      n2 => s2,
      n3 => s3,
      n4 => s4,
      n5 => s5,
      n6 => s6,
      p_out => s7);
  imm_2032_temp(4 downto 0) <= rs2_temp;
  imm_2032_temp(11 downto 5) <= imm_2531_temp;
  gate5: entity work.COMP_GATE_UNSIGNED
    generic map (
      Bits => 7)
    port map (
      a => imm_2531_temp,
      b => "0001001",
      eq => s20);
  n30 <= imm_2531_temp(5);
  s9 <= rs2_temp(0);
  s10 <= NOT (imm_2531_temp(0) OR imm_2531_temp(1) OR imm_2531_temp(2) OR imm_2531_temp(3) OR imm_2531_temp(4) OR n30 OR imm_2531_temp(6) OR rs2_temp(4) OR rs2_temp(3) OR rs2_temp(2) OR rs2_temp(1));
  imm_1231(2 downto 0) <= funct3;
  imm_1231(7 downto 3) <= rs1_temp;
  imm_1231(19 downto 8) <= imm_2032_temp;
  gate6: entity work.DECODER_4
    port map (
      sel => s7,
      out_0 => invalid_op0,
      out_1 => s12,
      out_2 => s13,
      out_3 => s14,
      out_4 => jalr,
      out_5 => s15,
      out_6 => jal,
      out_7 => s16,
      out_8 => s17,
      out_9 => auipc,
      out_10 => lui,
      out_11 => s18,
      out_15 => cust_op);
  s11 <= (s10 AND s9);
  s19 <= (s10 AND NOT s9);
  gate7: entity work.decoder_3bit
    port map (
      EN => s18,
      Din => funct3,
      n0 => fence,
      n1 => fence_i,
      n2 => s22,
      n3 => s23,
      n4 => s24,
      n5 => s25,
      n6 => s26,
      n7 => s27);
  gate8: entity work.decoder_3bit
    port map (
      EN => s17,
      Din => funct3,
      n0 => sb,
      n1 => sh,
      n2 => sw,
      n3 => s28,
      n4 => s29,
      n5 => s30,
      n6 => s31,
      n7 => s32);
  gate9: entity work.decoder_3bit
    port map (
      EN => s16,
      Din => funct3,
      n0 => s39,
      n1 => p_sll,
      n2 => slt,
      n3 => sltu,
      n4 => p_xor,
      n5 => s40,
      n6 => p_or,
      n7 => p_and);
  gate10: entity work.decoder_3bit
    port map (
      EN => s15,
      Din => funct3,
      n0 => lb,
      n1 => lh,
      n2 => lw,
      n3 => s33,
      n4 => lbu,
      n5 => lhu,
      n6 => s34,
      n7 => s35);
  gate11: entity work.decoder_3bit
    port map (
      EN => s12,
      Din => funct3,
      n0 => beq,
      n1 => bne,
      n2 => s36,
      n3 => s37,
      n4 => blt,
      n5 => bge,
      n6 => bltu,
      n7 => bgeu);
  gate12: entity work.decoder_3bit
    port map (
      EN => s13,
      Din => funct3,
      n0 => addi,
      n1 => slli,
      n2 => slti,
      n3 => sltiu,
      n4 => xori,
      n5 => s41,
      n6 => ori,
      n7 => andi);
  gate13: entity work.decoder_3bit
    port map (
      EN => s14,
      Din => funct3,
      n0 => s38,
      n1 => csrrw,
      n2 => csrrs,
      n3 => csrrc,
      n4 => invalid_op3,
      n5 => csrrwi,
      n6 => csrrsi,
      n7 => csrrci);
  csr_op(0) <= csrrw;
  csr_op(1) <= csrrs;
  csr_op(2) <= csrrc;
  csr_op(3) <= csrrwi;
  csr_op(4) <= csrrsi;
  csr_op(5) <= csrrci;
  jmp_op(0) <= jal;
  jmp_op(1) <= jalr;
  jmp_op(2) <= beq;
  jmp_op(3) <= bne;
  jmp_op(4) <= blt;
  jmp_op(5) <= bge;
  jmp_op(6) <= bltu;
  jmp_op(7) <= bgeu;
  jmp_op(8) <= auipc;
  mem_op(0) <= lui;
  mem_op(1) <= lb;
  mem_op(2) <= lh;
  mem_op(3) <= lw;
  mem_op(4) <= lbu;
  mem_op(5) <= lhu;
  mem_op(6) <= sb;
  mem_op(7) <= sh;
  mem_op(8) <= sw;
  s21 <= (EN AND (invalid_op0 OR (s36 OR s37) OR invalid_op3 OR (s33 OR s34 OR s35) OR (s28 OR s29 OR s30 OR s31 OR s32) OR (s22 OR s23 OR s24 OR s25 OR s26 OR s27)));
  gate14: entity work.MUX_GATE_1
    port map (
      sel => s38,
      in_0 => '0',
      in_1 => s11,
      p_out => ebreak);
  gate15: entity work.MUX_GATE_1
    port map (
      sel => s38,
      in_0 => '0',
      in_1 => s19,
      p_out => ecall);
  gate16: entity work.MUX_GATE_1
    port map (
      sel => s38,
      in_0 => '0',
      in_1 => s20,
      p_out => sfence_vma);
  gate17: entity work.decoder_2bit
    port map (
      EN => s39,
      Din => n30,
      n0 => add,
      n1 => sub);
  gate18: entity work.decoder_2bit
    port map (
      EN => s40,
      Din => n30,
      n0 => p_srl,
      n1 => p_sra);
  gate19: entity work.decoder_2bit
    port map (
      EN => s41,
      Din => n30,
      n0 => srli,
      n1 => srai);
  mechie_op(0) <= ebreak;
  mechie_op(1) <= ecall;
  mechie_op(2) <= mret;
  mechie_op(3) <= sfence_vma;
  mechie_op(4) <= sret;
  mechie_op(5) <= wfi;
  mechie_op(6) <= fence;
  mechie_op(7) <= fence_i;
  alu_op(0) <= add;
  alu_op(1) <= sub;
  alu_op(2) <= p_sll;
  alu_op(3) <= slt;
  alu_op(4) <= sltu;
  alu_op(5) <= p_xor;
  alu_op(6) <= p_sra;
  alu_op(7) <= p_srl;
  alu_op(8) <= p_or;
  alu_op(9) <= p_and;
  alu_op(10) <= addi;
  alu_op(11) <= slli;
  alu_op(12) <= slti;
  alu_op(13) <= sltiu;
  alu_op(14) <= xori;
  alu_op(15) <= srli;
  alu_op(16) <= srai;
  alu_op(17) <= ori;
  alu_op(18) <= andi;
  gate20: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => "00000000000000000000000000000010",
      sel => s21,
      p_out => invalid);
  rs1 <= rs1_temp;
  rs2 <= rs2_temp;
  imm_2531 <= imm_2531_temp;
  imm_2032 <= imm_2032_temp;
end Behavioral;