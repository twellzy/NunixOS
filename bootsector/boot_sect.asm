[org 0x7c00]
KERNEL_OFFSET equ 0x1000

	mov [BOOT_DRIVE], dl
	mov bp, 0x9000
	mov sp, bp


	call kernel_load
	call pm_switch

	jmp $


%include "disk_read.asm"
%include "print_string.asm"
%include "print_hex.asm"
%include "gdt.asm"
%include "pm_switch.asm"
;%include "print_string_pm.asm"

[bits 16]

kernel_load:
	mov bx, MSG_LOAD_KERNEL
	call print_string

	mov bx, KERNEL_OFFSET
	mov dh, 1
	mov dl, [BOOT_DRIVE]
	call disk_read

	ret

[bits 32]

BEGIN_PM:
	call KERNEL_OFFSET

	jmp $


BOOT_DRIVE db 0
MSG_REAL_MODE db " Started in 16 - bit Real Mode " , 0
MSG_PROT_MODE db " Successfully landed in 32 - bit Protected Mode " , 0
MSG_LOAD_KERNEL db " Loading kernel into memory. " , 0

times 510-($-$$) db 0
dw 0xaa55

