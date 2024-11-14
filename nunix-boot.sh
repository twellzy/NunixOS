cd ~/NunixOS/bootsector
nasm -f bin boot_sect.asm -o boot_sect.bin
cd ..
cat bootsector/boot_sect.bin kernel/kernel.bin > nunix-image.bin

qemu-system-x86_64 nunix-image.bin 