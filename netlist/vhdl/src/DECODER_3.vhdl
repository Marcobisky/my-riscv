LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DECODER_3 is
  port (
    out_0: out std_logic;
    out_1: out std_logic;
    out_2: out std_logic;
    out_3: out std_logic;
    out_4: out std_logic;
    out_5: out std_logic;
    out_6: out std_logic;
    out_7: out std_logic;
    sel: in std_logic_vector (2 downto 0) );
end DECODER_3;

architecture Behavioral of DECODER_3 is
begin
  out_0 <= '1' when sel = "000" else '0';
  out_1 <= '1' when sel = "001" else '0';
  out_2 <= '1' when sel = "010" else '0';
  out_3 <= '1' when sel = "011" else '0';
  out_4 <= '1' when sel = "100" else '0';
  out_5 <= '1' when sel = "101" else '0';
  out_6 <= '1' when sel = "110" else '0';
  out_7 <= '1' when sel = "111" else '0';
end Behavioral;