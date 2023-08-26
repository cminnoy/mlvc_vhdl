################################################################################
# Automatically-generated file. Do not edit!
################################################################################

S_UPPER_SRCS += \

CC_UPPER_SRCS += \

C++_UPPER_SRCS += \

CXX_UPPER_SRCS += \

CPP_SRCS += \
../src/canvas.cpp \
../src/chrysant.cpp \
../src/desert.cpp \
../src/koala.cpp \
../src/penguins.cpp \
../src/tulips.cpp \

CC_SRCS += \
../src/main.cc \
../src/vga_controller.cc \

C_SRCS += \
../src/platform.c \

C_UPPER_SRCS += \

CPP_UPPER_SRCS += \

CXX_SRCS += \

S_SRCS += \

C++_SRCS += \

# Object files
OBJS += \
src/canvas.o \
src/chrysant.o \
src/desert.o \
src/koala.o \
src/main.o \
src/penguins.o \
src/platform.o \
src/tulips.o \
src/vga_controller.o \

# Dependency files
DEPS += \
src/canvas.d \
src/chrysant.d \
src/desert.d \
src/koala.d \
src/main.d \
src/penguins.d \
src/platform.d \
src/tulips.d \
src/vga_controller.d \

# Each subdirectory must supply rules for building sources it contributes
src/canvas.o: ../src/canvas.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/chrysant.o: ../src/chrysant.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/desert.o: ../src/desert.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/koala.o: ../src/koala.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/main.o: ../src/main.cc $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/penguins.o: ../src/penguins.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/platform.o: ../src/platform.c $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/tulips.o: ../src/tulips.cpp $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '

src/vga_controller.o: ../src/vga_controller.cc $(INCDEP)
	@echo mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $<
	@mb-gcc -c -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0 -o$@ $< && \
	echo -n $(@:%.o=%.d) $(dir $@) > $(@:%.o=%.d) && \
	mb-gcc -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -MM -MG -P -w -mno-xl-soft-mul -mcpu=v7.20.d -IC:/EDK_Trial_3/SDK/SDK_Workspace/MyGameConsole/microblaze_0/include -I"C:\EDK_Trial_3\SDK\SDK_Workspace\VgaDemo\include" -I../../MyGameConsole/microblaze_0/include -I../include -I../../VgaDemo/include -IC:/EDK_Trial_3/SDK/SDK_Workspace/VgaDemo/include -g -O0  $< >> $(@:%.o=%.d)
	@echo ' '


