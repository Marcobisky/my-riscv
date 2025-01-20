LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity decoder_3bit is
  port (
    EN: in std_logic;
    Din: in std_logic_vector(2 downto 0);
    n0: out std_logic;
    n1: out std_logic;
    n2: out std_logic;
    n3: out std_logic;
    n4: out std_logic;
    n5: out std_logic;
    n6: out std_logic;
    n7: out std_logic);
end decoder_3bit;

architecture Behavioral of decoder_3bit is
  signal s0: std_logic_vector(7 downto 0);
  signal s1: std_logic_vector(7 downto 0);
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
  signal s8: std_logic;
  signal s9: std_logic;
begin
  gate0: entity work.DECODER_3
    port map (
      sel => Din,
      out_0 => s2,
      out_1 => s3,
      out_2 => s4,
      out_3 => s5,
      out_4 => s6,
      out_5 => s7,
      out_6 => s8,
      out_7 => s9);
  s0(0) <= s2;
  s0(1) <= s3;
  s0(2) <= s4;
  s0(3) <= s5;
  s0(4) <= s6;
  s0(5) <= s7;
  s0(6) <= s8;
  s0(7) <= s9;
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 8)
    port map (
      sel => EN,
      in_0 => "00000000",
      in_1 => s0,
      p_out => s1);
  n0 <= s1(0);
  n1 <= s1(1);
  n2 <= s1(2);
  n3 <= s1(3);
  n4 <= s1(4);
  n5 <= s1(5);
  n6 <= s1(6);
  n7 <= s1(7);
end Behavioral;