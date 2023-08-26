/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/realmemory2_v1_00_a/src/realmemory2.h
* Version:           1.00.a
* Description:       realmemory2 Driver Header File
* Date:              Sun Dec 20 14:35:04 2009 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef REALMEMORY2_H
#define REALMEMORY2_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 */
#define REALMEMORY2_USER_SLV_SPACE_OFFSET (0x00000000)
#define REALMEMORY2_SLV_REG0_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000000)
#define REALMEMORY2_SLV_REG1_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000004)
#define REALMEMORY2_SLV_REG2_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000008)
#define REALMEMORY2_SLV_REG3_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define REALMEMORY2_SLV_REG4_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000010)
#define REALMEMORY2_SLV_REG5_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000014)
#define REALMEMORY2_SLV_REG6_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x00000018)
#define REALMEMORY2_SLV_REG7_OFFSET (REALMEMORY2_USER_SLV_SPACE_OFFSET + 0x0000001C)

/**
 * Interrupt Controller Space Offsets
 * -- INTR_DGIER : device (peripheral) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define REALMEMORY2_INTR_CNTRL_SPACE_OFFSET (0x00000100)
#define REALMEMORY2_INTR_DGIER_OFFSET (REALMEMORY2_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define REALMEMORY2_INTR_IPISR_OFFSET (REALMEMORY2_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define REALMEMORY2_INTR_IPIER_OFFSET (REALMEMORY2_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

/**
 * Interrupt Controller Masks
 * -- INTR_TERR_MASK : transaction error
 * -- INTR_DPTO_MASK : data phase time-out
 * -- INTR_IPIR_MASK : ip interrupt requeset
 * -- INTR_RFDL_MASK : read packet fifo deadlock interrupt request
 * -- INTR_WFDL_MASK : write packet fifo deadlock interrupt request
 * -- INTR_IID_MASK  : interrupt id
 * -- INTR_GIE_MASK  : global interrupt enable
 * -- INTR_NOPEND    : the DIPR has no pending interrupts
 */
#define INTR_TERR_MASK (0x00000001UL)
#define INTR_DPTO_MASK (0x00000002UL)
#define INTR_IPIR_MASK (0x00000004UL)
#define INTR_RFDL_MASK (0x00000020UL)
#define INTR_WFDL_MASK (0x00000040UL)
#define INTR_IID_MASK (0x000000FFUL)
#define INTR_GIE_MASK (0x80000000UL)
#define INTR_NOPEND (0x80)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a REALMEMORY2 register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the REALMEMORY2 device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void REALMEMORY2_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define REALMEMORY2_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a REALMEMORY2 register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the REALMEMORY2 device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 REALMEMORY2_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define REALMEMORY2_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from REALMEMORY2 user logic slave registers.
 *
 * @param   BaseAddress is the base address of the REALMEMORY2 device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void REALMEMORY2_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 REALMEMORY2_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define REALMEMORY2_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define REALMEMORY2_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (REALMEMORY2_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))

#define REALMEMORY2_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG0_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG1_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG2_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG3_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg4(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG4_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg5(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG5_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg6(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG6_OFFSET) + (RegOffset))
#define REALMEMORY2_mReadSlaveReg7(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (REALMEMORY2_SLV_REG7_OFFSET) + (RegOffset))

/**
 *
 * Write/Read 32 bit value to/from REALMEMORY2 user logic memory (BRAM).
 *
 * @param   Address is the memory address of the REALMEMORY2 device.
 * @param   Data is the value written to user logic memory.
 *
 * @return  The data from the user logic memory.
 *
 * @note
 * C-style signature:
 * 	void REALMEMORY2_mWriteMemory(Xuint32 Address, Xuint32 Data)
 * 	Xuint32 REALMEMORY2_mReadMemory(Xuint32 Address)
 *
 */
#define REALMEMORY2_mWriteMemory(Address, Data) \
 	XIo_Out32(Address, (Xuint32)(Data))
#define REALMEMORY2_mReadMemory(Address) \
 	XIo_In32(Address)

/************************** Function Prototypes ****************************/


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
void REALMEMORY2_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the REALMEMORY2 device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void REALMEMORY2_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the REALMEMORY2 instance to be worked on.
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
XStatus REALMEMORY2_SelfTest(void * baseaddr_p);

#endif /** REALMEMORY2_H */
