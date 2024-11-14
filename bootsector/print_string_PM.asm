[bits 32]

VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEM

    print_string_pm_while:
        mov al, [ebx]
        mov ah, WHITE_ON_BLACK

        cmp al, 0
        jz print_string_pm_return

        mov byte [edx], ax

        inc ebx
        add edx, 2

        jmp print_string_pm_while


    print_string_pm_return:
        popa
        ret