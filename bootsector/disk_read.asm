disk_read: ;load dh sectors to es:bx from drive dl
    push dx
    mov ah, 0x02
    mov al, dh ; dh number of sectors to read
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00

    int 0x13

    jc disk_carry_error

    pop dx
    cmp dh, al
    jne disk_error

    ret

disk_error:
    mov bx, error_message
    call print_string
    jmp $

disk_carry_error:
    mov bx, carry_error_message
    call print_string
    mov dh, ah
    mov [mem_holder], dh
    mov bx, mem_holder
    call print_hex
    jmp $

error_message:
    db "Read Failure", 0

carry_error_message:
    db "General fault during read", 0

mem_holder dw 0x0000