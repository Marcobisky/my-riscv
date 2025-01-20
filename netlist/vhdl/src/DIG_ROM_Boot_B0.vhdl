LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DIG_ROM_Boot_B0 is
  port (
    D: out std_logic_vector (7 downto 0);
    A: in std_logic_vector (23 downto 0);
    sel: in std_logic );
end DIG_ROM_Boot_B0;

architecture Behavioral of DIG_ROM_Boot_B0 is
  type mem is array ( 0 to 33) of std_logic_vector (7 downto 0);
  constant my_Rom : mem := (
    "01111111", "11110011", "00110111", "10110111", "00110111", "10000011", 
    "00100011", "00010011", "10010011", "11100011", "00110111", "00010011", 
    "11110011", "11110011", "11110011", "11110011", "11110011", "11110011", 
    "11110011", "11110011", "11110011", "11110011", "11110011", "00110111", 
    "00010011", "11110011", "10010011", "00010011", "10010011", "00010011", 
    "10010011", "10010011", "10010111", "11100111");
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