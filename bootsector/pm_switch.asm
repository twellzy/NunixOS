[bits 16]

pm_switch:
    cli

    lgdt [gdt_descriptor] ; where the magic happens

    mov eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:pm_init


[bits 32]

pm_init:

    mov ax, DATA_SEG
    mov dx, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM