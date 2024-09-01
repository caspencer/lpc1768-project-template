#!/bin/bash
openocd -f interface/cmsis-dap.cfg -f target/lpc17xx.cfg \
    -c "init" \
    -c "halt" \
    -c "load_image $1" \
    -c "resume 0x10000000" \
    -c "shutdown"
