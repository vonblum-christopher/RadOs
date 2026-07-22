#!/bin/bash
# error cancels script
set -e

# clean the build direcotry
if [ -d "build" ]; then
   rm -R build
fi

# create or recreate the build directory
mkdir build

#compile the bootloader
nasm src/bootloader/boot.asm -f bin -o build/boot.bin

# create a bootable floppy
mkfs.msdos -C build/floppy.img 1440

#write bootloader to floppy
dd if=build/boot.bin of=build/floppy.img bs=512 count=1 conv=notrunc

# c kernel parts
gcc -shared -nostartfiles -nostdlib -nodefaultlibs -o build/mainc.o -c src/kernel/main.cpp
#gcc src/kernel/stdio/stdio.c -o build/kernel/c/stdio.obj

# asm kernel parts
nasm -f elf64 src/kernel/main.asm -o build/maina.o

# link everything
gcc -shared c \
build/maina.o \
build/mainc.o \
-o kernel.bin

# boot from floppy image
qemu-system-x86_64 -fda build/floppy.img


#nasm -f elf64 datei.asm -o asm_teil.o
#gcc -c datei.c -o c_teil.o
#ld asm_teil.o c_teil.o -o ausgabe -lc