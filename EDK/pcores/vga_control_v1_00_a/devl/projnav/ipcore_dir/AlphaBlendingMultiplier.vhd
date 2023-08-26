--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2009 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file AlphaBlendingMultiplier.vhd when simulating
-- the core, AlphaBlendingMultiplier. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY AlphaBlendingMultiplier IS
	port (
	a: IN std_logic_VECTOR(9 downto 0);
	b: IN std_logic_VECTOR(9 downto 0);
	p: OUT std_logic_VECTOR(19 downto 0));
END AlphaBlendingMultiplier;

ARCHITECTURE AlphaBlendingMultiplier_a OF AlphaBlendingMultiplier IS
-- synthesis translate_off
component wrapped_AlphaBlendingMultiplier
	port (
	a: IN std_logic_VECTOR(9 downto 0);
	b: IN std_logic_VECTOR(9 downto 0);
	p: OUT std_logic_VECTOR(19 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_AlphaBlendingMultiplier use entity XilinxCoreLib.mult_gen_v11_2(behavioral)
		generic map(
			c_a_width => 10,
			c_b_type => 1,
			c_ce_overrides_sclr => 0,
			c_has_sclr => 0,
			c_round_pt => 0,
			c_model_type => 0,
			c_out_high => 19,
			c_verbosity => 0,
			c_mult_type => 1,
			c_ccm_imp => 0,
			c_latency => 0,
			c_has_ce => 0,
			c_has_zero_detect => 0,
			c_round_output => 0,
			c_optimize_goal => 0,
			c_xdevicefamily => "spartan3a",
			c_a_type => 1,
			c_out_low => 0,
			c_b_width => 10,
			c_b_value => "10000001");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_AlphaBlendingMultiplier
		port map (
			a => a,
			b => b,
			p => p);
-- synthesis translate_on

END AlphaBlendingMultiplier_a;

