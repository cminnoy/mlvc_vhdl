-------------------------------------------------------------------------------
-- vga_controller_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library vga_control_v1_00_a;
use vga_control_v1_00_a.all;

entity vga_controller_0_wrapper is
  port (
    clk_50mhz : in std_logic;
    VGA_R : out std_logic_vector(3 downto 0);
    VGA_G : out std_logic_vector(3 downto 0);
    VGA_B : out std_logic_vector(3 downto 0);
    VGA_HSYNC : out std_logic;
    VGA_VSYNC : out std_logic;
    VFBC0_Cmd_Clk : out std_logic;
    VFBC0_Cmd_Reset : out std_logic;
    VFBC0_Cmd_Data : out std_logic_vector(31 downto 0);
    VFBC0_Cmd_Write : out std_logic;
    VFBC0_Cmd_End : out std_logic;
    VFBC0_Cmd_Full : in std_logic;
    VFBC0_Cmd_Almost_Full : in std_logic;
    VFBC0_Cmd_Idle : in std_logic;
    VFBC0_Wd_Clk : out std_logic;
    VFBC0_Wd_Reset : out std_logic;
    VFBC0_Wd_Write : out std_logic;
    VFBC0_Wd_End_Burst : out std_logic;
    VFBC0_Wd_Flush : out std_logic;
    VFBC0_Wd_Data : out std_logic_vector(15 downto 0);
    VFBC0_Wd_Data_BE : out std_logic_vector(1 downto 0);
    VFBC0_Wd_Full : in std_logic;
    VFBC0_Wd_Almost_Full : in std_logic;
    VFBC0_Rd_Clk : out std_logic;
    VFBC0_Rd_Reset : out std_logic;
    VFBC0_Rd_Read : out std_logic;
    VFBC0_Rd_End_Burst : out std_logic;
    VFBC0_Rd_Flush : out std_logic;
    VFBC0_Rd_Data : in std_logic_vector(15 downto 0);
    VFBC0_Rd_Empty : in std_logic;
    VFBC0_Rd_Almost_Empty : in std_logic;
    VFBC1_Cmd_Clk : out std_logic;
    VFBC1_Cmd_Reset : out std_logic;
    VFBC1_Cmd_Data : out std_logic_vector(31 downto 0);
    VFBC1_Cmd_Write : out std_logic;
    VFBC1_Cmd_End : out std_logic;
    VFBC1_Cmd_Full : in std_logic;
    VFBC1_Cmd_Almost_Full : in std_logic;
    VFBC1_Cmd_Idle : in std_logic;
    VFBC1_Wd_Clk : out std_logic;
    VFBC1_Wd_Reset : out std_logic;
    VFBC1_Wd_Write : out std_logic;
    VFBC1_Wd_End_Burst : out std_logic;
    VFBC1_Wd_Flush : out std_logic;
    VFBC1_Wd_Data : out std_logic_vector(15 downto 0);
    VFBC1_Wd_Data_BE : out std_logic_vector(1 downto 0);
    VFBC1_Wd_Full : in std_logic;
    VFBC1_Wd_Almost_Full : in std_logic;
    VFBC1_Rd_Clk : out std_logic;
    VFBC1_Rd_Reset : out std_logic;
    VFBC1_Rd_Read : out std_logic;
    VFBC1_Rd_End_Burst : out std_logic;
    VFBC1_Rd_Flush : out std_logic;
    VFBC1_Rd_Data : in std_logic_vector(15 downto 0);
    VFBC1_Rd_Empty : in std_logic;
    VFBC1_Rd_Almost_Empty : in std_logic;
    SPLB_Clk : in std_logic;
    SPLB_Rst : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_UABus : in std_logic_vector(0 to 31);
    PLB_PAValid : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_rdPrim : in std_logic;
    PLB_wrPrim : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 0);
    PLB_abort : in std_logic;
    PLB_busLock : in std_logic;
    PLB_RNW : in std_logic;
    PLB_BE : in std_logic_vector(0 to 7);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_lockErr : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 63);
    PLB_wrBurst : in std_logic;
    PLB_rdBurst : in std_logic;
    PLB_wrPendReq : in std_logic;
    PLB_rdPendReq : in std_logic;
    PLB_wrPendPri : in std_logic_vector(0 to 1);
    PLB_rdPendPri : in std_logic_vector(0 to 1);
    PLB_reqPri : in std_logic_vector(0 to 1);
    PLB_TAttribute : in std_logic_vector(0 to 15);
    Sl_addrAck : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_rearbitrate : out std_logic;
    Sl_wrDAck : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrBTerm : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 63);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    Sl_rdDAck : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdBTerm : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 1);
    Sl_MWrErr : out std_logic_vector(0 to 1);
    Sl_MRdErr : out std_logic_vector(0 to 1);
    Sl_MIRQ : out std_logic_vector(0 to 1);
    IP2INTC_Irpt : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of vga_controller_0_wrapper : entity is "vga_control_v1_00_a";

end vga_controller_0_wrapper;

architecture STRUCTURE of vga_controller_0_wrapper is

  component vga_control is
    generic (
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector;
      C_SPLB_AWIDTH : INTEGER;
      C_SPLB_DWIDTH : INTEGER;
      C_SPLB_NUM_MASTERS : INTEGER;
      C_SPLB_MID_WIDTH : INTEGER;
      C_SPLB_NATIVE_DWIDTH : INTEGER;
      C_SPLB_P2P : INTEGER;
      C_SPLB_SUPPORT_BURSTS : INTEGER;
      C_SPLB_SMALLEST_MASTER : INTEGER;
      C_SPLB_CLK_PERIOD_PS : INTEGER;
      C_INCLUDE_DPHASE_TIMER : INTEGER;
      C_FAMILY : STRING
    );
    port (
      clk_50mhz : in std_logic;
      VGA_R : out std_logic_vector(3 downto 0);
      VGA_G : out std_logic_vector(3 downto 0);
      VGA_B : out std_logic_vector(3 downto 0);
      VGA_HSYNC : out std_logic;
      VGA_VSYNC : out std_logic;
      VFBC0_Cmd_Clk : out std_logic;
      VFBC0_Cmd_Reset : out std_logic;
      VFBC0_Cmd_Data : out std_logic_vector(31 downto 0);
      VFBC0_Cmd_Write : out std_logic;
      VFBC0_Cmd_End : out std_logic;
      VFBC0_Cmd_Full : in std_logic;
      VFBC0_Cmd_Almost_Full : in std_logic;
      VFBC0_Cmd_Idle : in std_logic;
      VFBC0_Wd_Clk : out std_logic;
      VFBC0_Wd_Reset : out std_logic;
      VFBC0_Wd_Write : out std_logic;
      VFBC0_Wd_End_Burst : out std_logic;
      VFBC0_Wd_Flush : out std_logic;
      VFBC0_Wd_Data : out std_logic_vector(15 downto 0);
      VFBC0_Wd_Data_BE : out std_logic_vector(1 downto 0);
      VFBC0_Wd_Full : in std_logic;
      VFBC0_Wd_Almost_Full : in std_logic;
      VFBC0_Rd_Clk : out std_logic;
      VFBC0_Rd_Reset : out std_logic;
      VFBC0_Rd_Read : out std_logic;
      VFBC0_Rd_End_Burst : out std_logic;
      VFBC0_Rd_Flush : out std_logic;
      VFBC0_Rd_Data : in std_logic_vector(15 downto 0);
      VFBC0_Rd_Empty : in std_logic;
      VFBC0_Rd_Almost_Empty : in std_logic;
      VFBC1_Cmd_Clk : out std_logic;
      VFBC1_Cmd_Reset : out std_logic;
      VFBC1_Cmd_Data : out std_logic_vector(31 downto 0);
      VFBC1_Cmd_Write : out std_logic;
      VFBC1_Cmd_End : out std_logic;
      VFBC1_Cmd_Full : in std_logic;
      VFBC1_Cmd_Almost_Full : in std_logic;
      VFBC1_Cmd_Idle : in std_logic;
      VFBC1_Wd_Clk : out std_logic;
      VFBC1_Wd_Reset : out std_logic;
      VFBC1_Wd_Write : out std_logic;
      VFBC1_Wd_End_Burst : out std_logic;
      VFBC1_Wd_Flush : out std_logic;
      VFBC1_Wd_Data : out std_logic_vector(15 downto 0);
      VFBC1_Wd_Data_BE : out std_logic_vector(1 downto 0);
      VFBC1_Wd_Full : in std_logic;
      VFBC1_Wd_Almost_Full : in std_logic;
      VFBC1_Rd_Clk : out std_logic;
      VFBC1_Rd_Reset : out std_logic;
      VFBC1_Rd_Read : out std_logic;
      VFBC1_Rd_End_Burst : out std_logic;
      VFBC1_Rd_Flush : out std_logic;
      VFBC1_Rd_Data : in std_logic_vector(15 downto 0);
      VFBC1_Rd_Empty : in std_logic;
      VFBC1_Rd_Almost_Empty : in std_logic;
      SPLB_Clk : in std_logic;
      SPLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_UABus : in std_logic_vector(0 to 31);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_SPLB_MID_WIDTH-1));
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to ((C_SPLB_DWIDTH/8)-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendReq : in std_logic;
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_TAttribute : in std_logic_vector(0 to 15);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MWrErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MRdErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MIRQ : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      IP2INTC_Irpt : out std_logic
    );
  end component;

begin

  vga_controller_0 : vga_control
    generic map (
      C_BASEADDR => X"c3200000",
      C_HIGHADDR => X"c320ffff",
      C_SPLB_AWIDTH => 32,
      C_SPLB_DWIDTH => 64,
      C_SPLB_NUM_MASTERS => 2,
      C_SPLB_MID_WIDTH => 1,
      C_SPLB_NATIVE_DWIDTH => 32,
      C_SPLB_P2P => 0,
      C_SPLB_SUPPORT_BURSTS => 0,
      C_SPLB_SMALLEST_MASTER => 32,
      C_SPLB_CLK_PERIOD_PS => 16000,
      C_INCLUDE_DPHASE_TIMER => 0,
      C_FAMILY => "spartan3a"
    )
    port map (
      clk_50mhz => clk_50mhz,
      VGA_R => VGA_R,
      VGA_G => VGA_G,
      VGA_B => VGA_B,
      VGA_HSYNC => VGA_HSYNC,
      VGA_VSYNC => VGA_VSYNC,
      VFBC0_Cmd_Clk => VFBC0_Cmd_Clk,
      VFBC0_Cmd_Reset => VFBC0_Cmd_Reset,
      VFBC0_Cmd_Data => VFBC0_Cmd_Data,
      VFBC0_Cmd_Write => VFBC0_Cmd_Write,
      VFBC0_Cmd_End => VFBC0_Cmd_End,
      VFBC0_Cmd_Full => VFBC0_Cmd_Full,
      VFBC0_Cmd_Almost_Full => VFBC0_Cmd_Almost_Full,
      VFBC0_Cmd_Idle => VFBC0_Cmd_Idle,
      VFBC0_Wd_Clk => VFBC0_Wd_Clk,
      VFBC0_Wd_Reset => VFBC0_Wd_Reset,
      VFBC0_Wd_Write => VFBC0_Wd_Write,
      VFBC0_Wd_End_Burst => VFBC0_Wd_End_Burst,
      VFBC0_Wd_Flush => VFBC0_Wd_Flush,
      VFBC0_Wd_Data => VFBC0_Wd_Data,
      VFBC0_Wd_Data_BE => VFBC0_Wd_Data_BE,
      VFBC0_Wd_Full => VFBC0_Wd_Full,
      VFBC0_Wd_Almost_Full => VFBC0_Wd_Almost_Full,
      VFBC0_Rd_Clk => VFBC0_Rd_Clk,
      VFBC0_Rd_Reset => VFBC0_Rd_Reset,
      VFBC0_Rd_Read => VFBC0_Rd_Read,
      VFBC0_Rd_End_Burst => VFBC0_Rd_End_Burst,
      VFBC0_Rd_Flush => VFBC0_Rd_Flush,
      VFBC0_Rd_Data => VFBC0_Rd_Data,
      VFBC0_Rd_Empty => VFBC0_Rd_Empty,
      VFBC0_Rd_Almost_Empty => VFBC0_Rd_Almost_Empty,
      VFBC1_Cmd_Clk => VFBC1_Cmd_Clk,
      VFBC1_Cmd_Reset => VFBC1_Cmd_Reset,
      VFBC1_Cmd_Data => VFBC1_Cmd_Data,
      VFBC1_Cmd_Write => VFBC1_Cmd_Write,
      VFBC1_Cmd_End => VFBC1_Cmd_End,
      VFBC1_Cmd_Full => VFBC1_Cmd_Full,
      VFBC1_Cmd_Almost_Full => VFBC1_Cmd_Almost_Full,
      VFBC1_Cmd_Idle => VFBC1_Cmd_Idle,
      VFBC1_Wd_Clk => VFBC1_Wd_Clk,
      VFBC1_Wd_Reset => VFBC1_Wd_Reset,
      VFBC1_Wd_Write => VFBC1_Wd_Write,
      VFBC1_Wd_End_Burst => VFBC1_Wd_End_Burst,
      VFBC1_Wd_Flush => VFBC1_Wd_Flush,
      VFBC1_Wd_Data => VFBC1_Wd_Data,
      VFBC1_Wd_Data_BE => VFBC1_Wd_Data_BE,
      VFBC1_Wd_Full => VFBC1_Wd_Full,
      VFBC1_Wd_Almost_Full => VFBC1_Wd_Almost_Full,
      VFBC1_Rd_Clk => VFBC1_Rd_Clk,
      VFBC1_Rd_Reset => VFBC1_Rd_Reset,
      VFBC1_Rd_Read => VFBC1_Rd_Read,
      VFBC1_Rd_End_Burst => VFBC1_Rd_End_Burst,
      VFBC1_Rd_Flush => VFBC1_Rd_Flush,
      VFBC1_Rd_Data => VFBC1_Rd_Data,
      VFBC1_Rd_Empty => VFBC1_Rd_Empty,
      VFBC1_Rd_Almost_Empty => VFBC1_Rd_Almost_Empty,
      SPLB_Clk => SPLB_Clk,
      SPLB_Rst => SPLB_Rst,
      PLB_ABus => PLB_ABus,
      PLB_UABus => PLB_UABus,
      PLB_PAValid => PLB_PAValid,
      PLB_SAValid => PLB_SAValid,
      PLB_rdPrim => PLB_rdPrim,
      PLB_wrPrim => PLB_wrPrim,
      PLB_masterID => PLB_masterID,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_RNW => PLB_RNW,
      PLB_BE => PLB_BE,
      PLB_MSize => PLB_MSize,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_lockErr => PLB_lockErr,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrBurst => PLB_wrBurst,
      PLB_rdBurst => PLB_rdBurst,
      PLB_wrPendReq => PLB_wrPendReq,
      PLB_rdPendReq => PLB_rdPendReq,
      PLB_wrPendPri => PLB_wrPendPri,
      PLB_rdPendPri => PLB_rdPendPri,
      PLB_reqPri => PLB_reqPri,
      PLB_TAttribute => PLB_TAttribute,
      Sl_addrAck => Sl_addrAck,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_wrDAck => Sl_wrDAck,
      Sl_wrComp => Sl_wrComp,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdComp => Sl_rdComp,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_MBusy => Sl_MBusy,
      Sl_MWrErr => Sl_MWrErr,
      Sl_MRdErr => Sl_MRdErr,
      Sl_MIRQ => Sl_MIRQ,
      IP2INTC_Irpt => IP2INTC_Irpt
    );

end architecture STRUCTURE;

