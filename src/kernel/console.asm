[BITS 16]

global asm_rad_print_char:function
global asm_rad_print_char:function

asm_rad_print_char:
    mov ah, 0Eh
    mov al, 'A'
    mov bh, 0
    mov bl, 7
    int 10h
    ret

asm_rad_print_char:
    mov ah, 0Eh
    mov al, 'A'
    mov bh, 0
    mov bl, 7
    int 10h
    ret