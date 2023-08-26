/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#include "xparameters.h"
#include "xenv_standalone.h"
#include "platform.h"
#include "platform_config.h"

#ifdef STDOUT_IS_16550
#include "xuartns550_l.h"
#endif

void
enable_caches()
{
#ifdef __PPC__
    XCache_EnableICache(CACHEABLE_REGION_MASK);
    XCache_EnableDCache(CACHEABLE_REGION_MASK);
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_ICACHE 
    microblaze_invalidate_icache();
    microblaze_enable_icache();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE 
    microblaze_invalidate_dcache();
    microblaze_enable_dcache();
#endif
#endif
}

void
disable_caches()
{
#ifdef __PPC__
    XCache_DisableDCache();
    XCache_DisableICache();
#elif __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_DCACHE 
#if !XPAR_MICROBLAZE_DCACHE_USE_WRITEBACK
    microblaze_invalidate_dcache();
#endif
    microblaze_disable_dcache();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE 
    microblaze_invalidate_icache();
#endif
#endif
}

void
init_platform()
{
    enable_caches();

    /* if we have a uart 16550, then that needs to be initialized */
#ifdef STDOUT_IS_16550
    XUartNs550_SetBaud(STDOUT_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, 9600);
    XUartNs550_mSetLineControlReg(STDOUT_BASEADDR, XUN_LCR_8_DATA_BITS);
#endif
}

void
cleanup_platform()
{
    disable_caches();
}
