BITS 64
DEFAULT REL

global main

extern cppmain

section .text
main:
    CLI
    MOV ax, ds
    MOV ss, ax
    MOV sp, 0
    MOV bp, sp
    STI

    CALL cppmain

    CLI
    HLT

asm_rad_print_char:
    mov ah, 0Eh
    mov al, 'A'
    mov bh, 0
    mov bl, 7
    int 10h
    ret

CALL main;