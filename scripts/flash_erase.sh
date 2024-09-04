#!/bin/bash
#/opt/linkserver/LinkServer flash $1 erase
openocd -f interface/cmsis-dap.cfg -f target/lpc17xx.cfg \
    -c "init" \
    -c "reset halt" \
    -c "flash erase_sector 0 0 last" \
    -c "reset run" \
    -c "shutdown"
