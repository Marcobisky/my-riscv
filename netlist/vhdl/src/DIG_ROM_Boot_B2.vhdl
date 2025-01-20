LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DIG_ROM_Boot_B2 is
  port (
    D: out std_logic_vector (7 downto 0);
    A: in std_logic_vector (23 downto 0);
    sel: in std_logic );
end DIG_ROM_Boot_B2;

architecture Behavioral of DIG_ROM_Boot_B2 is
  type mem is array ( 0 to 25) of std_logic_vector (7 downto 0);
  constant my_Rom : mem := (
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000011", 
    "10110011", "00010011", "00010011", "11000011", "00000000", "00000011", 
    "00010011", "00010000", "00100000", "00110000", "01000000", "01010000", 
    "00010000", "00100000", "00110000", "01000000", "01000000", "00000000", 
    "10001110", "00001110");
begin
  process (A, sel)
  begin
    if sel='0' then
      D <= (others => 'Z');
    elsif A > "000000000000000000011001" then
      D <= (others => '0');
    else
      D <= my_rom(to_integer(unsigned(A)));
    end if;
  end process;
end Behavioral;