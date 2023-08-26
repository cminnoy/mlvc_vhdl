/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/vga_control_v1_00_a/src/vga_control.c
* Version:           1.00.a
* Description:       vga_control Driver Source File
* Date:              Sat Dec 12 15:16:05 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "vga_control.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from VGA_CONTROL device.
 *
 * @param   baseaddr_p is the base address of the VGA_CONTROL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void VGA_CONTROL_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  VGA_CONTROL_mWriteReg(baseaddr, VGA_CONTROL_INTR_IPIER_OFFSET, 0x00000003);

  /*
   * Set global interrupt enable.
   */
  VGA_CONTROL_mWriteReg(baseaddr, VGA_CONTROL_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for VGA_CONTROL device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the VGA_CONTROL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void VGA_CONTROL_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = VGA_CONTROL_mReadReg(baseaddr, VGA_CONTROL_INTR_IPISR_OFFSET);
    VGA_CONTROL_mWriteReg(baseaddr, VGA_CONTROL_INTR_IPISR_OFFSET, IpStatus);
  }

}

