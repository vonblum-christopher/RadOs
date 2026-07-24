extern "C" {
    void rados_console_init(void);
    void rados_console_print_char(char character);
    void rados_console_print_line(const char* string);
    void rados_init_kernel(void);
    void rados_main(void);
};

int main(void);

int main(void) {
    rados_main();
}

void rados_main(void) {
rados_main:
    rados_init_kernel();

    rados_console_print_line("Hello from RadOs.");
};

void rados_init_kernel(void) {

    rados_console_init();

    rados_console_print_line("RadOs Kernel initialized.");
};

void rados_console_init(void) {
    asm("mov ah, 00h");
    asm("mov al, 07h");
    asm("int 10h");

    asm("mov ah, 01h");
    asm("mov al, 07h");
    asm("mov cx, 0007h");
    asm("int 10h");
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
    asm("mov ah, 0Eh");
    asm("mov al, character");
    asm("mov bh, 0");
    asm("mov bl, 7");
    asm("int 0x10");
};
