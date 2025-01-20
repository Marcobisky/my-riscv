LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DIG_ROM_Boot_B3 is
  port (
    D: out std_logic_vector (7 downto 0);
    A: in std_logic_vector (23 downto 0);
    sel: in std_logic );
end DIG_ROM_Boot_B3;

architecture Behavioral of DIG_ROM_Boot_B3 is
  type mem is array ( 0 to 33) of std_logic_vector (7 downto 0);
  constant my_Rom : mem := (
    "10000000", "00110000", "01000000", "00000010", "00000010", "00000000", 
    "00000000", "00000000", "00000000", "11111111", "11000000", "00010000", 
    "00110000", "11110001", "11110001", "11110001", "11110001", "00110000", 
    "00110100", "00110100", "00110100", "00110100", "00110000", "00000000", 
    "10000000", "00110000", "00000000", "00000000", "00000000", "00000000", 
    "00000000", "00000000", "10000010", "11111000");
begin
  process (A, sel)
  begin
    if sel='0' then
      D <= (others => 'Z');
    elsif A > "000000000000000000100001" then
      D <= (others => '0');
    else
      D <= my_rom(to_integer(unsigned(A)));
    end if;
  end process;
end Behavioral;