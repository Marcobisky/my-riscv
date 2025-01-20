LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity program_counter is
  port (
    PC_inited: in std_logic;
    En: in std_logic;
    Clock: in std_logic;
    Addr_jmp: in std_logic_vector(31 downto 0);
    En_jmp: in std_logic;
    PC_next: out std_logic_vector(31 downto 0);
    PC_exec: out std_logic_vector(31 downto 0));
end program_counter;

architecture Behavioral of program_counter is
  signal s0: std_logic_vector(31 downto 0);
  signal s1: std_logic_vector(31 downto 0);
  signal PC_next_temp: std_logic_vector(31 downto 0);
  signal s2: std_logic;
  signal s3: std_logic_vector(31 downto 0);
  signal s4: std_logic_vector(31 downto 0);
  signal s5: std_logic_vector(31 downto 0);
  signal s6: std_logic_vector(31 downto 0);
  signal PC_exec_temp: std_logic_vector(31 downto 0);
begin
  s2 <= (En AND En_jmp);
  gate0: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => "10000000000000000000000000000100",
      sel => PC_inited,
      p_out => PC_next_temp);
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 32)
    port map (
      sel => s2,
      in_0 => s1,
      in_1 => Addr_jmp,
      p_out => s3);
  gate2: entity work.DIG_Register_BUS -- PC_reg
    generic map (
      Bits => 32)
    port map (
      D => s4,
      C => Clock,
      en => En,
      Q => s5);
  gate3: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => s5,
      sel => PC_inited,
      p_out => s6);
  gate4: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 32)
    port map (
      sel => PC_inited,
      in_0 => "10000000000000000000000000000000",
      in_1 => PC_exec_temp,
      p_out => s0);
  gate5: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 32)
    port map (
      sel => PC_inited,
      in_0 => "10000000000000000000000000000000",
      in_1 => s6,
      p_out => PC_exec_temp);
  gate6: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 32)
    port map (
      sel => PC_inited,
      in_0 => PC_next_temp,
      in_1 => s3,
      p_out => s4);
  gate7: entity work.DIG_Add
    generic map (
      Bits => 32)
    port map (
      a => s0,
      b => "00000000000000000000000000000100",
      c_i => '0',
      s => s1);
  PC_next <= PC_next_temp;
  PC_exec <= PC_exec_temp;
end Behavioral;