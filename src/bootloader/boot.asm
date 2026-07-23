bits 16                        ; Tell NASM we are in 16-bit Real Mode
org 0x7C00                     ; Tell the assembler where the BIOS loads us

DEFAULT REL

start:
    mov si, message            ; Point SI to our message string
    mov ah, 0x0E               ; BIOS function 0x0E: Print character in TTY mode

.print_char:
    lodsb                      ; Load next byte from SI into AL
    or al, al                  ; Check if character is zero (end of string)
    jz .halt                   ; If zero, jump to halt
    int 0x10                   ; Call BIOS video interrupt to print character
    jmp .print_char            ; Loop to print next character

.halt:
    cli                        ; Disable interrupts
    hlt                        ; Halt the CPU

message:
    db 'RadOs booting...', 0      ; The string to print, followed by a null terminator

jmp start

times 510 - ($ - $$) db 0      ; Pad the file with zeros up to 510 bytes
dw 0xAA55 