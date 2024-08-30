#!/bin/bash
/opt/linkserver/LinkServer gdbserver $1 &

# Give the gdbserver a moment to start up
sleep 4

# Start GDB and load the image
arm-none-eabi-gdb -ex "target remote localhost:3333" \
                  -ex "monitor reset halt" \
                  -ex "load" \
                  -ex "continue" \
                  -ex "load" \
                  -ex "continue" \
                  $2