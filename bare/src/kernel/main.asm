BITS 64
DEFAULT REL

extern main

_start:
    CLI
    MOV ax, ds
    MOV ss, ax
    MOV sp, 0
    MOV bp, sp
    STI

    CALL main

    CLI
    HLT
