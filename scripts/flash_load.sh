#!/bin/bash
#/opt/linkserver/LinkServer flash $1 load $2
openocd -f interface/cmsis-dap.cfg -f target/lpc17xx.cfg \
    -c "init" \
    -c "reset init" \
    -c "flash write_image erase $2" \
    -c "reset run" \
    -c "shutdown"
