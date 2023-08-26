/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/audio_controller_v1_00_a/src/audio_controller.c
* Version:           1.00.a
* Description:       audio_controller Driver Source File
* Date:              Sat Jan 30 14:16:37 2010 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "audio_controller.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from AUDIO_CONTROLLER device.
 *
 * @param   baseaddr_p is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void AUDIO_CONTROLLER_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  AUDIO_CONTROLLER_mWriteReg(baseaddr, AUDIO_CONTROLLER_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Set global interrupt enable.
   */
  AUDIO_CONTROLLER_mWriteReg(baseaddr, AUDIO_CONTROLLER_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for AUDIO_CONTROLLER device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void AUDIO_CONTROLLER_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = AUDIO_CONTROLLER_mReadReg(baseaddr, AUDIO_CONTROLLER_INTR_IPISR_OFFSET);
    AUDIO_CONTROLLER_mWriteReg(baseaddr, AUDIO_CONTROLLER_INTR_IPISR_OFFSET, IpStatus);
  }

}

