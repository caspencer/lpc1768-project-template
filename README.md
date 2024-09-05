# Project Template for NXP LPC1768 (Cortex-M3)

### LED Blinky example
- **main.c** - simple GPIO example using driver or direct-register access

### Usage
- `make all` or `make` - compiles everything
- `make rom` - compiles "rom" binary intended to be written to flash memory (typical use case)
- `make ram` - compiles "ram" binary intended to be loaded and exectued from ram
- `make flash_erase` - erases flash ("rom") memory on target
- `make flash_load` - writes bin to flash ("rom") memory on target (typical use case)
- `make ram_load` - loads "ram" bin into ram on target
- `make clean` - deletes all build output (i.e. `build` directory)

### CMSIS
- **CMSIS/Core** files from [CMSIS_6](https://github.com/ARM-software/CMSIS_6)
- **CMSIS/Device**, **CMSIS/Drivers/nxp_175x_6x** files from [lpc175x_6x_cmsis_driver_library](https://community.nxp.com/t5/LPC-Microcontrollers/Where-can-I-download-the-lpc1768-cmsis-driver-library/m-p/733006/highlight/true#M29617)
- **CMSIS/Device/NXP/LPC17xx/Source/startup_ARMCM3.S** from [ARM GNU Toolchain 13.3.Rel1 samples](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)

### Modifications
- **CMSIS/Drivers/nxp_175x_6x/source/lpc17xx_nvic.clpc17xx_nvic.c**: change `IP` to `IPR` and `SHP` to `SHPR` (see [Breaking changes in CMSIS-Core 6](https://arm-software.github.io/CMSIS_6/main/Core/core_revisionHistory.html#core6_changes))
- **linker/LPC178_ram.ld**, **linker/LPC178_rom.ld**: linker scripts adapted from **gcc.ld** sample provided by [ARM GNU Toolchain 13.3.Rel1](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
- **CMSIS/Device/NXP/LPC17xx/Source/startup_ARMCM3.S**: put Reset_Handler in its own section

### VS Code debugging support
- via [Cortex-Debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug) extension + openocd + [scripts/LPC176x5x.svd](https://github.com/coredump-ch/lpc176x5x-rs/blob/master/LPC176x5x.svd)
- launch configurations for FLASH and RAM

### Target board and Debug cable
- **LPC1768 minimal/minimum system board** - a development/breakout board with headers for I/O, a single LED, 3 push buttons, a USB port _(intended to be used with some sort of bootloader but not utilized in this repository)_, JTAG header, etc.
    - used to be commonly found on [eBay back in 2011](https://github.com/dwelch67/mbed_samples/tree/master/ebay_board) or so (still available on [AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sf57a3d3fae1643b7863355287109e7409/LPC1768-minimum-system-board-LPC1768-small-system-board.jpg_.webp))
- **NXP MCU-Link** - [debug probe](https://www.nxp.com/design/design-center/software/development-software/mcuxpresso-software-and-tools-/mcu-link-debug-probe:MCU-LINK), supports CMSIS-DAP, available direct from NXP or other distributors (DigiKey)
- **OLIMEX ARM-JTAG-20-10** - [20-pin to 10-pin adapter](https://www.olimex.com/Products/ARM/JTAG/ARM-JTAG-20-10/)
