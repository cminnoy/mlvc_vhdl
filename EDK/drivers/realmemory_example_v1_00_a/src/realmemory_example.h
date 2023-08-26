/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/realmemory_example_v1_00_a/src/realmemory_example.h
* Version:           1.00.a
* Description:       realmemory_example Driver Header File
* Date:              Sun Dec 20 14:24:11 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef REALMEMORY_EXAMPLE_H
#define REALMEMORY_EXAMPLE_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a REALMEMORY_EXAMPLE register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the REALMEMORY_EXAMPLE device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void REALMEMORY_EXAMPLE_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define REALMEMORY_EXAMPLE_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a REALMEMORY_EXAMPLE register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the REALMEMORY_EXAMPLE device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 REALMEMORY_EXAMPLE_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define REALMEMORY_EXAMPLE_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from REALMEMORY_EXAMPLE user logic memory (BRAM).
 *
 * @param   Address is the memory address of the REALMEMORY_EXAMPLE device.
 * @param   Data is the value written to user logic memory.
 *
 * @return  The data from the user logic memory.
 *
 * @note
 * C-style signature:
 * 	void REALMEMORY_EXAMPLE_mWriteMemory(Xuint32 Address, Xuint32 Data)
 * 	Xuint32 REALMEMORY_EXAMPLE_mReadMemory(Xuint32 Address)
 *
 */
#define REALMEMORY_EXAMPLE_mWriteMemory(Address, Data) \
 	XIo_Out32(Address, (Xuint32)(Data))
#define REALMEMORY_EXAMPLE_mReadMemory(Address) \
 	XIo_In32(Address)

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the REALMEMORY_EXAMPLE instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus REALMEMORY_EXAMPLE_SelfTest(void * baseaddr_p);

#endif /** REALMEMORY_EXAMPLE_H */
