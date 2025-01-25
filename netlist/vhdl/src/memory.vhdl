-- generated by Digital. Don't modify this file!
-- Any changes will be lost if this file is regenerated.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_2 is
  port (
    p_out: out std_logic;
    sel: in std_logic_vector (1 downto 0);
    
    in_0: in std_logic;
    in_1: in std_logic;
    in_2: in std_logic;
    in_3: in std_logic );
end MUX_GATE_2;

architecture Behavioral of MUX_GATE_2 is
begin
  with sel select
    p_out <=
      in_0 when "00",
      in_1 when "01",
      in_2 when "10",
      in_3 when "11",
      '0' when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_BUS_3 is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic_vector (2 downto 0);
    
    in_0: in std_logic_vector ((Bits-1) downto 0);
    in_1: in std_logic_vector ((Bits-1) downto 0);
    in_2: in std_logic_vector ((Bits-1) downto 0);
    in_3: in std_logic_vector ((Bits-1) downto 0);
    in_4: in std_logic_vector ((Bits-1) downto 0);
    in_5: in std_logic_vector ((Bits-1) downto 0);
    in_6: in std_logic_vector ((Bits-1) downto 0);
    in_7: in std_logic_vector ((Bits-1) downto 0) );
end MUX_GATE_BUS_3;

architecture Behavioral of MUX_GATE_BUS_3 is
begin
  with sel select
    p_out <=
      in_0 when "000",
      in_1 when "001",
      in_2 when "010",
      in_3 when "011",
      in_4 when "100",
      in_5 when "101",
      in_6 when "110",
      in_7 when "111",
      (others => '0') when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity barrel_shifter1 is
  port (
    shift: in std_logic_vector(1 downto 0);
    in4: in std_logic_vector(3 downto 0);
    Direction: in std_logic; -- left (0) or right (1)
    mode: in std_logic_vector(1 downto 0); -- 00 -> rotate
                                           -- 01 -> logical
                                           -- 10 -> arithmic
    out4: out std_logic_vector(3 downto 0));
end barrel_shifter1;

architecture Behavioral of barrel_shifter1 is
  signal in0: std_logic;
  signal s0: std_logic;
  signal in2: std_logic;
  signal in1: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal out_rotate_left: std_logic_vector(3 downto 0);
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
  signal s8: std_logic;
  signal s9: std_logic;
  signal s10: std_logic;
  signal s11: std_logic;
  signal s12: std_logic;
  signal s13: std_logic;
  signal s14: std_logic;
  signal s15: std_logic;
  signal s16: std_logic;
  signal s17: std_logic;
  signal s18: std_logic;
  signal s19: std_logic;
  signal s20: std_logic;
  signal out_rotate_right: std_logic_vector(3 downto 0);
  signal s21: std_logic_vector(3 downto 0);
  signal out_logic_right: std_logic_vector(3 downto 0);
  signal out_ari_right: std_logic_vector(3 downto 0);
  signal s22: std_logic_vector(2 downto 0);
begin
  s22(0) <= Direction;
  s22(2 downto 1) <= mode;
  in0 <= in4(0);
  in1 <= in4(1);
  in2 <= in4(2);
  s0 <= in4(3);
  gate0: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in0,
      in_1 => s0,
      in_2 => in2,
      in_3 => in1,
      p_out => s1);
  gate1: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in1,
      in_1 => in0,
      in_2 => s0,
      in_3 => in2,
      p_out => s2);
  gate2: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in2,
      in_1 => in1,
      in_2 => in0,
      in_3 => s0,
      p_out => s3);
  gate3: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => s0,
      in_1 => in2,
      in_2 => in1,
      in_3 => in0,
      p_out => s4);
  gate4: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in0,
      in_1 => in1,
      in_2 => in2,
      in_3 => s0,
      p_out => s5);
  gate5: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in1,
      in_1 => in2,
      in_2 => s0,
      in_3 => in0,
      p_out => s6);
  gate6: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in2,
      in_1 => s0,
      in_2 => in0,
      in_3 => in1,
      p_out => s7);
  gate7: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => s0,
      in_1 => in0,
      in_2 => in1,
      in_3 => in2,
      p_out => s8);
  gate8: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in0,
      in_1 => '0',
      in_2 => '0',
      in_3 => '0',
      p_out => s9);
  gate9: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in1,
      in_1 => in0,
      in_2 => '0',
      in_3 => '0',
      p_out => s10);
  gate10: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in2,
      in_1 => in1,
      in_2 => in0,
      in_3 => '0',
      p_out => s11);
  gate11: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => s0,
      in_1 => in2,
      in_2 => in1,
      in_3 => in0,
      p_out => s12);
  gate12: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in0,
      in_1 => in1,
      in_2 => in2,
      in_3 => s0,
      p_out => s13);
  gate13: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in1,
      in_1 => in2,
      in_2 => s0,
      in_3 => '0',
      p_out => s14);
  gate14: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in2,
      in_1 => s0,
      in_2 => '0',
      in_3 => '0',
      p_out => s15);
  gate15: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => s0,
      in_1 => '0',
      in_2 => '0',
      in_3 => '0',
      p_out => s16);
  gate16: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in0,
      in_1 => in1,
      in_2 => in2,
      in_3 => s0,
      p_out => s17);
  gate17: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in1,
      in_1 => in2,
      in_2 => s0,
      in_3 => s0,
      p_out => s18);
  gate18: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => in2,
      in_1 => s0,
      in_2 => s0,
      in_3 => s0,
      p_out => s19);
  gate19: entity work.MUX_GATE_2
    port map (
      sel => shift,
      in_0 => s0,
      in_1 => s0,
      in_2 => s0,
      in_3 => s0,
      p_out => s20);
  out_rotate_left(0) <= s1;
  out_rotate_left(1) <= s2;
  out_rotate_left(2) <= s3;
  out_rotate_left(3) <= s4;
  out_rotate_right(0) <= s5;
  out_rotate_right(1) <= s6;
  out_rotate_right(2) <= s7;
  out_rotate_right(3) <= s8;
  s21(0) <= s9;
  s21(1) <= s10;
  s21(2) <= s11;
  s21(3) <= s12;
  out_logic_right(0) <= s13;
  out_logic_right(1) <= s14;
  out_logic_right(2) <= s15;
  out_logic_right(3) <= s16;
  out_ari_right(0) <= s17;
  out_ari_right(1) <= s18;
  out_ari_right(2) <= s19;
  out_ari_right(3) <= s20;
  gate20: entity work.MUX_GATE_BUS_3
    generic map (
      Bits => 4)
    port map (
      sel => s22,
      in_0 => out_rotate_left,
      in_1 => out_rotate_right,
      in_2 => s21,
      in_3 => out_logic_right,
      in_4 => s21,
      in_5 => out_ari_right,
      in_6 => "0000",
      in_7 => "0000",
      p_out => out4);
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_BUS_2 is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic_vector (1 downto 0);
    
    in_0: in std_logic_vector ((Bits-1) downto 0);
    in_1: in std_logic_vector ((Bits-1) downto 0);
    in_2: in std_logic_vector ((Bits-1) downto 0);
    in_3: in std_logic_vector ((Bits-1) downto 0) );
end MUX_GATE_BUS_2;

architecture Behavioral of MUX_GATE_BUS_2 is
begin
  with sel select
    p_out <=
      in_0 when "00",
      in_1 when "01",
      in_2 when "10",
      in_3 when "11",
      (others => '0') when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity DIG_BitExtenderSingle is
  generic ( outputBits : integer); 
  port (
    p_in: in std_logic;
    p_out: out std_logic_vector ((outputBits-1) downto 0) );
end DIG_BitExtenderSingle;

architecture Behavioral of DIG_BitExtenderSingle is
begin
    p_out((outputBits-1) downto 0) <= (others => p_in);
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity barrel_shifter8 is
  port (
    shift_byte: in std_logic_vector(1 downto 0);
    in32: in std_logic_vector(31 downto 0);
    Direction: in std_logic; -- left (0) or right (1)
    mode: in std_logic_vector(1 downto 0); -- 00 -> rotate
                                           -- 01 -> logical
                                           -- 10 -> arithmic
    out32: out std_logic_vector(31 downto 0));
end barrel_shifter8;

architecture Behavioral of barrel_shifter8 is
  signal inbyte0: std_logic_vector(7 downto 0);
  signal inbyte3: std_logic_vector(7 downto 0);
  signal inbyte2: std_logic_vector(7 downto 0);
  signal inbyte1: std_logic_vector(7 downto 0);
  signal s0: std_logic_vector(7 downto 0);
  signal s1: std_logic_vector(7 downto 0);
  signal s2: std_logic_vector(7 downto 0);
  signal s3: std_logic_vector(7 downto 0);
  signal out_rotate_left: std_logic_vector(31 downto 0);
  signal s4: std_logic_vector(7 downto 0);
  signal s5: std_logic_vector(7 downto 0);
  signal s6: std_logic_vector(7 downto 0);
  signal s7: std_logic_vector(7 downto 0);
  signal s8: std_logic_vector(7 downto 0);
  signal s9: std_logic_vector(7 downto 0);
  signal s10: std_logic_vector(7 downto 0);
  signal s11: std_logic_vector(7 downto 0);
  signal s12: std_logic_vector(7 downto 0);
  signal s13: std_logic_vector(7 downto 0);
  signal s14: std_logic_vector(7 downto 0);
  signal s15: std_logic_vector(7 downto 0);
  signal s16: std_logic_vector(7 downto 0);
  signal sign_byte: std_logic_vector(7 downto 0);
  signal s17: std_logic_vector(7 downto 0);
  signal s18: std_logic_vector(7 downto 0);
  signal s19: std_logic_vector(7 downto 0);
  signal s20: std_logic;
  signal out_rotate_right: std_logic_vector(31 downto 0);
  signal s21: std_logic_vector(31 downto 0);
  signal out_logic_right: std_logic_vector(31 downto 0);
  signal out_ari_right: std_logic_vector(31 downto 0);
  signal s22: std_logic_vector(2 downto 0);
begin
  s22(0) <= Direction;
  s22(2 downto 1) <= mode;
  inbyte0 <= in32(7 downto 0);
  inbyte1 <= in32(15 downto 8);
  inbyte2 <= in32(23 downto 16);
  inbyte3 <= in32(31 downto 24);
  gate0: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte0,
      in_1 => inbyte3,
      in_2 => inbyte2,
      in_3 => inbyte1,
      p_out => s0);
  gate1: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte1,
      in_1 => inbyte0,
      in_2 => inbyte3,
      in_3 => inbyte2,
      p_out => s1);
  gate2: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte2,
      in_1 => inbyte1,
      in_2 => inbyte0,
      in_3 => inbyte3,
      p_out => s2);
  gate3: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte3,
      in_1 => inbyte2,
      in_2 => inbyte1,
      in_3 => inbyte0,
      p_out => s3);
  gate4: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte0,
      in_1 => inbyte1,
      in_2 => inbyte2,
      in_3 => inbyte3,
      p_out => s4);
  gate5: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte1,
      in_1 => inbyte2,
      in_2 => inbyte3,
      in_3 => inbyte0,
      p_out => s5);
  gate6: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte2,
      in_1 => inbyte3,
      in_2 => inbyte0,
      in_3 => inbyte1,
      p_out => s6);
  gate7: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte3,
      in_1 => inbyte0,
      in_2 => inbyte1,
      in_3 => inbyte2,
      p_out => s7);
  gate8: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte0,
      in_1 => "00000000",
      in_2 => "00000000",
      in_3 => "00000000",
      p_out => s8);
  gate9: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte1,
      in_1 => inbyte0,
      in_2 => "00000000",
      in_3 => "00000000",
      p_out => s9);
  gate10: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte2,
      in_1 => inbyte1,
      in_2 => inbyte0,
      in_3 => "00000000",
      p_out => s10);
  gate11: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte3,
      in_1 => inbyte2,
      in_2 => inbyte1,
      in_3 => inbyte0,
      p_out => s11);
  gate12: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte0,
      in_1 => inbyte1,
      in_2 => inbyte2,
      in_3 => inbyte3,
      p_out => s12);
  gate13: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte1,
      in_1 => inbyte2,
      in_2 => inbyte3,
      in_3 => "00000000",
      p_out => s13);
  gate14: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte2,
      in_1 => inbyte3,
      in_2 => "00000000",
      in_3 => "00000000",
      p_out => s14);
  gate15: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte3,
      in_1 => "00000000",
      in_2 => "00000000",
      in_3 => "00000000",
      p_out => s15);
  gate16: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte0,
      in_1 => inbyte1,
      in_2 => inbyte2,
      in_3 => inbyte3,
      p_out => s16);
  s20 <= inbyte3(7);
  out_rotate_left(7 downto 0) <= s0;
  out_rotate_left(15 downto 8) <= s1;
  out_rotate_left(23 downto 16) <= s2;
  out_rotate_left(31 downto 24) <= s3;
  gate17: entity work.DIG_BitExtenderSingle
    generic map (
      outputBits => 8)
    port map (
      p_in => s20,
      p_out => sign_byte);
  out_rotate_right(7 downto 0) <= s4;
  out_rotate_right(15 downto 8) <= s5;
  out_rotate_right(23 downto 16) <= s6;
  out_rotate_right(31 downto 24) <= s7;
  s21(7 downto 0) <= s8;
  s21(15 downto 8) <= s9;
  s21(23 downto 16) <= s10;
  s21(31 downto 24) <= s11;
  out_logic_right(7 downto 0) <= s12;
  out_logic_right(15 downto 8) <= s13;
  out_logic_right(23 downto 16) <= s14;
  out_logic_right(31 downto 24) <= s15;
  gate18: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte1,
      in_1 => inbyte2,
      in_2 => inbyte3,
      in_3 => sign_byte,
      p_out => s17);
  gate19: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte2,
      in_1 => inbyte3,
      in_2 => sign_byte,
      in_3 => sign_byte,
      p_out => s18);
  gate20: entity work.MUX_GATE_BUS_2
    generic map (
      Bits => 8)
    port map (
      sel => shift_byte,
      in_0 => inbyte3,
      in_1 => sign_byte,
      in_2 => sign_byte,
      in_3 => sign_byte,
      p_out => s19);
  out_ari_right(7 downto 0) <= s16;
  out_ari_right(15 downto 8) <= s17;
  out_ari_right(23 downto 16) <= s18;
  out_ari_right(31 downto 24) <= s19;
  gate21: entity work.MUX_GATE_BUS_3
    generic map (
      Bits => 32)
    port map (
      sel => s22,
      in_0 => out_rotate_left,
      in_1 => out_rotate_right,
      in_2 => s21,
      in_3 => out_logic_right,
      in_4 => s21,
      in_5 => out_ari_right,
      in_6 => "00000000000000000000000000000000",
      in_7 => "00000000000000000000000000000000",
      p_out => out32);
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_BUS_1 is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic;
    
    in_0: in std_logic_vector ((Bits-1) downto 0);
    in_1: in std_logic_vector ((Bits-1) downto 0) );
end MUX_GATE_BUS_1;

architecture Behavioral of MUX_GATE_BUS_1 is
begin
  with sel select
    p_out <=
      in_0 when '0',
      in_1 when '1',
      (others => '0') when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity DIG_RAMDualAccess is
  generic (
    Bits : integer;       
    AddrBits : integer ); 
  port (
    n1D: out std_logic_vector ((Bits-1) downto 0);
    n2D: out std_logic_vector ((Bits-1) downto 0);
    str: in std_logic;
    C: in std_logic;
    ld: in std_logic;
    n1A: in std_logic_vector ((AddrBits-1) downto 0);
    n1Din: in std_logic_vector ((Bits-1) downto 0);
    n2A: in std_logic_vector ((AddrBits-1) downto 0) );
end DIG_RAMDualAccess;

architecture Behavioral of DIG_RAMDualAccess is
    -- CAUTION: uses distributed RAM
    type memoryType is array(0 to (2**AddrBits)-1) of STD_LOGIC_VECTOR((Bits-1) downto 0);
    signal memory : memoryType;
begin
  process ( C )
  begin
    if rising_edge(C) AND (str='1') then
      memory(to_integer(unsigned(n1A))) <= n1Din;
    end if;
  end process;
  n1D <= memory(to_integer(unsigned(n1A))) when ld='1' else (others => 'Z');
  n2D <= memory(to_integer(unsigned(n2A)));
end Behavioral;


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
  p_out <= p_in when sel = '1' else (others => 'Z');
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity main is
  port (
    OE_PC: in std_logic;
    Addr_PC: in std_logic_vector(31 downto 0);
    OE: in std_logic;
    WE: in std_logic;
    Addr: in std_logic_vector(31 downto 0);
    Data_in: in std_logic_vector(31 downto 0);
    ByteSize_in: in std_logic_vector(3 downto 0);
    Clock: in std_logic;
    DataPC_out: out std_logic_vector(31 downto 0);
    Data_out: out std_logic_vector(31 downto 0));
end main;

architecture Behavioral of main is
  signal shift: std_logic_vector(1 downto 0);
  signal s0: std_logic_vector(23 downto 0);
  signal shift_PC: std_logic_vector(1 downto 0);
  signal s1: std_logic_vector(23 downto 0);
  signal we0: std_logic;
  signal s2: std_logic_vector(7 downto 0);
  signal s3: std_logic_vector(7 downto 0);
  signal s4: std_logic_vector(7 downto 0);
  signal we1: std_logic;
  signal s5: std_logic_vector(7 downto 0);
  signal s6: std_logic_vector(7 downto 0);
  signal s7: std_logic_vector(7 downto 0);
  signal we2: std_logic;
  signal s8: std_logic_vector(7 downto 0);
  signal s9: std_logic_vector(7 downto 0);
  signal s10: std_logic_vector(7 downto 0);
  signal we3: std_logic;
  signal s11: std_logic_vector(7 downto 0);
  signal s12: std_logic_vector(7 downto 0);
  signal s13: std_logic_vector(7 downto 0);
  signal s14: std_logic_vector(31 downto 0);
  signal s15: std_logic_vector(3 downto 0);
  signal s16: std_logic_vector(3 downto 0);
  signal s17: std_logic_vector(31 downto 0);
  signal s18: std_logic_vector(31 downto 0);
  signal s19: std_logic_vector(31 downto 0);
  signal s20: std_logic_vector(31 downto 0);
begin
  shift <= Addr(1 downto 0);
  s0 <= Addr(25 downto 2);
  shift_PC <= Addr_PC(1 downto 0);
  s1 <= Addr_PC(25 downto 2);
  gate0: entity work.barrel_shifter1 -- Rotate_left
    port map (
      shift => shift,
      in4 => ByteSize_in,
      Direction => '0',
      mode => "00",
      out4 => s15);
  gate1: entity work.barrel_shifter8 -- Rotate_left
    port map (
      shift_byte => shift,
      in32 => Data_in,
      Direction => '0',
      mode => "00",
      out32 => s20);
  gate2: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 4)
    port map (
      sel => WE,
      in_0 => "0000",
      in_1 => s15,
      p_out => s16);
  s2 <= s20(7 downto 0);
  s5 <= s20(15 downto 8);
  s8 <= s20(23 downto 16);
  s11 <= s20(31 downto 24);
  we0 <= s16(0);
  we1 <= s16(1);
  we2 <= s16(2);
  we3 <= s16(3);
  gate3: entity work.DIG_RAMDualAccess -- x00
    generic map (
      Bits => 8,
      AddrBits => 24)
    port map (
      str => we0,
      C => Clock,
      ld => OE,
      n1A => s0,
      n1Din => s2,
      n2A => s1,
      n1D => s3,
      n2D => s4);
  gate4: entity work.DIG_RAMDualAccess -- x01
    generic map (
      Bits => 8,
      AddrBits => 24)
    port map (
      str => we1,
      C => Clock,
      ld => OE,
      n1A => s0,
      n1Din => s5,
      n2A => s1,
      n1D => s6,
      n2D => s7);
  gate5: entity work.DIG_RAMDualAccess -- x10
    generic map (
      Bits => 8,
      AddrBits => 24)
    port map (
      str => we2,
      C => Clock,
      ld => OE,
      n1A => s0,
      n1Din => s8,
      n2A => s1,
      n1D => s9,
      n2D => s10);
  gate6: entity work.DIG_RAMDualAccess -- x11
    generic map (
      Bits => 8,
      AddrBits => 24)
    port map (
      str => we3,
      C => Clock,
      ld => OE,
      n1A => s0,
      n1Din => s11,
      n2A => s1,
      n1D => s12,
      n2D => s13);
  s14(7 downto 0) <= s3;
  s14(15 downto 8) <= s6;
  s14(23 downto 16) <= s9;
  s14(31 downto 24) <= s12;
  s18(7 downto 0) <= s4;
  s18(15 downto 8) <= s7;
  s18(23 downto 16) <= s10;
  s18(31 downto 24) <= s13;
  gate7: entity work.barrel_shifter8 -- Rotate_right
    port map (
      shift_byte => shift,
      in32 => s14,
      Direction => '1',
      mode => "00",
      out32 => s17);
  gate8: entity work.barrel_shifter8 -- Rotate_right
    port map (
      shift_byte => shift_PC,
      in32 => s18,
      Direction => '1',
      mode => "00",
      out32 => s19);
  gate9: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => s19,
      sel => OE_PC,
      p_out => DataPC_out);
  gate10: entity work.DRIVER_INV_GATE_BUS
    generic map (
      Bits => 32)
    port map (
      p_in => s17,
      sel => OE,
      p_out => Data_out);
end Behavioral;
