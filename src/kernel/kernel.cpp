extern "C" {
    void cppmain (void);
    void rad_print_char(char character);
    void rad_print_line(const char* string);
};

void cppmain (void){
    rad_print_line("Hello World!");
};

void rad_print_line(const char* string) {
    char c = '0';

    for (int i = 0; string[i] != '\0'; i++)
    {
        c = string[i];

        rad_print_char(c);
    }
};

void rad_print_char(char character) {

    /*asm_rad_print_char:
        mov ah, 0Eh
        mov al, 'A'
        mov bh, 0
        mov bl, 7
        int 10h
        ret*/
};