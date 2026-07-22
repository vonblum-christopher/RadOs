extern "C" {
    void rados_print_char(char character);
    void rados_print_line(const char* string);
};

void cppmain (void);

void cppmain (void){
    rados_print_line("Hello World!");
};

void rados_print_line(const char* string) {
    char c = '0';

    for (int i = 0; string[i] != '\0'; i++)
    {
        c = string[i];

        rados_print_char(c);
    }
};

void rados_print_char(char character) {
    asm("mov ah, 0Eh \n"
        "mov al, 'A' \n"
        "mov bh, 0 \n"
        "mov bl, 7 \n"
        "int 0x10 \n"
        "ret \n");
};