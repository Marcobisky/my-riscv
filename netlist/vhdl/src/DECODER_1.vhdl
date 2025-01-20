LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DECODER_1 is
  port (
    out_0: out std_logic;
    out_1: out std_logic;
    sel: in std_logic );
end DECODER_1;

architecture Behavioral of DECODER_1 is
begin
  out_0 <= '1' when sel = '0' else '0';
  out_1 <= '1' when sel = '1' else '0';
end Behavioral;