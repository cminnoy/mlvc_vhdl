------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 2009-2010 Minnoy Chris  All rights reserved.            **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              04/04/2010
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_INTR                   -- Number of interrupt event
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_IntrEvent             -- IP to Bus interrupt event
------------------------------------------------------------------------------

entity user_logic is
	generic	(
	-- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_DWIDTH                   : integer              := 32;
    C_NUM_REG                      : integer              := 18;
    C_NUM_INTR                     : integer              := 2
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
	port (
    -- ADD USER PORTS BELOW THIS LINE ------------------
	-- VGA
	clk_50mhz               : in  std_logic;					-- Input clock for VGA CONTROL
	VGA_R					: out std_logic_vector(3 downto 0);	-- VGA Red Colour
	VGA_G                   : out std_logic_vector(3 downto 0);	-- VGA Green Colour
	VGA_B                   : out std_logic_vector(3 downto 0);	-- VGA Blue Colour
	VGA_HSYNC               : out std_logic;					-- VGA Horizontal Synchronization
	VGA_VSYNC				: out std_logic;					-- VGA Vertical Synchronization

	-- VFBC0 Cmd
	VFBC0_Cmd_Clk			: out std_logic;
	VFBC0_Cmd_Reset			: out std_logic;
	VFBC0_Cmd_Data			: out std_logic_vector(31 downto 0);
	VFBC0_Cmd_Write			: out std_logic;
	VFBC0_Cmd_End			: out std_logic;
	VFBC0_Cmd_Full			: in  std_logic;
	VFBC0_Cmd_Almost_Full	: in  std_logic;
	VFBC0_Cmd_Idle			: in  std_logic;

	-- VFBC0 Write (is not used!)
	VFBC0_Wd_Clk			: out std_logic;
	VFBC0_Wd_Reset			: out std_logic;
	VFBC0_Wd_Write			: out std_logic;
	VFBC0_Wd_End_Burst		: out std_logic;
	VFBC0_Wd_Flush			: out std_logic;
	VFBC0_Wd_Data			: out std_logic_vector(15 downto 0);
	VFBC0_Wd_Data_BE		: out std_logic_vector(1 downto 0);
	VFBC0_Wd_Full			: in  std_logic;
	VFBC0_Wd_Almost_Full	: in  std_logic;

	-- VFBC0 Read
	VFBC0_Rd_Clk			: out std_logic;
	VFBC0_Rd_Reset			: out std_logic;
	VFBC0_Rd_Read			: out std_logic;
	VFBC0_Rd_End_Burst		: out std_logic;
	VFBC0_Rd_Flush			: out std_logic;
	VFBC0_Rd_Data			: in  std_logic_vector(15 downto 0);
	VFBC0_Rd_Empty			: in  std_logic;
	VFBC0_Rd_Almost_Empty	: in  std_logic;
	
	-- VFBC1 Cmd
	VFBC1_Cmd_Clk			: out std_logic;
	VFBC1_Cmd_Reset			: out std_logic;
	VFBC1_Cmd_Data			: out std_logic_vector(31 downto 0);
	VFBC1_Cmd_Write			: out std_logic;
	VFBC1_Cmd_End			: out std_logic;
	VFBC1_Cmd_Full			: in  std_logic;
	VFBC1_Cmd_Almost_Full	: in  std_logic;
	VFBC1_Cmd_Idle			: in  std_logic;

	-- VFBC1 Write (is not used!)
	VFBC1_Wd_Clk			: out std_logic;
	VFBC1_Wd_Reset			: out std_logic;
	VFBC1_Wd_Write			: out std_logic;
	VFBC1_Wd_End_Burst		: out std_logic;
	VFBC1_Wd_Flush			: out std_logic;
	VFBC1_Wd_Data			: out std_logic_vector(15 downto 0);
	VFBC1_Wd_Data_BE		: out std_logic_vector(1 downto 0);
	VFBC1_Wd_Full			: in  std_logic;
	VFBC1_Wd_Almost_Full	: in  std_logic;

	-- VFBC1 Read
	VFBC1_Rd_Clk			: out std_logic;
	VFBC1_Rd_Reset			: out std_logic;
	VFBC1_Rd_Read			: out std_logic;
	VFBC1_Rd_End_Burst		: out std_logic;
	VFBC1_Rd_Flush			: out std_logic;
	VFBC1_Rd_Data			: in  std_logic_vector(15 downto 0);
	VFBC1_Rd_Empty			: in  std_logic;
	VFBC1_Rd_Almost_Empty	: in  std_logic;
	-- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_IntrEvent               : out std_logic_vector(0 to C_NUM_INTR-1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

	attribute SIGIS : string;
	attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
	attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

	component AlphaBlendingMultiplier
	port (
		clk:  in std_logic;
		a: in std_logic_vector(9 downto 0);
		b: in std_logic_vector(9 downto 0);
		p: out std_logic_vector(19 downto 0));
	end component;

	component CopperMemory
	port (
		clka: in std_logic;
		wea: in std_logic_vector(0 downto 0);
		addra: in std_logic_vector(8 downto 0);
		dina: in std_logic_vector(15 downto 0);
		clkb: in std_logic;
		addrb: in std_logic_vector(8 downto 0);
		doutb: out std_logic_vector(15 downto 0));
	end component;
	
	component CopperEffect
	port (
		clka: in std_logic;
		wea: in std_logic_vector(0 downto 0);
		addra: in std_logic_vector(4 downto 0);
		dina: in std_logic_vector(15 downto 0);
		clkb: in std_logic;
		addrb: in std_logic_vector(8 downto 0);
		doutb: out std_logic_vector(0 downto 0));
	end component;

	attribute syn_black_box : boolean;
	attribute syn_black_box of AlphaBlendingMultiplier: component is true;
	attribute syn_black_box of CopperMemory: component is true;
	attribute syn_black_box of CopperEffect: component is true;
	
	------------------------------------------
	-- Signals for user logic slave model s/w accessible register example
	------------------------------------------
	-- We assume C_SLV_DWIDTH to be 32 !

	-- Activate layers
	-- bit 31 -> Layer: Viewport0 on/off
	-- bit 30 -> Layer: Copper on/off
	-- bit 29 -> Layer: Viewport1 on/off
	-- bit 26 -> Timebased dithering on/off
	-- bit 25 -> Screen on/off
	-- bit  1 -> 0 = Automatic update, 1 = Transactional update
	-- bit  0 -> Vertical Blank
	signal slv_screen_control			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	
	-- Background colour
	-- bit(17:21) -> Red
	-- bit(22:26) -> Green
	-- bit(27:31) -> Blue
	signal slv_background_colour		: std_logic_vector(0 to C_SLV_DWIDTH-1);
		
	-- Start address of copper list
	signal slv_copperlist_address		: std_logic_vector(0 to C_SLV_DWIDTH-1);

	-- Start address of canvas'
	signal slv_canvas0_address			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_canvas1_address			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	
	-- Canvas Width/Height
	signal slv_canvas0_width			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_canvas0_height			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_canvas1_width			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_canvas1_height			: std_logic_vector(0 to C_SLV_DWIDTH-1);

	-- Viewport Width/Height/Screen position/Canvas position
	signal slv_viewport0_width			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport0_height			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport0_sx				: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport0_sy				: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport1_width			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport1_height			: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport1_sx				: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_viewport1_sy				: std_logic_vector(0 to C_SLV_DWIDTH-1);

	-- Alpha blend value of viewport1 layer
	signal slv_viewport1_alpha			: std_logic_vector(0 to C_SLV_DWIDTH-1);

	signal slv_reg_write_sel			: std_logic_vector(0 to 17);
	signal slv_reg_read_sel				: std_logic_vector(0 to 17);
	signal slv_ip2bus_data				: std_logic_vector(0 to C_SLV_DWIDTH-1);
	signal slv_read_ack					: std_logic;
	signal slv_write_ack				: std_logic;

	------------------------------------------
	-- Local filtered copies of slave registers (updated every vertical blank)
	------------------------------------------
	signal lcl_screen_on				: std_logic;
	signal lcl_layer_viewport0_on		: std_logic;
	signal lcl_layer_copper_on			: std_logic;
	signal lcl_layer_viewport1_on		: std_logic;
	signal lcl_timebased_dithering_on	: std_logic;
	signal lcl_transactional			: std_logic;
	signal lcl_background_colour		: std_logic_vector(0 to 14);
	signal lcl_canvas0_address			: std_logic_vector(0 to 31);
	signal lcl_canvas0_width			: std_logic_vector(0 to 31);
	signal lcl_canvas0_height			: std_logic_vector(0 to 31);
	signal lcl_copperlist_address	    : std_logic_vector(0 to 31);
	signal lcl_canvas1_address			: std_logic_vector(0 to 31);
	signal lcl_canvas1_width			: std_logic_vector(0 to 31);
	signal lcl_canvas1_height			: std_logic_vector(0 to 31);
	signal lcl_viewport0_width			: std_logic_vector(0 to 31); -- 0 -> 640
	signal lcl_viewport0_height			: std_logic_vector(0 to 31); -- 0 -> 480
	signal lcl_viewport0_sx				: std_logic_vector(0 to 31); -- 0 -> 639
	signal lcl_viewport0_sy				: std_logic_vector(0 to 31); -- 0 -> 479
	signal lcl_viewport1_width			: std_logic_vector(0 to 31); -- 0 -> 640
	signal lcl_viewport1_height			: std_logic_vector(0 to 31); -- 0 -> 480
	signal lcl_viewport1_sx				: std_logic_vector(0 to 31); -- 0 -> 639
	signal lcl_viewport1_sy				: std_logic_vector(0 to 31); -- 0 -> 479
	signal lcl_viewport1_alpha			: std_logic_vector(0 to 9);
	signal lcl_viewport1_alphainv		: std_logic_vector(0 to 9);
	
	------------------------------------------
	-- Signals for user logic interrupt example
	------------------------------------------
	signal intr_counter             : std_logic_vector(0 to C_NUM_INTR-1);

	--------------------------
	-- Signals for VGA control
	--------------------------

	-- VFBC Control State machine
	type VFBC_CmdState_t is (VFBCCMD_IDLE, VFBCCMD_W0, VFBCCMD_W1, VFBCCMD_W2, VFBCCMD_W3);
	type VFBC0_Action_t is (VFBC0_IDLE, VFBC0_LOAD_VIEWPORT);
	type VFBC1_Action_t is (VFBC1_IDLE, VFBC1_LOAD_VIEWPORT, VFBC1_LOAD_COPPER);

	-- 640x480 60Hz settings
	constant SCREEN_WIDTH					: natural := 640;
	constant SCREEN_HEIGHT					: natural := 480;
	constant HORIZONTAL_CURB_START			: natural :=  0;
	constant HORIZONTAL_CURB_STOP			: natural := 95;
	constant VERTICAL_CURB_START			: natural :=  0;
	constant VERTICAL_CURB_STOP				: natural :=  1;
	constant HORIZONTAL_VISIBLE_AREA_START	: natural := 135;
	constant HORIZONTAL_VISIBLE_AREA_STOP	: natural := HORIZONTAL_VISIBLE_AREA_START +
														 SCREEN_WIDTH; -- 1 after real visible area
	constant VERTICAL_VISIBLE_AREA_START	: natural := 26;
	constant VERTICAL_VISIBLE_AREA_STOP		: natural := VERTICAL_VISIBLE_AREA_START +
														 SCREEN_HEIGHT; --1 after real visible area
	constant HORIZONTAL_RETURN_POINT		: natural := 799;
	constant VERTICAL_RETURN_POINT			: natural := 524;

	-- screen types
	subtype HorizontalIndex_t is natural range 0 to SCREEN_WIDTH;
	subtype VerticalIndex_t   is natural range 0 to SCREEN_HEIGHT;
	subtype ScreenIndex_t     is natural range 0 to SCREEN_WIDTH * SCREEN_HEIGHT;
	
	-- Clocks
	signal clk_25mhz    	: std_logic; -- clock 25 mhz
	signal clk_25mhz_25p	: std_logic; -- clock 25 mhz 25 percent shifted (half tick)
	signal clk_25mhz_50p	: std_logic; -- clock 25 mhz 50 percent shifted (pure invers)
	signal clk_25mhz_75p	: std_logic; -- clock 25 mhz 75 percent shifted (invers of 25p)

	-- Cathode beam control
	signal horz_dsp				: natural := 0;			 -- horizontal display index of cathode ray
	signal vert_dsp				: natural := 0;			 -- vertical display index of cathode ray
	signal horz_pxl				: HorizontalIndex_t := 0;-- horizontal index in visible area
	signal vert_pxl				: VerticalIndex_t := 0;	 -- vertical index in visible area
	signal even_odd_trigger		: boolean := false;		 -- even/odd trigger (time based dithering)
	signal vblank				: std_logic := '0';		 -- vertical blank active
	
	-- VFBC control
	
	signal vfbc0_rd_cmd_action			: VFBC0_Action_t := VFBC0_IDLE;
	signal vfbc0_rd_cmdstate_current	: VFBC_CmdState_t := VFBCCMD_IDLE;
	signal vfbc0_rd_cmdstate_next		: VFBC_CmdState_t := VFBCCMD_IDLE;
	signal vfbc1_rd_cmd_action			: VFBC1_Action_t := VFBC1_IDLE;
	signal vfbc1_rd_cmdstate_current	: VFBC_CmdState_t := VFBCCMD_IDLE;
	signal vfbc1_rd_cmdstate_next		: VFBC_CmdState_t := VFBCCMD_IDLE;

	-- Viewport control
	signal viewport0_sx_begin : integer;
	signal viewport0_sx_end   : integer;
	signal viewport0_sy_begin : integer;
	signal viewport0_sy_end   : integer;
	signal viewport1_address  : std_logic_vector(0 to 30);
	signal viewport1_sx_begin : integer;
	signal viewport1_sx_end   : integer;
	signal viewport1_sy_begin : integer;
	signal viewport1_sy_end   : integer;

	-- Active pixel colour (after rendering)
	signal cathode_red				: std_logic_vector(0 to 3);
	signal cathode_green			: std_logic_vector(0 to 3);
	signal cathode_blue				: std_logic_vector(0 to 3);
	
	-- Background colour
	signal background_red			: std_logic_vector(0 to 4);
	signal background_green			: std_logic_vector(0 to 4);
	signal background_blue			: std_logic_vector(0 to 4);
	
	-- Active copper colour
	signal copper_transparent   	: std_logic;
	signal copper_red				: std_logic_vector(0 to 4);
	signal copper_green 			: std_logic_vector(0 to 4);
	signal copper_blue  			: std_logic_vector(0 to 4);
	
	-- Copper memory control
	signal copper_memory_write_enable	: std_logic_vector(0 downto 0);
	signal copper_memory_write_address	: std_logic_vector(8 downto 0);
	signal copper_memory_write_data		: std_logic_vector(15 downto 0);
	signal copper_memory_read_address	: std_logic_vector(8 downto 0);
	signal copper_memory_read_data		: std_logic_vector(15 downto 0);
	
	-- Copper effect control
	signal copper_effect_write_enable	: std_logic_vector(0 downto 0);
	signal copper_effect_write_address	: std_logic_vector(4 downto 0);
	signal copper_effect_write_data		: std_logic_vector(15 downto 0);
	signal copper_effect_read_address	: std_logic_vector(8 downto 0);
	signal copper_effect_read_data		: std_logic_vector(0 downto 0);
	
	
	signal vfbc1_copper_rd_read		: std_logic;
	signal vfbc1_viewport1_rd_read	: std_logic;
	
	-- Copper anim
	signal copper_base_address		: std_logic_vector(0 to 31) := (others => '0');
	signal copper_current_address	: std_logic_vector(0 to 31) := (others => '0');
	signal copper_next_address		: std_logic_vector(0 to 31);
	signal copper_read_next_address	: boolean := false;

	-- Active viewport0 colour
	signal viewport0_transparent	: std_logic;
	signal viewport0_red			: std_logic_vector(0 to 4);
	signal viewport0_green			: std_logic_vector(0 to 4);
	signal viewport0_blue			: std_logic_vector(0 to 4);

	-- Active viewport1 colour
	signal viewport1_transparent_d0	: std_logic;
	signal viewport1_transparent	: std_logic;
	signal viewport1_red			: std_logic_vector(0 to 4);
	signal viewport1_green			: std_logic_vector(0 to 4);
	signal viewport1_blue			: std_logic_vector(0 to 4);
	signal viewport1_alpha			: std_logic_vector(0 to 9);
	signal viewport1_alphainv		: std_logic_vector(0 to 9);
	
	-- Viewport1 colour before and after alpha blending (using bit-replication and rounding)
	signal viewport1_red_i			: std_logic_vector(0 to 9);
	signal viewport1_blue_i			: std_logic_vector(0 to 9);
	signal viewport1_green_i		: std_logic_vector(0 to 9);
	signal viewport1_red_o			: std_logic_vector(0 to 19);
	signal viewport1_green_o		: std_logic_vector(0 to 19);
	signal viewport1_blue_o			: std_logic_vector(0 to 19);

begin
	
	slv_reg_write_sel <= Bus2IP_WrCE(0 to 17);
	slv_reg_read_sel  <= Bus2IP_RdCE(0 to 17);
	
	slv_write_ack <= Bus2IP_WrCE( 0) or Bus2IP_WrCE( 1) or Bus2IP_WrCE( 2) or Bus2IP_WrCE( 3) or
					 Bus2IP_WrCE( 4) or Bus2IP_WrCE( 5) or Bus2IP_WrCE( 6) or Bus2IP_WrCE( 7) or
					 Bus2IP_WrCE( 8) or Bus2IP_WrCE( 9) or Bus2IP_WrCE(10) or Bus2IP_WrCE(11) or
					 Bus2IP_WrCE(12) or Bus2IP_WrCE(13) or Bus2IP_WrCE(14) or Bus2IP_WrCE(15) or
					 Bus2IP_WrCE(16) or Bus2IP_WrCE(17);
					 
	slv_read_ack <= Bus2IP_RdCE( 0) or Bus2IP_RdCE( 1) or Bus2IP_RdCE( 2) or Bus2IP_RdCE( 3) or
					Bus2IP_RdCE( 4) or Bus2IP_RdCE( 5) or Bus2IP_RdCE( 6) or Bus2IP_RdCE( 7) or
					Bus2IP_RdCE( 8) or Bus2IP_RdCE( 9) or Bus2IP_RdCE(10) or Bus2IP_RdCE(11) or
					Bus2IP_RdCE(12) or Bus2IP_RdCE(13) or Bus2IP_RdCE(14) or Bus2IP_RdCE(15) or
					Bus2IP_RdCE(16) or Bus2IP_RdCE(17);

	SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
	begin
		if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
			if Bus2IP_Reset = '1' then
				slv_screen_control		<= (others => '0');
				slv_background_colour	<= (others => '0');
				slv_canvas0_address		<= (others => '0');
				slv_canvas0_width		<= (others => '0');
				slv_canvas0_height		<= (others => '0');
				slv_copperlist_address	<= (others => '0');
				slv_canvas1_address		<= (others => '0');
				slv_canvas1_width		<= (others => '0');
				slv_canvas1_height		<= (others => '0');
				slv_viewport0_width		<= (others => '0');
				slv_viewport0_height	<= (others => '0');
				slv_viewport0_sx		<= (others => '0');
				slv_viewport0_sy		<= (others => '0');
				slv_viewport1_width		<= (others => '0');
				slv_viewport1_height	<= (others => '0');
				slv_viewport1_sx		<= (others => '0');
				slv_viewport1_sy		<= (others => '0');
				slv_viewport1_alpha		<= (others => '0');
			else
				case slv_reg_write_sel is
					when "100000000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_screen_control(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "010000000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_background_colour(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "001000000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas0_address(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000100000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas0_width(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000010000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas0_height(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000001000000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_copperlist_address(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000100000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas1_address(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000010000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas1_width(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
						end if;
					end loop;
					when "000000001000000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_canvas1_height(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000100000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport0_width(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000010000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport0_height(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000001000000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport0_sx(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000100000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport0_sy(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000010000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport1_width(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000001000" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport1_height(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000000100" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport1_sx(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000000010" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport1_sy(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when "000000000000000001" =>
						for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
							if ( Bus2IP_BE(byte_index) = '1' ) then
								slv_viewport1_alpha(byte_index*8 to byte_index*8+7) <=
									Bus2IP_Data(byte_index*8 to byte_index*8+7);
							end if;
						end loop;
					when others => null;
				end case;
			end if;
		end if;
	end process SLAVE_REG_WRITE_PROC;

	SLAVE_REG_READ_PROC : process(	slv_reg_read_sel,
									slv_screen_control,
									slv_background_colour,
									slv_canvas0_address,
									slv_canvas0_width,
									slv_canvas0_height,
									slv_copperlist_address,
									slv_canvas1_address,
									slv_canvas1_width,
									slv_canvas1_height,
									slv_viewport0_width,
									slv_viewport0_height,
									slv_viewport0_sx,
									slv_viewport0_sy,
									slv_viewport1_width,
									slv_viewport1_height,
									slv_viewport1_sx,
									slv_viewport1_sy,
									slv_viewport1_alpha,
									vblank) is
	begin
		case slv_reg_read_sel is
			when "100000000000000000" => slv_ip2bus_data(      0) <= vblank;
									     slv_ip2bus_data(1 to 31) <= slv_screen_control(1 to 31);
			when "010000000000000000" => slv_ip2bus_data <= slv_background_colour;
			when "001000000000000000" => slv_ip2bus_data <= slv_canvas0_address;
			when "000100000000000000" => slv_ip2bus_data <= slv_canvas0_width;
			when "000010000000000000" => slv_ip2bus_data <= slv_canvas0_height;
			when "000001000000000000" => slv_ip2bus_data <= slv_copperlist_address;
			when "000000100000000000" => slv_ip2bus_data <= slv_canvas1_address;
			when "000000010000000000" => slv_ip2bus_data <= slv_canvas1_width;
			when "000000001000000000" => slv_ip2bus_data <= slv_canvas1_height;
			when "000000000100000000" => slv_ip2bus_data <= slv_viewport0_width;
			when "000000000010000000" => slv_ip2bus_data <= slv_viewport0_height;
			when "000000000001000000" => slv_ip2bus_data <= slv_viewport0_sx;
			when "000000000000100000" => slv_ip2bus_data <= slv_viewport0_sy;
			when "000000000000010000" => slv_ip2bus_data <= slv_viewport1_width;
			when "000000000000001000" => slv_ip2bus_data <= slv_viewport1_height;
			when "000000000000000100" => slv_ip2bus_data <= slv_viewport1_sx;
			when "000000000000000010" => slv_ip2bus_data <= slv_viewport1_sy;
			when "000000000000000001" => slv_ip2bus_data <= slv_viewport1_alpha;
			when others				  => slv_ip2bus_data <= (others => '0');
		end case;
	end process SLAVE_REG_READ_PROC;

	------------------------------------------
	-- Example code to generate user logic interrupts
	-- 
	-- Note:
	-- The example code presented here is to show you one way of generating
	-- interrupts from the user logic. This code snippet infers a counter
	-- and generate the interrupts whenever the counter rollover (the counter
	-- will rollover ~21 sec @50Mhz).
	------------------------------------------
	INTR_PROC : process( Bus2IP_Clk ) is
		constant COUNT_SIZE   : integer := 30;
		constant ALL_ONES     : std_logic_vector(0 to COUNT_SIZE-1) := (others => '1');
		variable counter      : std_logic_vector(0 to COUNT_SIZE-1);
	begin
		if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
			if ( Bus2IP_Reset = '1' ) then
				counter := (others => '0');
				intr_counter <= (others => '0');
			else
				counter := counter + 1;
				if ( counter = ALL_ONES ) then
					intr_counter <= (others => '1');
				else
					intr_counter <= (others => '0');
				end if;
			end if;
		end if;
	end process INTR_PROC;

	IP2Bus_IntrEvent <= intr_counter;

	--------------------------
	-- drive IP to Bus signals
	--------------------------
	IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else (others => '0');
	IP2Bus_WrAck <= slv_write_ack;
	IP2Bus_RdAck <= slv_read_ack;
	IP2Bus_Error <= '0';

	--------------------
	-- VGA control logic
	--------------------

	VFBC0_Cmd_Reset <= Bus2IP_Reset;
	VFBC1_Cmd_Reset <= Bus2IP_Reset;
	
	VFBC0_Rd_Flush <= vblank;
	VFBC1_Rd_Flush <= vblank;

	clock_divider : process (clk_50mhz)
	begin
		if rising_edge(clk_50mhz) then
			if clk_25mhz = '1' then
				clk_25mhz <= '0';
				clk_25mhz_50p <= '1';
			else
				clk_25mhz <= '1';
				clk_25mhz_50p <= '0';
			end if;
		end if;
	end process clock_divider;
	
	clock_divider_shifted : process (clk_50mhz)
	begin
		if falling_edge(clk_50mhz) then
			if clk_25mhz_25p = '1' then
				clk_25mhz_25p <= '0';
				clk_25mhz_75p <= '1';
			else
				clk_25mhz_25p <= '1';
				clk_25mhz_75p <= '0';
			end if;
		end if;
	end process clock_divider_shifted;
	
	copy_ext_registers_to_local : process(clk_25mhz)
	begin
		if rising_edge(clk_25mhz) then
			lcl_transactional <= slv_screen_control(1);
			if vert_dsp = 1 and horz_dsp = 1 and slv_screen_control(1) = '0' then
				-- copy externaly visible registers to local map
				lcl_layer_viewport0_on			<= slv_screen_control(31);
				if slv_copperlist_address /= 0 then
					lcl_layer_copper_on			<= slv_screen_control(30);
				else
					lcl_layer_copper_on			<= '0';
				end if;
				lcl_layer_viewport1_on			<= slv_screen_control(29);
				lcl_timebased_dithering_on		<= slv_screen_control(26);
				lcl_screen_on					<= slv_screen_control(25);
				lcl_background_colour			<= slv_background_colour(17 to 31);
				lcl_canvas0_address				<= slv_canvas0_address;
				lcl_canvas0_width				<= slv_canvas0_width;
				lcl_canvas0_height				<= slv_canvas0_height;
				lcl_copperlist_address			<= slv_copperlist_address;
				lcl_canvas1_address				<= slv_canvas1_address;
				lcl_canvas1_width				<= slv_canvas1_width;
				lcl_canvas1_height				<= slv_canvas1_height;
				lcl_viewport0_width				<= slv_viewport0_width;
				lcl_viewport0_height			<= slv_viewport0_height;
				lcl_viewport0_sx				<= slv_viewport0_sx;
				lcl_viewport0_sy				<= slv_viewport0_sy;
				lcl_viewport1_width				<= slv_viewport1_width;
				lcl_viewport1_height			<= slv_viewport1_height;
				lcl_viewport1_sx				<= slv_viewport1_sx;
				lcl_viewport1_sy				<= slv_viewport1_sy;
				lcl_viewport1_alpha(0 to 4)		<= slv_viewport1_alpha(27 to 31);
				lcl_viewport1_alpha(5 to 9)		<= slv_viewport1_alpha(27 to 31);
				-- derived
				lcl_viewport1_alphainv(0 to 4)	<= "11111" - slv_viewport1_alpha(27 to 31);
				lcl_viewport1_alphainv(5 to 9)	<= "11111" - slv_viewport1_alpha(27 to 31);
				viewport0_sx_begin				<= HORIZONTAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport0_sx);
				viewport0_sx_end				<= HORIZONTAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport0_sx) +
												   CONV_INTEGER(slv_viewport0_width);
				viewport0_sy_begin				<= VERTICAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport0_sy);
				viewport0_sy_end				<= VERTICAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport0_sy) +
												   CONV_INTEGER(slv_viewport0_height);
				viewport1_sx_begin				<= HORIZONTAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport1_sx);
				viewport1_sx_end				<= HORIZONTAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport1_sx) +
												   CONV_INTEGER(slv_viewport1_width);
				viewport1_sy_begin				<= VERTICAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport1_sy);
				viewport1_sy_end				<= VERTICAL_VISIBLE_AREA_START +
												   CONV_INTEGER(slv_viewport1_sy) +
												   CONV_INTEGER(slv_viewport1_height);
			end if;
		end if;
	end process copy_ext_registers_to_local;
	
	display_control : process (clk_25mhz)
	begin
		if rising_edge(clk_25mhz) then
			-- if beam on visible line
			if vert_dsp >= VERTICAL_VISIBLE_AREA_START and
			   vert_dsp < VERTICAL_VISIBLE_AREA_STOP then				
				if horz_dsp >= HORIZONTAL_VISIBLE_AREA_START and
				   horz_dsp < HORIZONTAL_VISIBLE_AREA_STOP then
					horz_pxl <= horz_pxl + 1; 
					if lcl_screen_on = '1' then
						VGA_R <= cathode_red;
						VGA_G <= cathode_green;
						VGA_B <= cathode_blue;
					else
						VGA_R <= "0000";
						VGA_G <= "0000";
						VGA_B <= "0000";
					end if;
				else
					VGA_R <= "0000";
					VGA_G <= "0000";
					VGA_B <= "0000";
				end if;
				if (horz_dsp = HORIZONTAL_RETURN_POINT) then
					vert_pxl <= vert_pxl + 1;
				end if;
			end if;

			-- horizontal curb
			if lcl_screen_on = '1' and
			   horz_dsp >= HORIZONTAL_CURB_START and
			   horz_dsp <= HORIZONTAL_CURB_STOP then
				VGA_HSYNC <= '0';
			else
				VGA_HSYNC <= '1';
			end if;
		 
			-- vertical curb
			if vert_dsp >= VERTICAL_CURB_START and
			   vert_dsp <= VERTICAL_CURB_STOP then
				if lcl_screen_on = '1' then
					VGA_VSYNC <= '0';
				else
					VGA_VSYNC <= '1';
				end if;
				vblank <= '1';
			else
				VGA_VSYNC <= '1';
				vblank <= '0';
			end if;

			-- next horizontal pixel
			horz_dsp <= horz_dsp + 1;
		 
			-- horizontal beam return
			if horz_dsp = HORIZONTAL_RETURN_POINT then
				vert_dsp <= vert_dsp + 1;
				horz_dsp <= 0;
				horz_pxl <= 0;
			end if;
		 
			-- vertical beam return
			if vert_dsp = VERTICAL_RETURN_POINT then
				vert_dsp <= 0;		
				vert_pxl <= 0;
				even_odd_trigger <= not even_odd_trigger;
			end if;
		end if;  
	end process display_control;
	
	vfbc_trigger : process (vert_dsp,
							horz_dsp,
							lcl_layer_viewport0_on,
							lcl_layer_viewport1_on,
							lcl_layer_copper_on)
	begin
		if vert_dsp = VERTICAL_VISIBLE_AREA_START - 2 and horz_dsp = 1 then
			if lcl_layer_viewport0_on = '1' then
				vfbc0_rd_cmd_action <= VFBC0_LOAD_VIEWPORT;
			else
				vfbc0_rd_cmd_action <= VFBC0_IDLE;
			end if;
			if lcl_layer_viewport1_on = '1' then
				vfbc1_rd_cmd_action <= VFBC1_LOAD_VIEWPORT;
			else
				vfbc1_rd_cmd_action <= VFBC1_IDLE;
			end if;
		elsif vert_dsp = VERTICAL_VISIBLE_AREA_START - 10 and horz_dsp = 1 then
			vfbc0_rd_cmd_action <= VFBC0_IDLE;
			if lcl_layer_copper_on = '1' then
				vfbc1_rd_cmd_action <= VFBC1_LOAD_COPPER;
			else
				vfbc1_rd_cmd_action <= VFBC1_IDLE;
			end if;
		else
			vfbc0_rd_cmd_action <= VFBC0_IDLE;
			vfbc1_rd_cmd_action <= VFBC1_IDLE;
		end if;
	end process vfbc_trigger;
	
	-- Framebuffer alpha blenders (red/green/blue)
	AlphaBlenderRed : AlphaBlendingMultiplier
	port map(
		clk => clk_25mhz,
		a   => viewport1_red_i,
		b   => viewport1_alpha,
		p	=> viewport1_red_o
	);
	
	AlphaBlenderGreen : AlphaBlendingMultiplier
	port map(
		clk => clk_25mhz,
		a   => viewport1_green_i,
		b   => viewport1_alpha,
		p	=> viewport1_green_o
	);
	
	AlphaBlenderBlue : AlphaBlendingMultiplier
	port map(
		clk => clk_25mhz,
		a   => viewport1_blue_i,
		b   => viewport1_alpha,
		p	=> viewport1_blue_o
	);
	
	-- Alpha blending with bit-duplication (for less quantization error)
	viewport1_red_i(0 to 4)		<= viewport1_red;
	viewport1_red_i(5 to 9)		<= viewport1_red;
	viewport1_green_i(0 to 4)	<= viewport1_green;
	viewport1_green_i(5 to 9)	<= viewport1_green;
	viewport1_blue_i(0 to 4)	<= viewport1_blue;
	viewport1_blue_i(5 to 9)	<= viewport1_blue;

	cathode_red_rendering : process--(clk_25mhz_50p)
	                                (lcl_layer_copper_on, copper_transparent, copper_red,
	                                lcl_layer_viewport0_on, viewport0_transparent, viewport0_red,
									background_red,
									lcl_layer_viewport1_on, viewport1_transparent,
									viewport1_alphainv,
									viewport1_red_o, lcl_timebased_dithering_on,
									vert_pxl, horz_pxl, even_odd_trigger)
	variable red	: std_logic_vector(0 to 4);
	variable hi_red	: std_logic_vector(0 to 3);
	variable f0		: std_logic_vector(0 to 19);
--	variable f1		: std_logic_vector(0 to 19);
	variable bglayer: std_logic_vector(0 to 9);
	begin
--		if rising_edge(clk_25mhz_50p) then
			-- when copper colour
			if lcl_layer_copper_on = '1' and copper_transparent = '0' then
				red := copper_red;
			-- when viewport0 on
			elsif lcl_layer_viewport0_on = '1' and viewport0_transparent = '0' then
				red := viewport0_red;				
			-- when background colour
			else
				red := background_red;
			end if;
			-- calculate alpha blend result
			if lcl_layer_viewport1_on = '1' and viewport1_transparent = '0' then
				-- with bit replication and rounding
				bglayer(0 to 4) := red;
				bglayer(5 to 9) := red;
				f0 := bglayer * viewport1_alphainv;
--				f0 := f0 + "00000000001000000000";
--				f1 := viewport1_red_o + "00000000001000000000";
--				f0 := f0 + f1;
				f0 := f0 + viewport1_red_o; -- replaces above lines
				red := f0(0 to 4);
			end if;
			-- calculate higher luminance level
			if red = "11111" or lcl_timebased_dithering_on = '0' then
				hi_red := red(0 to 3);
			else
				hi_red := red(0 to 3) + red(4);
			end if;
			-- apply time based dithering
			if ((vert_pxl mod 2) = 0 and (horz_pxl mod 2) = 0) or
			   ((vert_pxl mod 2) = 1 and (horz_pxl mod 2) = 1)
			then
				if even_odd_trigger = true then
					cathode_red <= hi_red;
				else
					cathode_red <= red(0 to 3);
				end if;
			else
				if even_odd_trigger = true then
					cathode_red <= red(0 to 3);
				else
					cathode_red <= hi_red;
				end if;
			end if;
--		end if;
	end process cathode_red_rendering;
	
	cathode_green_rendering : process--(clk_25mhz_50p)
	                                  (lcl_layer_copper_on, copper_transparent, copper_green,
	                                  lcl_layer_viewport0_on, viewport0_transparent, viewport0_green,
									  background_green,
									  lcl_layer_viewport1_on, viewport1_transparent,
									  viewport1_alphainv,
									  viewport1_green_o, lcl_timebased_dithering_on,
									  vert_pxl, horz_pxl, even_odd_trigger)
	variable green    : std_logic_vector(0 to 4);
	variable hi_green : std_logic_vector(0 to 3);
	variable bglayer  : std_logic_vector(0 to 9);
	variable f0		  : std_logic_vector(0 to 19);
--	variable f1		  : std_logic_vector(0 to 19);
	begin
--		if rising_edge(clk_25mhz_50p) then
			-- when copper colour
			if lcl_layer_copper_on = '1' and copper_transparent = '0' then
				green := copper_green;
			-- when viewport0
			elsif lcl_layer_viewport0_on = '1' and viewport0_transparent = '0' then
				green := viewport0_green;
			-- when background colour
			else
				green := background_green;
			end if;
			-- calculate alpha blend
			if lcl_layer_viewport1_on = '1' and viewport1_transparent = '0' then
				-- with bit replication and rounding
				bglayer(0 to 4) := green;
				bglayer(5 to 9) := green;
				f0 := bglayer * viewport1_alphainv;
--				f0 := f0 + "00000000001000000000";
--				f1 := viewport1_green_o + "00000000001000000000";
--				f0 := f0 + f1;
				f0 := f0 + viewport1_green_o; -- replaces above lines
				green := f0(0 to 4);
			end if;
			-- calculate higher luminance level
			if green = "11111" or lcl_timebased_dithering_on = '0' then
				hi_green := green(0 to 3);
			else
				hi_green := green(0 to 3) + green(4);
			end if;
			-- apply time based dithering
			if ((vert_pxl mod 2) = 0 and (horz_pxl mod 2) = 0) or
			   ((vert_pxl mod 2) = 1 and (horz_pxl mod 2) = 1)
			then
				if even_odd_trigger = true then
					cathode_green <= hi_green;
				else
					cathode_green <= green(0 to 3);
				end if;
			else
				if even_odd_trigger = true then
					cathode_green <= green(0 to 3);
				else
					cathode_green <= hi_green;
				end if;
			end if;
--		end if;
	end process cathode_green_rendering;

--	cathode_blue_rendering : process(clk_25mhz)
--	variable blue     : std_logic_vector(0 to 4);
--	variable hi_blue  : std_logic_vector(0 to 3);
--	variable bglayer  : std_logic_vector(0 to 9);
--	variable f0		  : std_logic_vector(0 to 19);
----	variable f1		  : std_logic_vector(0 to 19);
--	begin
--		if rising_edge(clk_25mhz) then
--			-- when copper colour
--			if lcl_layer_copper_on = '1' and copper_transparent = '0' then
--				blue := copper_blue;
--			-- when viewport0 on
--			elsif lcl_layer_viewport0_on = '1' and viewport0_transparent = '0' then
--				blue := viewport0_blue;
--			-- when background colour
--			else
--				blue := background_blue;
--			end if;
--			-- calculate alpha blend
--			if lcl_layer_viewport1_on = '1' and viewport1_transparent = '0' then
--				-- with bit replication and rounding
--				bglayer(0 to 4) := blue;
--				bglayer(5 to 9) := blue;
--				f0 := bglayer * viewport1_alphainv;
----				f0 := f0 + "00000000001000000000";
----				f1 := viewport1_blue_o + "00000000001000000000";
----				f0 := f0 + f1;
--				f0 := f0 + viewport1_blue_o; -- replaces above lines
--				blue := f0(0 to 4);
--			end if;
--			-- calculate higher luminance level
--			if blue = "11111" or lcl_timebased_dithering_on = '0' then
--				hi_blue := blue(0 to 3);
--			else
--				hi_blue := blue(0 to 3) + blue(4);
--			end if;
--			-- apply time based dithering
--			if ((vert_pxl mod 2) = 0 and (horz_pxl mod 2) = 0) or
--			   ((vert_pxl mod 2) = 1 and (horz_pxl mod 2) = 1)
--			then
--				if even_odd_trigger = true then
--					cathode_blue  <= hi_blue;
--				else
--					cathode_blue  <= blue(0 to 3);					
--				end if;
--			else
--				if even_odd_trigger = true then
--					cathode_blue  <= blue(0 to 3);
--				else
--					cathode_blue  <= hi_blue;
--				end if;
--			end if;
--		end if;
--	end process cathode_blue_rendering;

	cathode_blue_rendering : process--(clk_25mhz_50p)
									(lcl_layer_copper_on, copper_transparent, copper_blue,
	                                 lcl_layer_viewport0_on, viewport0_transparent, viewport0_blue,
									 background_blue,
									 lcl_layer_viewport1_on, viewport1_transparent,
									 viewport1_alphainv,
									 viewport1_blue_o, lcl_timebased_dithering_on,
									 vert_pxl, horz_pxl, even_odd_trigger)
	variable blue     : std_logic_vector(0 to 4);
	variable hi_blue  : std_logic_vector(0 to 3);
	variable bglayer  : std_logic_vector(0 to 9);
	variable f0		  : std_logic_vector(0 to 19);
--	variable f1		  : std_logic_vector(0 to 19);
	begin
--		if rising_edge(clk_25mhz_50p) then
			-- when copper colour
			if lcl_layer_copper_on = '1' and copper_transparent = '0' then
				blue := copper_blue;
			-- when viewport0 on
			elsif lcl_layer_viewport0_on = '1' and viewport0_transparent = '0' then
				blue := viewport0_blue;
			-- when background colour
			else
				blue := background_blue;
			end if;
			-- calculate alpha blend
			if lcl_layer_viewport1_on = '1' and viewport1_transparent = '0' then
				-- with bit replication and rounding
				bglayer(0 to 4) := blue;
				bglayer(5 to 9) := blue;
				f0 := bglayer * viewport1_alphainv;
--				f0 := f0 + "00000000001000000000";
--				f1 := viewport1_blue_o + "00000000001000000000";
--				f0 := f0 + f1;
				f0 := f0 + viewport1_blue_o; -- replaces above lines
				blue := f0(0 to 4);			
			end if;
			-- calculate higher luminance level
			if blue = "11111" or lcl_timebased_dithering_on = '0' then
				hi_blue := blue(0 to 3);
			else
				hi_blue := blue(0 to 3) + blue(4);
			end if;
			-- apply time based dithering
			if ((vert_pxl mod 2) = 0 and (horz_pxl mod 2) = 0) or
			   ((vert_pxl mod 2) = 1 and (horz_pxl mod 2) = 1)
			then
				if even_odd_trigger = true then
					cathode_blue  <= hi_blue;
				else
					cathode_blue  <= blue(0 to 3);					
				end if;
			else
				if even_odd_trigger = true then
					cathode_blue  <= blue(0 to 3);
				else
					cathode_blue  <= hi_blue;
				end if;
			end if;
--		end if;
	end process cathode_blue_rendering;
	
	CopperMemoryInst : CopperMemory
	port map (
		clka	=> clk_25mhz,
		wea		=> copper_memory_write_enable,
		addra	=> copper_memory_write_address,
		dina	=> copper_memory_write_data,
		clkb	=> clk_25mhz,
		addrb	=> copper_memory_read_address,
		doutb	=> copper_memory_read_data
	);
	
	CopperEffectInst : CopperEffect
	port map (
		clka	=> clk_25mhz,
		wea		=> copper_effect_write_enable,
		addra	=> copper_effect_write_address,
		dina	=> copper_effect_write_data,
		clkb	=> clk_25mhz,
		addrb	=> copper_effect_read_address,
		doutb	=> copper_effect_read_data
	);
		
	-- E MMMMMMMMMMMMMMMM
	--   1111110000000000
	-- 0 5432109876543210
	
	-- 0 GGGBBBBB0RRRRRGG copper colour
	-- 1 GGGBBBBB0RRRRRGG background colour
	-- 0 0000000010000000 transparent
	-- 1 GGGBBBBB1RRRRRGG copper colour and alpha blend set to zero
	-- 0 xxxAAAAA110xxxxx relative alpha blend value
	-- 0 xxxAAAAA111xxxxx absolute alpha blend value

	copper_memory_read_address <= CONV_STD_LOGIC_VECTOR(vert_pxl, 9);
	copper_effect_read_address <= CONV_STD_LOGIC_VECTOR(vert_pxl, 9);
	
	copper_background : process(lcl_layer_copper_on,
								copper_effect_read_data,
								copper_memory_read_data,
								lcl_background_colour)
	begin
		if lcl_layer_copper_on = '1' and
           copper_effect_read_data(0) = '1' and
           copper_memory_read_data(7) = '0' then
			background_red		<= copper_memory_read_data(6 downto 2);
			background_green	<= copper_memory_read_data(1 downto 0) &
								   copper_memory_read_data(15 downto 13);
			background_blue		<= copper_memory_read_data(12 downto 8);
		else
			background_red      <= lcl_background_colour(0 to 4);
			background_green	<= lcl_background_colour(5 to 9);
			background_blue		<= lcl_background_colour(10 to 14);
		end if;
	end process copper_background;
	
	copper_alpha : process(lcl_viewport1_alpha,
						   lcl_viewport1_alphainv,
						   lcl_layer_copper_on,
						   copper_memory_read_data,
						   copper_effect_read_data)
	variable tmp : std_logic_vector(0 to 4);
	begin
		viewport1_alpha		<= lcl_viewport1_alpha;
		viewport1_alphainv	<= lcl_viewport1_alphainv;
		if lcl_layer_copper_on = '1' and copper_memory_read_data(7) = '1' then
			if copper_effect_read_data(0) = '1' then
				viewport1_alpha		<= "0000000000";
				viewport1_alphainv	<= "1111111111";
			elsif copper_memory_read_data(6) = '1' then
				if copper_memory_read_data(5) = '1' then
					viewport1_alpha(5 to 9) <= copper_memory_read_data(12 downto 8);
					viewport1_alpha(0 to 4) <= copper_memory_read_data(12 downto 8);
					viewport1_alphainv(5 to 9) <= "11111" - copper_memory_read_data(12 downto 8);
					viewport1_alphainv(0 to 4) <= "11111" - copper_memory_read_data(12 downto 8);
				else
					if copper_memory_read_data(12 downto 8) > lcl_viewport1_alpha(5 to 9) then
						tmp := lcl_viewport1_alpha(5 to 9) - copper_memory_read_data(12 downto 8);
						viewport1_alpha(5 to 9) <= tmp;
						viewport1_alpha(0 to 4) <= tmp;
						viewport1_alphainv(5 to 9) <= "11111" - tmp;
						viewport1_alphainv(0 to 4) <= "11111" - tmp;
					else
						viewport1_alpha <= (others => '0');
						viewport1_alphainv <= (others => '1');
					end if;
				end if;
			end if;
		end if;
	end process copper_alpha;
	
	copper_renderer : process(copper_memory_read_data,
                              lcl_layer_copper_on,
							  copper_effect_read_data)
	begin
		copper_red 			<= copper_memory_read_data(6 downto 2);
		copper_green		<= copper_memory_read_data(1 downto 0) &
							   copper_memory_read_data(15 downto 13);
		copper_blue			<= copper_memory_read_data(12 downto 8);
		if lcl_layer_copper_on = '1' then
			if (copper_effect_read_data(0) = '0' and copper_memory_read_data(7) = '0') or
			   (copper_effect_read_data(0) = '1' and copper_memory_read_data(7) = '1') then
				copper_transparent <= '0';
			else
				copper_transparent <= '1';
			end if;
		else
			copper_transparent <= '1';
		end if;
	end process copper_renderer;

	copper_address : process(lcl_copperlist_address,
							 copper_base_address,
							 copper_read_next_address,
							 copper_next_address,
							 copper_current_address)
	variable reg_current : std_logic_vector(0 to 31);
	variable reg_base    : std_logic_vector(0 to 31);
	begin
		if copper_base_address /= lcl_copperlist_address then
			copper_current_address <= lcl_copperlist_address;
			copper_base_address <= lcl_copperlist_address;
			reg_current := lcl_copperlist_address;
			reg_base := lcl_copperlist_address;
		elsif copper_read_next_address = true then
			copper_current_address <= copper_next_address;
			reg_current := copper_next_address;
			copper_base_address <= reg_base; -- generates latch
		else
			copper_current_address <= reg_current; -- generates latch
			copper_base_address <= reg_base; -- generates latch
		end if;
	end process copper_address;

	viewport0_renderer : process(lcl_layer_viewport0_on,
								 vert_dsp, viewport0_sy_begin, viewport0_sy_end,
								 horz_dsp, viewport0_sx_begin, viewport0_sx_end,
								 VFBC0_Rd_Data)
	variable data : std_logic_vector(15 downto 0);
	constant OFFSET : natural := 0;
	begin
		VFBC0_Rd_Read <= '0'; -- start the read process one tick before actual reading
		viewport0_transparent <= '1';
		viewport0_red <= "00000";
		viewport0_green <= "00000";
		viewport0_blue <= "00000";
		
		if lcl_layer_viewport0_on = '1' and vert_dsp >= viewport0_sy_begin and vert_dsp < viewport0_sy_end then
			if horz_dsp = (viewport0_sx_begin - OFFSET - 1) then
				VFBC0_Rd_Read <= '1'; -- start the read process one tick before actual reading
			elsif horz_dsp >= (viewport0_sx_begin - OFFSET) and
                  horz_dsp <= (viewport0_sx_end - OFFSET - 2) then
				VFBC0_Rd_Read <= '1';
				data := VFBC0_Rd_Data;
				viewport0_transparent <= data(7);
				viewport0_red <= data(6 downto 2);
				viewport0_green <= data(1 downto 0) & data(15 downto 13);
				viewport0_blue <= data(12 downto 8);
			elsif horz_dsp = (viewport0_sx_end - OFFSET - 1) then
				VFBC0_Rd_Read <= '0';
				data := VFBC0_Rd_Data;
				viewport0_transparent <= data(7);
				viewport0_red <= data(6 downto 2);
				viewport0_green <= data(1 downto 0) & data(15 downto 13);
				viewport0_blue <= data(12 downto 8);			
			else
				VFBC0_Rd_Read <= '0'; -- must change to viewport border colour later
				viewport0_transparent <= '1';
				viewport0_red <= "00000";
				viewport0_green <= "00000";
				viewport0_blue <= "00000";
			end if;
		end if;
	end process viewport0_renderer;

	VFBC0_Cmd_Clk <= clk_25mhz;	
	VFBC0_Rd_Clk <= clk_25mhz;
	VFBC0_Rd_End_Burst <= '0';
	
	vfbc0_rd_cmdstate_current <= vfbc0_rd_cmdstate_next when rising_edge(clk_25mhz);
	
	vfbc0_viewport0_cmd_control : process (vfbc0_rd_cmd_action,
										   vfbc0_rd_cmdstate_current,
										   lcl_viewport0_width,
										   lcl_canvas0_address,
										   lcl_viewport0_height,
										   lcl_canvas0_width)
	begin
		case vfbc0_rd_cmdstate_current is
			when VFBCCMD_IDLE =>
				if vfbc0_rd_cmd_action = VFBC0_LOAD_VIEWPORT then
					VFBC0_Cmd_Data(31 downto 15) <= (others => '0');
					-- X-SIZE (must be multiple of 128 bytes)
					VFBC0_Cmd_Data(14 downto  0) <= lcl_viewport0_width(18 to 31) & "0";
					VFBC0_Cmd_Write				 <= '1';
					vfbc0_rd_cmdstate_next		 <= VFBCCMD_W0;
				else
					VFBC0_Cmd_Data				 <= (others => '0');
					VFBC0_Cmd_Write				 <= '0';
					vfbc0_rd_cmdstate_next		 <= VFBCCMD_IDLE;
				end if;
			when VFBCCMD_W0 =>
				VFBC0_Cmd_Data(31)				<= '0'; -- read
				VFBC0_Cmd_Data(30 downto 0)		<= lcl_canvas0_address(1 to 31);
				VFBC0_Cmd_Write					<= '1';
				vfbc0_rd_cmdstate_next			<= VFBCCMD_W1;
			when VFBCCMD_W1 =>
				VFBC0_Cmd_Data(31 downto 24)	<= (others =>'0');
				-- Y-SIZE (lines minus one)
				VFBC0_Cmd_Data(23 downto  0)	<= lcl_viewport0_height(8 to 31) - 1;
				VFBC0_Cmd_Write					<= '1';
				vfbc0_rd_cmdstate_next			<= VFBCCMD_W2;
			when VFBCCMD_W2 =>
				VFBC0_Cmd_Data(31 downto 24)	<= (others => '0');
				-- STRIDE (must be multiple of 128 bytes)
				VFBC0_Cmd_Data(23 downto  0)	<= lcl_canvas0_width(9 to 31) & "0";
				VFBC0_Cmd_Write					<= '1';
				vfbc0_rd_cmdstate_next			<= VFBCCMD_W3;
			when VFBCCMD_W3 =>
				VFBC0_Cmd_Data					<= (others => '0');
				VFBC0_Cmd_Write					<= '0';
				vfbc0_rd_cmdstate_next			<= VFBCCMD_IDLE;
		end case;
	end process vfbc0_viewport0_cmd_control;

	viewport1_transparent    <= viewport1_transparent_d0 when rising_edge(clk_25mhz);
	
	VFBC1_Rd_Read <= vfbc1_copper_rd_read or vfbc1_viewport1_rd_read;
	
	copper_reader : process(clk_25mhz)
	variable next_address : std_logic_vector(0 to 31);
	begin
		if rising_edge(clk_25mhz) then
			copper_read_next_address <= false;
			copper_memory_write_enable <= "0";
			copper_memory_write_address <= (others => '0');
			copper_memory_write_data <= (others => '0');
			copper_effect_write_enable <= "0";
			copper_effect_write_address <= (others => '0');
			copper_effect_write_data <= (others => '0');

			if lcl_layer_copper_on = '1' and vert_dsp = VERTICAL_VISIBLE_AREA_START - 9 then
				if horz_dsp = 1 then
					vfbc1_copper_rd_read <= '1';
				elsif horz_dsp <= 481 then
					vfbc1_copper_rd_read <= '1';
					copper_memory_write_enable <= "1";
					copper_memory_write_address <= CONV_STD_LOGIC_VECTOR(horz_dsp - 2, 9);
					copper_memory_write_data <= VFBC1_Rd_Data;
				elsif horz_dsp <= 511 then
					vfbc1_copper_rd_read <= '1';
					copper_effect_write_enable <= "1";
					copper_effect_write_address <= CONV_STD_LOGIC_VECTOR(horz_dsp - 482, 5);
					copper_effect_write_data(0) <= VFBC1_Rd_Data(7);
					copper_effect_write_data(1) <= VFBC1_Rd_Data(6);
					copper_effect_write_data(2) <= VFBC1_Rd_Data(5);
					copper_effect_write_data(3) <= VFBC1_Rd_Data(4);
					copper_effect_write_data(4) <= VFBC1_Rd_Data(3);
					copper_effect_write_data(5) <= VFBC1_Rd_Data(2);
					copper_effect_write_data(6) <= VFBC1_Rd_Data(1);
					copper_effect_write_data(7) <= VFBC1_Rd_Data(0);
					copper_effect_write_data(8) <= VFBC1_Rd_Data(15);
					copper_effect_write_data(9) <= VFBC1_Rd_Data(14);
					copper_effect_write_data(10) <= VFBC1_Rd_Data(13);
					copper_effect_write_data(11) <= VFBC1_Rd_Data(12);
					copper_effect_write_data(12) <= VFBC1_Rd_Data(11);
					copper_effect_write_data(13) <= VFBC1_Rd_Data(10);
					copper_effect_write_data(14) <= VFBC1_Rd_Data(9);
					copper_effect_write_data(15) <= VFBC1_Rd_Data(8);
				elsif horz_dsp = 512 then
					vfbc1_copper_rd_read <= '1';
					next_address(8 to 15) := VFBC1_Rd_Data(15 downto 8);
					next_address(0 to  7) := VFBC1_Rd_Data(7 downto 0);
				elsif horz_dsp = 513 then
					vfbc1_copper_rd_read <= '0';
					next_address(24 to 31) := VFBC1_Rd_Data(15 downto 8);
					next_address(16 to 23) := VFBC1_Rd_Data(7 downto 0);
					copper_next_address <= next_address;
					if next_address /= 0 then
						copper_read_next_address <= true;
					end if;
				end if;
			end if;
		end if;
	end process copper_reader;
	
	viewport1_renderer : process(lcl_layer_viewport1_on, vert_dsp, horz_dsp,
                                 VFBC1_Rd_Data,
								 viewport1_sx_begin, viewport1_sx_end,
								 viewport1_sy_begin, viewport1_sy_end)
	variable data : std_logic_vector(15 downto 0);
	constant OFFSET : natural := 1;
	begin
		viewport1_transparent_d0 <= '1';
		viewport1_red <= "00000";
		viewport1_green <= "00000";
		viewport1_blue <= "00000";
		vfbc1_viewport1_rd_read <= '0';

		if lcl_layer_viewport1_on = '1' and vert_dsp >= viewport1_sy_begin and vert_dsp < viewport1_sy_end then
			if horz_dsp = viewport1_sx_begin - OFFSET - 1 then
				vfbc1_viewport1_rd_read <= '1'; -- start the read process one tick before actual reading
			elsif horz_dsp >= (viewport1_sx_begin - OFFSET) and
                  horz_dsp <= (viewport1_sx_end - OFFSET) - 2 then
				vfbc1_viewport1_rd_read <= '1';
				data := VFBC1_Rd_Data;
				viewport1_transparent_d0 <= data(7);
				viewport1_red <= data(6 downto 2);
				viewport1_green <= data(1 downto 0) & data(15 downto 13);
				viewport1_blue <= data(12 downto 8);
			elsif horz_dsp = (viewport1_sx_end - OFFSET) - 1 then
				vfbc1_viewport1_rd_read <= '0';
				data := VFBC1_Rd_Data;
				viewport1_transparent_d0 <= data(7);
				viewport1_red <= data(6 downto 2);
				viewport1_green <= data(1 downto 0) & data(15 downto 13);
				viewport1_blue <= data(12 downto 8);			
			else
				vfbc1_viewport1_rd_read <= '0'; -- must change to viewport border colour later
				viewport1_transparent_d0 <= '1';
				viewport1_red <= "00000";
				viewport1_green <= "00000";
				viewport1_blue <= "00000";
			end if;
		end if;
	end process viewport1_renderer;

--	viewport1_renderer : process--(clk_25mhz)
--								(lcl_layer_copper_on, vert_dsp, horz_dsp,
--                                 VFBC1_Rd_Data, lcl_layer_viewport1_on,
--								 viewport1_sx_begin, viewport1_sx_end,
--								 viewport1_sy_begin, viewport1_sy_end)
--	variable data : std_logic_vector(15 downto 0);
--	variable next_address : std_logic_vector(0 to 31);
--	constant OFFSET : natural := 1;
--	begin
----		if rising_edge(clk_25mhz) then
--			copper_read_next_address <= false;
--			viewport1_transparent_d0 <= '1';
--			viewport1_red <= "00000";
--			viewport1_green <= "00000";
--			viewport1_blue <= "00000";
--			copper_memory_write_enable <= "0";
--			copper_memory_write_address <= (others => '0');
--			copper_memory_write_data <= (others => '0');
--			copper_effect_write_enable <= "0";
--			copper_effect_write_address <= (others => '0');
--			copper_effect_write_data <= (others => '0');
--			VFBC1_Rd_Read <= '0';
--
--			if lcl_layer_copper_on = '1' and vert_dsp = VERTICAL_VISIBLE_AREA_START - 9 then
--				if horz_dsp = 1 then
--					VFBC1_Rd_Read <= '1';
--				elsif horz_dsp <= 481 then
--					VFBC1_Rd_Read <= '1';
--					copper_memory_write_enable <= "1";
--					copper_memory_write_address <= CONV_STD_LOGIC_VECTOR(horz_dsp - 2, 9);
--					copper_memory_write_data <= VFBC1_Rd_Data;
--				elsif horz_dsp <= 511 then
--					VFBC1_Rd_Read <= '1';					
--					copper_effect_write_enable <= "1";
--					copper_effect_write_address <= CONV_STD_LOGIC_VECTOR(horz_dsp - 482, 5);
--					copper_effect_write_data(0) <= VFBC1_Rd_Data(7);
--					copper_effect_write_data(1) <= VFBC1_Rd_Data(6);
--					copper_effect_write_data(2) <= VFBC1_Rd_Data(5);
--					copper_effect_write_data(3) <= VFBC1_Rd_Data(4);
--					copper_effect_write_data(4) <= VFBC1_Rd_Data(3);
--					copper_effect_write_data(5) <= VFBC1_Rd_Data(2);
--					copper_effect_write_data(6) <= VFBC1_Rd_Data(1);
--					copper_effect_write_data(7) <= VFBC1_Rd_Data(0);
--					copper_effect_write_data(8) <= VFBC1_Rd_Data(15);
--					copper_effect_write_data(9) <= VFBC1_Rd_Data(14);
--					copper_effect_write_data(10) <= VFBC1_Rd_Data(13);
--					copper_effect_write_data(11) <= VFBC1_Rd_Data(12);
--					copper_effect_write_data(12) <= VFBC1_Rd_Data(11);
--					copper_effect_write_data(13) <= VFBC1_Rd_Data(10);
--					copper_effect_write_data(14) <= VFBC1_Rd_Data(9);
--					copper_effect_write_data(15) <= VFBC1_Rd_Data(8);
--				elsif horz_dsp = 512 then
--					VFBC1_Rd_Read <= '1';
--					next_address(8 to 15) := VFBC1_Rd_Data(15 downto 8);
--					next_address(0 to  7) := VFBC1_Rd_Data(7 downto 0);
--				elsif horz_dsp = 513 then
--					VFBC1_Rd_Read <= '0';
--					next_address(24 to 31) := VFBC1_Rd_Data(15 downto 8);
--					next_address(16 to 23) := VFBC1_Rd_Data(7 downto 0);
--					copper_next_address <= next_address;
--					if next_address /= 0 then
--						copper_read_next_address <= true;
--					end if;
--				end if;
--			elsif lcl_layer_viewport1_on = '1' and
--                  vert_dsp >= viewport1_sy_begin and
--            	  vert_dsp < viewport1_sy_end then
--					if horz_dsp = viewport1_sx_begin - OFFSET - 1 then
--						VFBC1_Rd_Read <= '1'; -- start the read process one tick before actual reading
--					elsif horz_dsp >= (viewport1_sx_begin - OFFSET) and
--                          horz_dsp <= (viewport1_sx_end - OFFSET) - 2 then
--						VFBC1_Rd_Read <= '1';
--						data := VFBC1_Rd_Data;
--						viewport1_transparent_d0 <= data(7);
--						viewport1_red <= data(6 downto 2);
--						viewport1_green <= data(1 downto 0) & data(15 downto 13);
--						viewport1_blue <= data(12 downto 8);
--					elsif horz_dsp = (viewport1_sx_end - OFFSET) - 1 then
--						VFBC1_Rd_Read <= '0';
--						data := VFBC1_Rd_Data;
--						viewport1_transparent_d0 <= data(7);
--						viewport1_red <= data(6 downto 2);
--						viewport1_green <= data(1 downto 0) & data(15 downto 13);
--						viewport1_blue <= data(12 downto 8);			
--					else
--						VFBC1_Rd_Read <= '0'; -- must change to viewport border colour later
--						viewport1_transparent_d0 <= '1';
--						viewport1_red <= "00000";
--						viewport1_green <= "00000";
--						viewport1_blue <= "00000";
--					end if;
--			end if;
----		end if;
--	end process viewport1_renderer;
	
	VFBC1_Cmd_Clk <= clk_25mhz;	
	VFBC1_Rd_Clk <= clk_25mhz;
	VFBC1_Rd_End_Burst <= '0';

	vfbc1_viewport1_cmd_control : process (clk_25mhz)
	variable xsize		: std_logic_vector(14 downto 0);
	variable ysize		: std_logic_vector(23 downto 0);
	variable stride		: std_logic_vector(23 downto 0);
	variable address	: std_logic_vector(30 downto 0);
	begin
		if rising_edge(clk_25mhz) then
			case vfbc1_rd_cmdstate_current is
				when VFBCCMD_IDLE =>
					if vfbc1_rd_cmd_action /= VFBC1_IDLE then
						case vfbc1_rd_cmd_action is
							when VFBC1_LOAD_VIEWPORT =>
								xsize   := lcl_viewport1_width(18 to 31) & "0";
								ysize   := lcl_viewport1_height(8 to 31) - 1;
								stride  := lcl_canvas1_width(9 to 31) & "0";
								address := lcl_canvas1_address(1 to 31);
							when VFBC1_LOAD_COPPER =>
								xsize   := "000010000000000"; -- 1024 byte
								ysize   := "000000000000000000000000";
								stride  := "000000000000010000000000";
								address := copper_current_address(1 to 31);
							when others => null;
						end case;
						VFBC1_Cmd_Data(31 downto 15) <= (others => '0');
						VFBC1_Cmd_Data(14 downto  0) <= xsize;
						VFBC1_Cmd_Write				 <= '1';
						vfbc1_rd_cmdstate_current	 <= VFBCCMD_W0;
					else
						VFBC1_Cmd_Data				 <= (others => '0');
						VFBC1_Cmd_Write				 <= '0';
						vfbc1_rd_cmdstate_current	 <= VFBCCMD_IDLE;
					end if;
				when VFBCCMD_W0 =>
					VFBC1_Cmd_Data(31)				<= '0'; -- read
					VFBC1_Cmd_Data(30 downto 0)		<= address;
					VFBC1_Cmd_Write					<= '1';
					vfbc1_rd_cmdstate_current		<= VFBCCMD_W1;
				when VFBCCMD_W1 =>
					VFBC1_Cmd_Data(31 downto 24)	<= (others =>'0');
					VFBC1_Cmd_Data(23 downto  0)	<= ysize;
					VFBC1_Cmd_Write					<= '1';
					vfbc1_rd_cmdstate_current		<= VFBCCMD_W2;
				when VFBCCMD_W2 =>
					VFBC1_Cmd_Data(31 downto 24)	<= (others => '0');
					VFBC1_Cmd_Data(23 downto  0)	<= stride;
					VFBC1_Cmd_Write					<= '1';
					vfbc1_rd_cmdstate_current		<= VFBCCMD_W3;
				when VFBCCMD_W3 =>
					VFBC1_Cmd_Data					<= (others => '0');
					VFBC1_Cmd_Write					<= '0';
					vfbc1_rd_cmdstate_current		<= VFBCCMD_IDLE;
				when others =>
					VFBC1_Cmd_Data					<= (others => '0');
					VFBC1_Cmd_Write					<= '0';
					vfbc1_rd_cmdstate_current		<= VFBCCMD_IDLE;
			end case;
		end if;
	end process vfbc1_viewport1_cmd_control;

end IMP;
