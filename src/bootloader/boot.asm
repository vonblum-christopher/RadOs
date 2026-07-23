bits 16                        ; Tell NASM we are in 16-bit Real Mode
section .text
org 0x7C00                     ; Tell the assembler where the BIOS loads us

start:
    mov si, message            ; Point SI to our message string
    mov ah, 0x0E               ; BIOS function 0x0E: Print character in TTY mode
    jmp load_kernel

.print_char:
    lodsb                      ; Load next byte from SI into AL
    or al, al                  ; Check if character is zero (end of string)
    int 0x10                   ; Call BIOS video interrupt to print character
    jz .end_print_char
    jmp .print_char             ; Loop to print next character
.end_print_char:
    ret

message:
    db 'RadOs booting...', 0      ; The string to print, followed by a null terminator

load_kernel:
    incbin './kernel.bin'

end_kernel:

call load_kernel

times 510 - ($ - $$) db 0      ; Pad the file with zeros up to 510 bytes
dw 0xAA55 