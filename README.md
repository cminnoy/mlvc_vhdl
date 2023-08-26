# mlvc_vhdl
Multi Layer Video Controller in VHDL for Spartan 3AN

This is the repository of the final thesis project I made for my degree in Electronics (2010).
It shows how to build a VGA video controller on a Xilinx FPGA model Spartan3AN (Starter Kit).

It was made using the Xilinx EDK, ISE/XPS.

The controller is able to display a 640x480 image on the VGA output of the board.
The devboard supports 4096 color output from hardware side.

Notes:
  - Supports two frame buffers of arbitrary size in DRAM that can be arbitrary blended to allow smooth transitions between images.
  - has viewports on those frame buffers (max 640x480)
  - time based dithering technique to give the optical illusion of 32k colors.
  - 'Amiga Copper' like co-processor that allows to draw colour/transparency bars on the screen independent of the main CPU
  - A limited by usefull C++ API to interact with the video controller from the Microblaze CPU.
  - uses 2 VFBC busses
  - uses the Microblaze softcore as main CPU

Paths of interest:
EDK\pcores\vga_control_v1_00_a\hdl\vhdl
EDK\hdl
SDK
