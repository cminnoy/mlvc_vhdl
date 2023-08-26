################################################################################
# Automatically-generated file. Do not edit!
################################################################################

ROOT := ..

-include $(ROOT)/makefile.init
-include C:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/libgen.mk

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include $(SUBDIRS:%=%/subdir.mk)
-include objects.mk
-include $(DEPS)
-include $(ROOT)/makefile.defs

# All Target
all: BigBuckBunny.elf

dependents:
	-cd C:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole && $(MAKE) all

BigBuckBunny.elf:  ../BigBuckBunny.ld $(LIBRARIES) $(LIBDEP) $(OBJS)
	@echo 'Building target: $@'
	mb-g++ -o $@ $(OBJS) $(USER_OBJS) $(LIBS)  -xl-mode-executable -mno-xl-soft-mul -mcpu=v7.20.d    -LC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/lib  -T../BigBuckBunny.ld
	@echo 'Finished building: $@'
	@echo
	@echo "**************" Determining Size of ELF File "**************"
	@echo
	mb-size $@
	@echo
	@echo
	@echo "**************" Validating ELF File "**************"
	@echo
	@echo 'Validating ELF Section Addresses with Hardware Address Map...'
	elfcheck -noheader -hw C:/EDK_Trial_3/SDK/SDK_Export/hw/system.xml -pe microblaze_0 $@

clean:
	-$(RM) $(OBJS) $(DEPS) BigBuckBunny.elf

.PHONY: all clean dependents
.SECONDARY:

-include $(ROOT)/makefile.targets
