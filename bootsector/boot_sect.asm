[org 0x7c00]

	mov bx, hex_number
	call print_hex

	jmp $



%include "print_string.asm"
%include "print_hex.asm"

hex_number:
	db 0xbe, 0

times 510-($-$$) db 0
dw 0xaa55
