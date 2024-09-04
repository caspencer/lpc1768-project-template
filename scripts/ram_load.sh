#!/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
openocd -f "$SCRIPT_DIR/openocd.cfg" \
    -c "init" \
    -c "halt" \
    -c "load_image $1" \
    -c "resume 0x10000000" \
    -c "shutdown"
