LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity DIG_Add is
  generic ( Bits: integer ); 
  port (
    s: out std_logic_vector((Bits-1) downto 0);
    c_o: out std_logic;
    a: in std_logic_vector((Bits-1) downto 0);
    b: in std_logic_vector((Bits-1) downto 0);
    c_i: in std_logic );
end DIG_Add;

architecture Behavioral of DIG_Add is
   signal temp : std_logic_vector(Bits downto 0);
begin
   temp <= ('0' & a) + b + c_i;

   s    <= temp((Bits-1) downto 0);
   c_o  <= temp(Bits);
end Behavioral;