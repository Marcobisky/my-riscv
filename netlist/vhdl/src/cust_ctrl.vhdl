LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity cust_ctrl is
  port (
    op_code: in std_logic_vector(31 downto 0);
    cust_code: in std_logic;
    Clock: in std_logic;
    PC_init: out std_logic);
end cust_ctrl;

architecture Behavioral of cust_ctrl is
  signal s0: std_logic_vector(31 downto 0);
  signal s1: std_logic_vector(11 downto 0);
  signal s2: std_logic_vector(11 downto 0);
begin
  gate0: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => op_code,
      sel => cust_code,
      p_out => s0);
  s1 <= s0(31 downto 20);
  gate1: entity work.DIG_Register_BUS
    generic map (
      Bits => 12)
    port map (
      D => s1,
      C => Clock,
      en => cust_code,
      Q => s2);
  PC_init <= s2(11);
end Behavioral;