##############################################################################
## Filename:          C:\Projects\EDK_Trial_3/drivers/realmemory_example_v1_00_a/data/realmemory_example_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Dec 20 14:24:11 2009 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "realmemory_example" "NUM_INSTANCES" "DEVICE_ID" "C_MEM0_BASEADDR" "C_MEM0_HIGHADDR" 
}
