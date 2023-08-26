-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    fpga_0_RS232_DCE_RX_pin : in std_logic;
    fpga_0_RS232_DCE_TX_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_Clk_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_Clk_n_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_CE_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_CS_n_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_ODT_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_RAS_n_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_CAS_n_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_WE_n_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_BankAddr_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_Addr_pin : out std_logic_vector(12 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQ_pin : inout std_logic_vector(15 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DM_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQS_pin : inout std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQS_n_pin : inout std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQS_Div_O_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_DQS_Div_I_pin : in std_logic;
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic;
    vga_control_0_VGA_R_pin : out std_logic_vector(3 downto 0);
    vga_control_0_VGA_G_pin : out std_logic_vector(3 downto 0);
    vga_control_0_VGA_B_pin : out std_logic_vector(3 downto 0);
    vga_control_0_VGA_HSYNC_pin : out std_logic;
    vga_control_0_VGA_VSYNC_pin : out std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      fpga_0_RS232_DCE_RX_pin : in std_logic;
      fpga_0_RS232_DCE_TX_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_Clk_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_Clk_n_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_CE_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_CS_n_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_ODT_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_RAS_n_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_CAS_n_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_WE_n_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_BankAddr_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_Addr_pin : out std_logic_vector(12 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQ_pin : inout std_logic_vector(15 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DM_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQS_pin : inout std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQS_n_pin : inout std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQS_Div_O_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_DQS_Div_I_pin : in std_logic;
      fpga_0_clk_1_sys_clk_pin : in std_logic;
      fpga_0_rst_1_sys_rst_pin : in std_logic;
      vga_control_0_VGA_R_pin : out std_logic_vector(3 downto 0);
      vga_control_0_VGA_G_pin : out std_logic_vector(3 downto 0);
      vga_control_0_VGA_B_pin : out std_logic_vector(3 downto 0);
      vga_control_0_VGA_HSYNC_pin : out std_logic;
      vga_control_0_VGA_VSYNC_pin : out std_logic
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      fpga_0_RS232_DCE_RX_pin => fpga_0_RS232_DCE_RX_pin,
      fpga_0_RS232_DCE_TX_pin => fpga_0_RS232_DCE_TX_pin,
      fpga_0_DDR2_SDRAM_DDR2_Clk_pin => fpga_0_DDR2_SDRAM_DDR2_Clk_pin,
      fpga_0_DDR2_SDRAM_DDR2_Clk_n_pin => fpga_0_DDR2_SDRAM_DDR2_Clk_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_CE_pin => fpga_0_DDR2_SDRAM_DDR2_CE_pin,
      fpga_0_DDR2_SDRAM_DDR2_CS_n_pin => fpga_0_DDR2_SDRAM_DDR2_CS_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_ODT_pin => fpga_0_DDR2_SDRAM_DDR2_ODT_pin,
      fpga_0_DDR2_SDRAM_DDR2_RAS_n_pin => fpga_0_DDR2_SDRAM_DDR2_RAS_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_CAS_n_pin => fpga_0_DDR2_SDRAM_DDR2_CAS_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_WE_n_pin => fpga_0_DDR2_SDRAM_DDR2_WE_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_BankAddr_pin => fpga_0_DDR2_SDRAM_DDR2_BankAddr_pin,
      fpga_0_DDR2_SDRAM_DDR2_Addr_pin => fpga_0_DDR2_SDRAM_DDR2_Addr_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQ_pin => fpga_0_DDR2_SDRAM_DDR2_DQ_pin,
      fpga_0_DDR2_SDRAM_DDR2_DM_pin => fpga_0_DDR2_SDRAM_DDR2_DM_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_n_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_n_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_Div_O_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_Div_O_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_Div_I_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_Div_I_pin,
      fpga_0_clk_1_sys_clk_pin => fpga_0_clk_1_sys_clk_pin,
      fpga_0_rst_1_sys_rst_pin => fpga_0_rst_1_sys_rst_pin,
      vga_control_0_VGA_R_pin => vga_control_0_VGA_R_pin,
      vga_control_0_VGA_G_pin => vga_control_0_VGA_G_pin,
      vga_control_0_VGA_B_pin => vga_control_0_VGA_B_pin,
      vga_control_0_VGA_HSYNC_pin => vga_control_0_VGA_HSYNC_pin,
      vga_control_0_VGA_VSYNC_pin => vga_control_0_VGA_VSYNC_pin
    );

end architecture STRUCTURE;

