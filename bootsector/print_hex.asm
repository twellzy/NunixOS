print_hex: ; (bx) -- addr of hex number to be printed
    pusha  ;  ^ MUST BE AN INT NOT A STRING

    mov ah, 0x0e

    mov al, 0x30
    int 0x10

    mov al, 0x78
    int 0x10
    xor al, al
    xor cx, cx

    mov al, byte [bx]
    cmp al, 0x00
    jz print_hex_return

    print_hex_while: ; (bl != 0x00)
        mov cl, al
        shr cl, 4
        mov al, cl
        call nibble_to_char
        int 0x10

        mov al, [bx]
        and al, 0x0f ; removes higher nibble of al
        call nibble_to_char
        int 0x10

        inc bx
        mov al, byte [bx]
        cmp al, 0x00
        jg print_hex_while


    print_hex_return:
        popa
        ret


nibble_to_char: ; (al) -- nibble of part of a hex byte
                ; returns one byte in AX corresponding to ascii hex chars

    cmp al, 0x09
    jg nibble_to_char_else
    nibble_to_char_if: ; (al <= 0x09) 
        add al, 0x30
        jmp nibble_to_char_return

    nibble_to_char_else: ; (al > 0x09)
        add al, 0x57
        jmp nibble_to_char_return


nibble_to_char_return:
    ret