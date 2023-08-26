/*****************************************************************************
* Filename:          C:\Projects\EDK_Trial_3/drivers/audio_controller_v1_00_a/src/audio_controller.h
* Version:           1.00.a
* Description:       audio_controller Driver Header File
* Date:              Sat Jan 30 14:16:37 2010 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef AUDIO_CONTROLLER_H
#define AUDIO_CONTROLLER_H

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
 */
#define AUDIO_CONTROLLER_USER_SLV_SPACE_OFFSET (0x00000000)
#define AUDIO_CONTROLLER_SLV_REG0_OFFSET (AUDIO_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000000)
#define AUDIO_CONTROLLER_SLV_REG1_OFFSET (AUDIO_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000004)
#define AUDIO_CONTROLLER_SLV_REG2_OFFSET (AUDIO_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x00000008)
#define AUDIO_CONTROLLER_SLV_REG3_OFFSET (AUDIO_CONTROLLER_USER_SLV_SPACE_OFFSET + 0x0000000C)

/**
 * Software Reset Space Register Offsets
 * -- RST : software reset register
 */
#define AUDIO_CONTROLLER_SOFT_RST_SPACE_OFFSET (0x00000100)
#define AUDIO_CONTROLLER_RST_REG_OFFSET (AUDIO_CONTROLLER_SOFT_RST_SPACE_OFFSET + 0x00000000)

/**
 * Software Reset Masks
 * -- SOFT_RESET : software reset
 */
#define SOFT_RESET (0x0000000A)

/**
 * Interrupt Controller Space Offsets
 * -- INTR_DGIER : device (peripheral) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define AUDIO_CONTROLLER_INTR_CNTRL_SPACE_OFFSET (0x00000200)
#define AUDIO_CONTROLLER_INTR_DGIER_OFFSET (AUDIO_CONTROLLER_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define AUDIO_CONTROLLER_INTR_IPISR_OFFSET (AUDIO_CONTROLLER_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define AUDIO_CONTROLLER_INTR_IPIER_OFFSET (AUDIO_CONTROLLER_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

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

/**
 * Write Packet FIFO Register/Data Space Offsets
 * -- WRFIFO_RST  : write packet fifo reset register
 * -- WRFIFO_SR   : write packet fifo status register
 * -- WRFIFO_DATA : write packet fifo data
 */
#define AUDIO_CONTROLLER_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define AUDIO_CONTROLLER_WRFIFO_RST_OFFSET (AUDIO_CONTROLLER_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define AUDIO_CONTROLLER_WRFIFO_SR_OFFSET (AUDIO_CONTROLLER_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define AUDIO_CONTROLLER_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define AUDIO_CONTROLLER_WRFIFO_DATA_OFFSET (AUDIO_CONTROLLER_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * Write Packet FIFO Masks
 * -- WRFIFO_FULL_MASK  : write packet fifo full condition
 * -- WRFIFO_AF_MASK    : write packet fifo almost full condition
 * -- WRFIFO_DL_MASK    : write packet fifo deadlock condition
 * -- WRFIFO_SCL_MASK   : write packet fifo vacancy scaling enabled
 * -- WRFIFO_WIDTH_MASK : write packet fifo encoded data port width
 * -- WRFIFO_DREP_MASK  : write packet fifo DRE present
 * -- WRFIFO_VAC_MASK   : write packet fifo vacancy
 * -- WRFIFO_RESET      : write packet fifo reset
 */
#define WRFIFO_FULL_MASK (0x80000000UL)
#define WRFIFO_AF_MASK (0x40000000UL)
#define WRFIFO_DL_MASK (0x20000000UL)
#define WRFIFO_SCL_MASK (0x10000000UL)
#define WRFIFO_WIDTH_MASK (0x0E000000UL)
#define WRFIFO_DREP_MASK (0x01000000UL)
#define WRFIFO_VAC_MASK (0x00FFFFFFUL)
#define WRFIFO_RESET (0x0000000A)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a AUDIO_CONTROLLER register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AUDIO_CONTROLLER_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define AUDIO_CONTROLLER_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a AUDIO_CONTROLLER register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 AUDIO_CONTROLLER_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define AUDIO_CONTROLLER_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from AUDIO_CONTROLLER user logic slave registers.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void AUDIO_CONTROLLER_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 AUDIO_CONTROLLER_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define AUDIO_CONTROLLER_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define AUDIO_CONTROLLER_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define AUDIO_CONTROLLER_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define AUDIO_CONTROLLER_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))

#define AUDIO_CONTROLLER_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG0_OFFSET) + (RegOffset))
#define AUDIO_CONTROLLER_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG1_OFFSET) + (RegOffset))
#define AUDIO_CONTROLLER_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG2_OFFSET) + (RegOffset))
#define AUDIO_CONTROLLER_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (AUDIO_CONTROLLER_SLV_REG3_OFFSET) + (RegOffset))

/**
 *
 * Reset AUDIO_CONTROLLER via software.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AUDIO_CONTROLLER_mReset(Xuint32 BaseAddress)
 *
 */
#define AUDIO_CONTROLLER_mReset(BaseAddress) \
 	XIo_Out32((BaseAddress)+(AUDIO_CONTROLLER_RST_REG_OFFSET), SOFT_RESET)

/**
 *
 * Reset write packet FIFO of AUDIO_CONTROLLER to its initial state.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AUDIO_CONTROLLER_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define AUDIO_CONTROLLER_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(AUDIO_CONTROLLER_WRFIFO_RST_OFFSET), WRFIFO_RESET)

/**
 *
 * Check status of AUDIO_CONTROLLER write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool AUDIO_CONTROLLER_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 AUDIO_CONTROLLER_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define AUDIO_CONTROLLER_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(AUDIO_CONTROLLER_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define AUDIO_CONTROLLER_mWriteFIFOVacancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(AUDIO_CONTROLLER_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK)

/**
 *
 * Write 32 bit data to AUDIO_CONTROLLER write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the AUDIO_CONTROLLER device.
 * @param   DataOffset is the offset from the data port to write to.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AUDIO_CONTROLLER_mWriteToFIFO(Xuint32 BaseAddress, unsigned DataOffset, Xuint32 Data)
 *
 */
#define AUDIO_CONTROLLER_mWriteToFIFO(BaseAddress, DataOffset, Data) \
 	XIo_Out32((BaseAddress) + (AUDIO_CONTROLLER_WRFIFO_DATA_OFFSET) + (DataOffset), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


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
void AUDIO_CONTROLLER_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the AUDIO_CONTROLLER device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void AUDIO_CONTROLLER_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the AUDIO_CONTROLLER instance to be worked on.
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
XStatus AUDIO_CONTROLLER_SelfTest(void * baseaddr_p);

#endif /** AUDIO_CONTROLLER_H */
