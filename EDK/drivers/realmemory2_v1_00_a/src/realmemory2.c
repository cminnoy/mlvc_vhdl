/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/realmemory2_v1_00_a/src/realmemory2.c
* Version:           1.00.a
* Description:       realmemory2 Driver Source File
* Date:              Sun Dec 20 14:35:04 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "realmemory2.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from REALMEMORY2 device.
 *
 * @param   baseaddr_p is the base address of the REALMEMORY2 device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void REALMEMORY2_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  REALMEMORY2_mWriteReg(baseaddr, REALMEMORY2_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Set global interrupt enable.
   */
  REALMEMORY2_mWriteReg(baseaddr, REALMEMORY2_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for REALMEMORY2 device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the REALMEMORY2 device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void REALMEMORY2_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = REALMEMORY2_mReadReg(baseaddr, REALMEMORY2_INTR_IPISR_OFFSET);
    REALMEMORY2_mWriteReg(baseaddr, REALMEMORY2_INTR_IPISR_OFFSET, IpStatus);
  }

}

