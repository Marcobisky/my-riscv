LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DECODER_4 is
  port (
    out_0: out std_logic;
    out_1: out std_logic;
    out_2: out std_logic;
    out_3: out std_logic;
    out_4: out std_logic;
    out_5: out std_logic;
    out_6: out std_logic;
    out_7: out std_logic;
    out_8: out std_logic;
    out_9: out std_logic;
    out_10: out std_logic;
    out_11: out std_logic;
    out_12: out std_logic;
    out_13: out std_logic;
    out_14: out std_logic;
    out_15: out std_logic;
    sel: in std_logic_vector (3 downto 0) );
end DECODER_4;

architecture Behavioral of DECODER_4 is
begin
  out_0 <= '1' when sel = "0000" else '0';
  out_1 <= '1' when sel = "0001" else '0';
  out_2 <= '1' when sel = "0010" else '0';
  out_3 <= '1' when sel = "0011" else '0';
  out_4 <= '1' when sel = "0100" else '0';
  out_5 <= '1' when sel = "0101" else '0';
  out_6 <= '1' when sel = "0110" else '0';
  out_7 <= '1' when sel = "0111" else '0';
  out_8 <= '1' when sel = "1000" else '0';
  out_9 <= '1' when sel = "1001" else '0';
  out_10 <= '1' when sel = "1010" else '0';
  out_11 <= '1' when sel = "1011" else '0';
  out_12 <= '1' when sel = "1100" else '0';
  out_13 <= '1' when sel = "1101" else '0';
  out_14 <= '1' when sel = "1110" else '0';
  out_15 <= '1' when sel = "1111" else '0';
end Behavioral;