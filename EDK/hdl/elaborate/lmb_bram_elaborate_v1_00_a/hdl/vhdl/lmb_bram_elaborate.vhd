-------------------------------------------------------------------------------
-- lmb_bram_elaborate.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity lmb_bram_elaborate is
  generic (
    C_MEMSIZE : integer;
    C_PORT_DWIDTH : integer;
    C_PORT_AWIDTH : integer;
    C_NUM_WE : integer;
    C_FAMILY : string
    );
  port (
    BRAM_Rst_A : in std_logic;
    BRAM_Clk_A : in std_logic;
    BRAM_EN_A : in std_logic;
    BRAM_WEN_A : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_A : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_A : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_A : in std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Rst_B : in std_logic;
    BRAM_Clk_B : in std_logic;
    BRAM_EN_B : in std_logic;
    BRAM_WEN_B : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_B : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_B : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_B : in std_logic_vector(0 to C_PORT_DWIDTH-1)
  );

  attribute keep_hierarchy : STRING;
  attribute keep_hierarchy of lmb_bram_elaborate : entity is "yes";

end lmb_bram_elaborate;

architecture STRUCTURE of lmb_bram_elaborate is

  component RAMB16BWE is
    generic (
      DATA_WIDTH_A : integer;
      DATA_WIDTH_B : integer
    );
    port (
      ADDRA : in std_logic_vector(13 downto 0);
      CLKA : in std_logic;
      DIA : in std_logic_vector(31 downto 0);
      DIPA : in std_logic_vector(3 downto 0);
      DOA : out std_logic_vector(31 downto 0);
      DOPA : out std_logic_vector(3 downto 0);
      ENA : in std_logic;
      SSRA : in std_logic;
      WEA : in std_logic_vector(3 downto 0);
      ADDRB : in std_logic_vector(13 downto 0);
      CLKB : in std_logic;
      DIB : in std_logic_vector(31 downto 0);
      DIPB : in std_logic_vector(3 downto 0);
      DOB : out std_logic_vector(31 downto 0);
      DOPB : out std_logic_vector(3 downto 0);
      ENB : in std_logic;
      SSRB : in std_logic;
      WEB : in std_logic_vector(3 downto 0)
    );
  end component;

  -- Internal signals

  signal net_gnd4 : std_logic_vector(3 downto 0);
  signal pgassign1 : std_logic_vector(0 to 4);
  signal pgassign2 : std_logic_vector(13 downto 0);
  signal pgassign3 : std_logic_vector(13 downto 0);

begin

  -- Internal assignments

  pgassign1(0 to 4) <= B"00000";
  pgassign2(13 downto 5) <= BRAM_Addr_A(21 to 29);
  pgassign2(4 downto 0) <= B"00000";
  pgassign3(13 downto 5) <= BRAM_Addr_B(21 to 29);
  pgassign3(4 downto 0) <= B"00000";
  net_gnd4(3 downto 0) <= B"0000";

  ramb16bwe_0 : RAMB16BWE
    generic map (
      DATA_WIDTH_A => 36,
      DATA_WIDTH_B => 36
    )
    port map (
      ADDRA => pgassign2,
      CLKA => BRAM_Clk_A,
      DIA => BRAM_Dout_A(0 to 31),
      DIPA => net_gnd4,
      DOA => BRAM_Din_A(0 to 31),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(0 to 3),
      ADDRB => pgassign3,
      CLKB => BRAM_Clk_B,
      DIB => BRAM_Dout_B(0 to 31),
      DIPB => net_gnd4,
      DOB => BRAM_Din_B(0 to 31),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(0 to 3)
    );

end architecture STRUCTURE;

