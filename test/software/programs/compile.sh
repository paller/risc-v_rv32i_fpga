#riscv-none-embed-gcc -O0 --no-pie -fno-jump-tables -march=rv32i -mabi=ilp32 -nostdlib -nolibc -static -o simple_loop.elf --entry loop -Wl,-T,imem.map simple_loop.c
riscv-none-embed-gcc -g -v -O0 -march=rv32i -mabi=ilp32 -ffreestanding -o simple_loop.elf --entry _enter -Wl,-T,imem.map,--gc-sections -nostartfiles -nostdlib -nodefaultlibs simple_loop.c

#riscv64-unknown-elf-gcc -g -ffreestanding -O0 -Wl,--gc-sections \ -nostartfiles -nostdlib -nodefaultlibs -Wl,-T,riscv64-virt.ld \ crt0.s add.c
