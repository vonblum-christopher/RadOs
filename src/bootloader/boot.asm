BITS 64
ORG 0x7C00
DEFAULT REL

section .text
main:
    CLI
    MOV ax, ds
    MOV ss, ax
    MOV sp, 0
    MOV bp, sp

    sti

    mov ah, 00h
    mov al, 07h
    int 10h

    mov ah, 01h
    mov al, 07h
    mov cx, 0007h
    int 10h

    mov ah, 0Eh
    mov al, 'B'
    mov bh, 0
    mov bl, 7
    int 10h

    ;CALL asm_rad_print_char;
    ret

;asm_rad_print_char:
;    mov ah, 0Eh
;    mov al, 'B'
;    mov bh, 0
;    mov bl, 7
;   int 10h
;  ret

; ------------------------------------------------------------------
; END OF BOOT SECTOR AND BUFFER START

	times 510-($-$$) db 0	; Pad remainder of boot sector with zeros
	dw 0AA55h		; Boot signature (DO NOT CHANGE!)


buffer:				; Disk buffer begins (8k after this, stack starts)


; ==================================================================

