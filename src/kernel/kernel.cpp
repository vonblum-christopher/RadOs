extern "C" {
    void rados_console_init(void);
    void rados_console_print_char(char character);
    void rados_console_print_line(const char* string);
    int main( int argc, char *argv[ ], char *envp[ ] );
};

int main( int argc, char *argv[ ], char *envp[ ] ) {

    rados_console_init();

    rados_console_print_line("Hello from RadOs.");

    while (true) {
        rados_console_print_line("Hello World!");
    }

    return 0;
};

void rados_console_init(void) {
    asm("mov ah, 00h \n"
        "mov al, 07h \n"
        "int 10h \n");

    asm("mov ah, 01h \n"
        "mov al, 07h \n"
        "mov cx, 0007h \n"
        "int 10h \n");
}

void rados_console_print_line(const char* string) {
    for (int i = 0; string[i] != '\0'; i++)
    {
        char c = string[i];

        rados_console_print_char(c);
    }

    rados_console_print_char('\r');
    rados_console_print_char('\n');
};

void rados_console_print_char(char character) {
    asm("mov ah, 0Eh \n"
        "mov al, character \n"
        "mov bh, 0 \n"
        "mov bl, 7 \n"
        "int 0x10 \n");
};