##############################################################################
## Filename:          C:\Projects\EDK_Trial_3/drivers/audio_controller_v1_00_a/data/audio_controller_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sat Jan 30 14:16:36 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "audio_controller" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
