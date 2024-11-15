C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
OBJ = ${C_SOURCES:.c=.o}
HEADERS = $(wildcard kernel/*.h drivers/*.h)

all: nunix-image.bin

nunix-image.bin: bootsector/boot_sect.bin kernel/kernel.bin
	cat $^ > nunix-image.bin

kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	x86_64-elf-ld -m elf_i386  -o $@ -Ttext 0x1000 $^ --oformat binary

kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm $< -f elf -o $@

bootsector/boot_sect.bin: bootsector/boot_sect.asm
	nasm -f bin $< -I ~/NunixOS/bootsector/ -o $@

%.o: %.c ${HEADERS}
	x86_64-elf-gcc -m32 -ffreestanding -c $< -o kernel/kernel.o

clear: 
	rm -f *.bin *.dis *.o nunix-image.bin
	rm -f kernel/*.bin kernel/*.o
	rm -f bootsector/*.bin bootsector/*.o

run: nunix-image.bin
	./nunix-boot.sh