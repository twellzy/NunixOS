C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
OBJ = ${C_SOURCES:.c=.o}
HEADERS = $(wildcard kernel/*.h drivers/*.h)

all: nunix-image.bin

nunix-image.bin: bootsector/boot_sect.bin kernel/kernel.bin
	cat $^ > nunix-image.bin

kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	x86_64-elf-ld -m elf_x86_64  -o $@ -Ttext 0x1000 $^ --oformat binary

kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf64 -o $@

bootsector/boot_sect.bin: bootsector/boot_sect.asm
	nasm -f bin $< -I ~/NunixOS/bootsector/ -o $@

kernel.elf: kernel/kernel_entry.o ${OBJ}
	x86_64-elf-ld -m elf_x86_64 -o $@ -Ttext 0x1000 $^

%.o: %.c ${HEADERS}
	x86_64-elf-gcc -m64 -ffreestanding -c $< -o $@

clear: 
	rm -f *.bin *.dis *.o *.elf nunix-image.bin
	rm -f kernel/*.bin kernel/*.o
	rm -f bootsector/*.bin bootsector/*.o
	rm -f drivers/*.o

debug: nunix-image.bin kernel.elf
	qemu-system-x86_64 -s -fda nunix-image.bin &
	x86_64-elf-gdb -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

run: nunix-image.bin
	qemu-system-x86_64 nunix-image.bin