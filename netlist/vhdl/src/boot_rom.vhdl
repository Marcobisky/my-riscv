LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity boot_rom is
  port (
    Addr: in std_logic_vector(23 downto 0);
    En: in std_logic;
    Out_code: out std_logic_vector(31 downto 0));
end boot_rom;

architecture Behavioral of boot_rom is
  signal s0: std_logic_vector(23 downto 0);
  signal s1: std_logic_vector(7 downto 0);
  signal s2: std_logic_vector(7 downto 0);
  signal s3: std_logic_vector(7 downto 0);
  signal s4: std_logic_vector(7 downto 0);
begin
  s0(21 downto 0) <= Addr(23 downto 2);
  s0(23 downto 22) <= "00";
  gate0: entity work.DIG_ROM_Boot_B0 -- Boot_B0
    port map (
      A => s0,
      sel => En,
      D => s1);
  gate1: entity work.DIG_ROM_Boot_B1 -- Boot_B1
    port map (
      A => s0,
      sel => En,
      D => s2);
  gate2: entity work.DIG_ROM_Boot_B2 -- Boot_B2
    port map (
      A => s0,
      sel => En,
      D => s3);
  gate3: entity work.DIG_ROM_Boot_B3 -- Boot_B3
    port map (
      A => s0,
      sel => En,
      D => s4);
  Out_code(7 downto 0) <= s1;
  Out_code(15 downto 8) <= s2;
  Out_code(23 downto 16) <= s3;
  Out_code(31 downto 24) <= s4;
end Behavioral;