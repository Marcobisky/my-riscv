LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity decoder_2bit is
  port (
    EN: in std_logic;
    Din: in std_logic;
    n0: out std_logic;
    n1: out std_logic);
end decoder_2bit;

architecture Behavioral of decoder_2bit is
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic_vector(1 downto 0);
  signal s3: std_logic_vector(1 downto 0);
begin
  gate0: entity work.DECODER_1
    port map (
      sel => Din,
      out_0 => s0,
      out_1 => s1);
  s2(0) <= s0;
  s2(1) <= s1;
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 2)
    port map (
      sel => EN,
      in_0 => "00",
      in_1 => s2,
      p_out => s3);
  n0 <= s3(0);
  n1 <= s3(1);
end Behavioral;