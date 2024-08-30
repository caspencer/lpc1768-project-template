TARGET = lpc1768_project

CMSIS_MANUFACTURER = NXP
CMSIS_DEVICE       = LPC17xx
CMSIS_DEVICE_DIR   = CMSIS/Device/$(CMSIS_MANUFACTURER)/$(CMSIS_DEVICE)
TARGET_DEVICE 	   = lpc1768

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

BUILD_DIR = build

INCLUDES = $(shell find . -type d -iname include)

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -g -O2 \
		 $(addprefix -I,$(INCLUDES)) \
		 -D__RAM_MODE__=0

ASFLAGS = -mcpu=cortex-m3 -mthumb --defsym RAM_MODE=0

LDFLAGS = -T linker/ldscript_rom_gnu.ld -nostartfiles

SOURCES = $(shell find src -name '*.c') \
		  $(shell find $(CMSIS_DEVICE_DIR) -name '*.c' -or -name '*.s')

OBJECTS = $(patsubst %.s, $(BUILD_DIR)/obj/%.o, $(patsubst %.c, $(BUILD_DIR)/obj/%.o, $(SOURCES)))

all: $(BUILD_DIR)/bin/$(TARGET).bin $(BUILD_DIR)/bin/$(TARGET).hex

$(BUILD_DIR)/obj/%.o: %.s
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD_DIR)/obj/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/bin/$(TARGET).elf: $(OBJECTS)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)
	$(SIZE) $@

$(BUILD_DIR)/bin/$(TARGET).bin: $(BUILD_DIR)/bin/$(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(BUILD_DIR)/bin/$(TARGET).hex: $(BUILD_DIR)/bin/$(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

erase:
	scripts/flash_erase.sh $(TARGET_DEVICE)

flash: $(BUILD_DIR)/bin/$(TARGET).hex
	scripts/flash_load.sh $(TARGET_DEVICE) $(BUILD_DIR)/bin/$(TARGET).hex

clean:
	@rm -rf $(BUILD_DIR)

.PHONY: all clean erase