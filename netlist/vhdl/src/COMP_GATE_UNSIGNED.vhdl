LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity COMP_GATE_UNSIGNED is
  generic ( Bits : integer );
  port (
    gr: out std_logic;
    eq: out std_logic;
    le: out std_logic;
    a: in std_logic_vector ((Bits-1) downto 0);
    b: in std_logic_vector ((Bits-1) downto 0) );
end COMP_GATE_UNSIGNED;

architecture Behavioral of COMP_GATE_UNSIGNED is
begin
  process(a, b)
  begin
    if (a > b ) then
      le <= '0';
      eq <= '0';
      gr <= '1';
    elsif (a < b) then
      le <= '1';
      eq <= '0';
      gr <= '0';
    else
      le <= '0';
      eq <= '1';
      gr <= '0';
    end if;
  end process;
end Behavioral;