BITS 64
DEFAULT REL

extern main

global asm_rad_print_char:function

start:
    CLI
    MOV ax, ds
    MOV ss, ax
    MOV sp, 0
    MOV bp, sp
    STI

    CALL main

    CLI
    HLT

asm_rad_print_char:
    mov ah, 0Eh
    mov al, 'A'
    mov bh, 0
    mov bl, 7
    int 10h
    ret
