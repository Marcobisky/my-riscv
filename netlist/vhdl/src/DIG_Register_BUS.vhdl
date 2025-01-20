LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DIG_Register_BUS is
  generic ( Bits: integer ); 
  port (
    Q: out std_logic_vector ((Bits-1) downto 0);
    D: in std_logic_vector ((Bits-1) downto 0);
    C: in std_logic;
    en: in std_logic );
end DIG_Register_BUS;

architecture Behavioral of DIG_Register_BUS is
  signal state : std_logic_vector ((Bits-1) downto 0) := (others => '0');
begin
   Q <= state;

   process ( C )
   begin
      if rising_edge(C) and (en='1') then
        state <= D;
      end if;
   end process;
end Behavioral;