TARGET = lpc1768_project

CMSIS_MANUFACTURER = NXP
CMSIS_DEVICE       = LPC17xx
CMSIS_DEVICE_DIR   = CMSIS/Device/$(CMSIS_MANUFACTURER)/$(CMSIS_DEVICE)
TARGET_DEVICE 	   = lpc1768

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -g -O2 \
		 -Iinclude \
		 -ICMSIS/Core/Include \
		 -I$(CMSIS_DEVICE_DIR)/Include \
		 -D__RAM_MODE__=0

ASFLAGS = -mcpu=cortex-m3 -mthumb --defsym RAM_MODE=0

LDFLAGS = -T linker/ldscript_rom_gnu.ld -nostartfiles

SOURCES = $(wildcard src/*.c) \
		  $(wildcard $(CMSIS_DEVICE_DIR)/Source/*.c)

OBJECTS = $(SOURCES:.c=.o) $(CMSIS_DEVICE_DIR)/Source/startup_$(CMSIS_DEVICE).o

all: $(TARGET).bin $(TARGET).hex

$(CMSIS_DEVICE_DIR)/Source/startup_$(CMSIS_DEVICE).o: $(CMSIS_DEVICE_DIR)/Source/startup_$(CMSIS_DEVICE).s
	$(AS) $(ASFLAGS) -o $@ $<

$(TARGET).elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)
	$(SIZE) $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

erase:
	scripts/flash_erase.sh $(TARGET_DEVICE)

flash: $(TARGET).hex
	scripts/flash_load.sh $(TARGET_DEVICE) $(TARGET).hex

clean:
	rm -f $(OBJECTS) $(TARGET).elf $(TARGET).bin $(TARGET).hex
