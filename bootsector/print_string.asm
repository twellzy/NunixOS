print_string: ; (bx) = addr of null terminated string to print
	pusha

	mov ah, 0x0e
	mov al, [bx]
	cmp al, 0x00
	jz print_string_return
	xor cx, cx

	print_string_while:
		mov al, [bx]
		cmp al, 0x00
		jz print_string_return
		int 0x10
		inc bx
		jmp print_string_while


print_string_return:
	popa
	ret
