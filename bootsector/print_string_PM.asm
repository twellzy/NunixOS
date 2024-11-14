[bits 32]
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEM

    print_string_pm_while:
        mov al, [edx]
        mov ah, WHITE_ON_BLACK

        cmp al, 0x00
        jz print_string_pm_return

        mov [edx], ax

        inc ebx
        add edx, 0x2

        jmp print_string_pm_while


    print_string_pm_return:
        popa
        ret