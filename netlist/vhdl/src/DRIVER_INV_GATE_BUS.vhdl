LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DRIVER_INV_GATE_BUS is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    p_in: in std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic );
end DRIVER_INV_GATE_BUS;

architecture Behavioral of DRIVER_INV_GATE_BUS is
begin
  p_out <= p_in when sel = '0' else (others => 'Z');
end Behavioral;