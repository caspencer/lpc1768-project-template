# Project Template for NXP LPC1768 (Cortex-M3)

### CMSIS
- **CMSIS/Core** files from [CMSIS_6](https://github.com/ARM-software/CMSIS_6)
- **CMSIS/Device**, **CMSIS/Drivers/nxp_175x_6x**, **linker/LPC1768_*.ld** files from [lpc175x_6x_cmsis_driver_library](https://community.nxp.com/t5/LPC-Microcontrollers/Where-can-I-download-the-lpc1768-cmsis-driver-library/m-p/733006/highlight/true#M29617)

### Modifications
- **startup_LPC17xx.s**: `_start` was changed to `main` (when ROM_MODE = 0)
- **lpc17xx_nvic.c**: change `IP` to `IPR` and `SHP` to `SHPR` (see https://arm-software.github.io/CMSIS_6/main/Core/core_revisionHistory.html#core6_changes)
- **ldscript_ram_gnu.ld**: commented out `GROUP(-lgcc -lc -lcs3 -lcs3unhosted -lcs3micro)`, moved `__cs3_region_start_ram = .;` to `.data` section to get running from ram working properly, renamed to LPC1768_ram.ld
- **ldscript_rom_gnu.ld**: renamed to LPC1768_rom.ld

### VS Code debugging support
- via Cortex-Debug extension + openocd + [scripts/LPC176x5x.svd](https://github.com/coredump-ch/lpc176x5x-rs/blob/master/LPC176x5x.svd)
- debug configurations for FLASH and RAM

### TODO
- ~~load rom-based bin to board to verify~~
- ~~redirect build output to single directory~~
- ~~add rules to Makefile for ram-based bin~~
- ~~load ram-based bin to board to verify~~
- verify if nxp drivers work
- figure out how to compile/include specifc drivers
- figure out "ld: warning: lpc1768_project.elf has a LOAD segment with RWX permissions"