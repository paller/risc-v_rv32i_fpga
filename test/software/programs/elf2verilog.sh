#riscv-none-embed-objcopy -S -g -j .text -j .rodata -O verilog --verilog-data-width 4 simple_loop.elf loop.mem
riscv-none-embed-objcopy -S -g -j .text -j .rodata -O binary simple_loop.elf test.bin
od -An -t x4 -w4 test.bin > test.mem