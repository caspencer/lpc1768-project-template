#!/bin/bash
#/opt/linkserver/LinkServer flash $1 erase
SCRIPT_DIR=$(dirname "$(realpath "$0")")
openocd -f "$SCRIPT_DIR/openocd.cfg" \
    -c "init" \
    -c "reset halt" \
    -c "flash erase_sector 0 0 last" \
    -c "reset run" \
    -c "shutdown"
