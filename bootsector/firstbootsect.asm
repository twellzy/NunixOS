mov bx, 30

cmp bx, 4
jle if
cmp bx, 40
jl elseif
jmp else

if:
	mov al, "A"
	jmp end

elseif:
	mov al, "B"
	jmp end

else:
	mov al, "C"

end:

mov ah, 0x0e
int 0x10

jmp $


times 510-($-$$) db 0
dw 0xaa55

