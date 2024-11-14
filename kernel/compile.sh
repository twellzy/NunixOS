x86_64-elf-gcc -m32 -ffreestanding -c kernel/kernel.c -o kernel/kernel.o
x86_64-elf-ld -m elf_i386 -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary