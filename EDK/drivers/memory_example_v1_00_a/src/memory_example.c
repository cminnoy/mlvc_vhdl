/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/memory_example_v1_00_a/src/memory_example.c
* Version:           1.00.a
* Description:       memory_example Driver Source File
* Date:              Sat Dec 19 21:26:28 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "memory_example.h"

/************************** Function Definitions ***************************/


/**
 *
 * User logic master module to send/receive bytes to/from remote system memory.
 * While sending, the bytes are read from user logic local FIFO and write to remote system memory.
 * While receiving, the bytes are read from remote system memory and write to user logic local FIFO.
 *
 * @param   BaseAddress is the base address of the MEMORY_EXAMPLE device.
 * @param   DstAddress is the destination system memory address from/to which the data will be fetched/stored.
 * @param   Size is the number of bytes to be sent.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void MEMORY_EXAMPLE_MasterSendByte(Xuint32 BaseAddress, Xuint32 DstAddress, int Size)
{
  /*
   * Set user logic master control register for write transfer.
   */
  XIo_Out8(BaseAddress+MEMORY_EXAMPLE_MST_CNTL_REG_OFFSET, MST_BRWR);

  /*
   * Set user logic master address register to drive IP2Bus_Mst_Addr signal.
   */
  XIo_Out32(BaseAddress+MEMORY_EXAMPLE_MST_ADDR_REG_OFFSET, DstAddress);

  /*
   * Set user logic master byte enable register to drive IP2Bus_Mst_BE signal.
   */
  XIo_Out16(BaseAddress+MEMORY_EXAMPLE_MST_BE_REG_OFFSET, 0xFFFF);

  /*
   * Set user logic master length register.
   */
  XIo_Out16(BaseAddress+MEMORY_EXAMPLE_MST_LEN_REG_OFFSET, (Xuint16) Size);
  /*
   * Start user logic master write transfer by writting special pattern to its go port.
   */
  XIo_Out8(BaseAddress+MEMORY_EXAMPLE_MST_GO_PORT_OFFSET, MST_START);
}

void MEMORY_EXAMPLE_MasterRecvByte(Xuint32 BaseAddress, Xuint32 DstAddress, int Size)
{
  /*
   * Set user logic master control register for read transfer.
   */
  XIo_Out8(BaseAddress+MEMORY_EXAMPLE_MST_CNTL_REG_OFFSET, MST_BRRD);

  /*
   * Set user logic master address register to drive IP2Bus_Mst_Addr signal.
   */
  XIo_Out32(BaseAddress+MEMORY_EXAMPLE_MST_ADDR_REG_OFFSET, DstAddress);

  /*
   * Set user logic master byte enable register to drive IP2Bus_Mst_BE signal.
   */
  XIo_Out16(BaseAddress+MEMORY_EXAMPLE_MST_BE_REG_OFFSET, 0xFFFF);

  /*
   * Set user logic master length register.
   */
  XIo_Out16(BaseAddress+MEMORY_EXAMPLE_MST_LEN_REG_OFFSET, (Xuint16) Size);
  /*
   * Start user logic master read transfer by writting special pattern to its go port.
   */
  XIo_Out8(BaseAddress+MEMORY_EXAMPLE_MST_GO_PORT_OFFSET, MST_START);
}

/**
 *
 * Enable all possible interrupts from MEMORY_EXAMPLE device.
 *
 * @param   baseaddr_p is the base address of the MEMORY_EXAMPLE device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void MEMORY_EXAMPLE_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  MEMORY_EXAMPLE_mWriteReg(baseaddr, MEMORY_EXAMPLE_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Set global interrupt enable.
   */
  MEMORY_EXAMPLE_mWriteReg(baseaddr, MEMORY_EXAMPLE_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for MEMORY_EXAMPLE device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the MEMORY_EXAMPLE device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void MEMORY_EXAMPLE_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = MEMORY_EXAMPLE_mReadReg(baseaddr, MEMORY_EXAMPLE_INTR_IPISR_OFFSET);
    MEMORY_EXAMPLE_mWriteReg(baseaddr, MEMORY_EXAMPLE_INTR_IPISR_OFFSET, IpStatus);
  }

}

