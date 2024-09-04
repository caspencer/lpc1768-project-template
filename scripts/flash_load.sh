#!/bin/bash
#/opt/linkserver/LinkServer flash $1 load $2
SCRIPT_DIR=$(dirname "$(realpath "$0")")
openocd -f "$SCRIPT_DIR/openocd.cfg" \
    -c "init" \
    -c "reset init" \
    -c "flash write_image erase $2" \
    -c "reset run" \
    -c "shutdown"
