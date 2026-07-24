bits 64
section .text
org 0x7c00       ; Standard MBR bootloader location

start:
    jmp load_kernel
    ; call main method here somehow

load_kernel:
kernel_start:
    incbin "kernel.bin"
kernel_end:

times 510 - ($ - $$) db 0
dw 0xAA55        ; Boot signature