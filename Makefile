TARGET = lpc1768_project

CMSIS_MANUFACTURER = NXP
CMSIS_DEVICE       = LPC17xx
CMSIS_DEVICE_DIR   = CMSIS/Device/$(CMSIS_MANUFACTURER)/$(CMSIS_DEVICE)
TARGET_DEVICE 	   = LPC1768

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size
GDB = arm-none-eabi-gdb

BUILD_DIR = build
OBJ_DIR = build/obj

INCLUDES = $(shell find . -type d -iname include)

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -g -Os \
		 -flto \
		 -ffunction-sections \
		 -fdata-sections \
		 $(addprefix -I,$(INCLUDES))

CFLAGS += -DUSE_GPIO_DRIVER

ASFLAGS = -mcpu=cortex-m3 -mthumb -g

LDFLAGS = -fno-builtin --specs=nano.specs --specs=nosys.specs -Wl,--gc-sections

SOURCES = $(shell find src -name '*.c') \
		  $(shell find $(CMSIS_DEVICE_DIR) -name '*.c' -or -name '*.s') \
		  $(shell find CMSIS/Drivers -name *.c)

OBJECTS = $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.s=.o)

ROM_OBJECTS = $(addprefix $(OBJ_DIR)/rom/, $(OBJECTS))
RAM_OBJECTS = $(addprefix $(OBJ_DIR)/ram/, $(OBJECTS))

all: rom ram

rom: CFLAGS += -D__RAM_MODE__=0
rom: ASFLAGS += --defsym RAM_MODE=0
rom: LDFLAGS += -T linker/$(TARGET_DEVICE)_rom.ld -Wl,-Map=$(BUILD_DIR)/bin/$(TARGET)_rom.map
rom: $(BUILD_DIR)/bin/$(TARGET)_rom.bin $(BUILD_DIR)/bin/$(TARGET)_rom.hex

%_rom.elf: $(ROM_OBJECTS)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(ROM_OBJECTS) -o $@ $(LDFLAGS)
	$(SIZE) $@

$(OBJ_DIR)/rom/%.o: %.s
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJ_DIR)/rom/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

ram: CFLAGS += -D__RAM_MODE__=1
ram: ASFLAGS += --defsym RAM_MODE=1
ram: LDFLAGS += -T linker/$(TARGET_DEVICE)_ram.ld -Wl,-Map=$(BUILD_DIR)/bin/$(TARGET)_ram.map
ram: $(BUILD_DIR)/bin/$(TARGET)_ram.bin $(BUILD_DIR)/bin/$(TARGET)_ram.hex

%_ram.elf: $(RAM_OBJECTS)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(RAM_OBJECTS) -o $@ $(LDFLAGS)
	$(SIZE) $@

$(OBJ_DIR)/ram/%.o: %.s
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJ_DIR)/ram/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.hex: %.elf
	$(OBJCOPY) -O ihex $< $@

flash_erase:
	scripts/flash_erase.sh $(TARGET_DEVICE)

flash_load: rom
	scripts/flash_load.sh $(TARGET_DEVICE) $(BUILD_DIR)/bin/$(TARGET)_rom.hex

ram_load: ram
	scripts/ram_load.sh $(BUILD_DIR)/bin/$(TARGET)_ram.elf

clean:
	@rm -rf $(BUILD_DIR)

# prevent make from deleting .elf files
.PRECIOUS: %_rom.elf %_ram.elf 

.PHONY: all rom ram flash_erase flash_load ram_load clean