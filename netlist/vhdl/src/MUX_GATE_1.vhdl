LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_1 is
  port (
    p_out: out std_logic;
    sel: in std_logic;
    
    in_0: in std_logic;
    in_1: in std_logic );
end MUX_GATE_1;

architecture Behavioral of MUX_GATE_1 is
begin
  with sel select
    p_out <=
      in_0 when '0',
      in_1 when '1',
      '0' when others;
end Behavioral;