gdt_start:

gdt_null: ; make the first gdt entry which must be null
    dd 0x00 ; define 4 null bytes
    dd 0x00 ; define 4 null bytes

gdt_code:
    dw 0xffff ; limit
    dw 0x00 ; base
    db 0x00 ; 31:24 bits of base addr
    db 10011010b ; 1st set of flags
    db 11001111b ; 2nd set of flags
    db 0x00


gdt_data:
    dw 0xffff ; limit
    dw 0x00 ; base
    db 0x00 ; base
    db 10010010b ; 1st set of flags
    db 11001111b ; 2nd set of flags
    db 0x00 ; base

gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start