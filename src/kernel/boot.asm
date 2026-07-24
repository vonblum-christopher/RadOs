bits 64
section .text
org 0x7c00       ; Standard MBR bootloader location

start:
    jmp load_kernel
    ; call main method here somehow

load_kernel:
    ; Include the kernel binary right after boot code
    incbin "kernel.bin"

times 510 - ($ - $$) db 0
dw 0xAA55        ; Boot signature