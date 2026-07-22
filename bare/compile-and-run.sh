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
clang++ -fuse-ld=lld -o build/mainc.o -c src/kernel/main.cpp -fPIC -shared -nostartfiles -nostdlib -nodefaultlibs
#gcc src/kernel/stdio/stdio.c -o build/kernel/c/stdio.obj

# asm kernel parts
nasm -f elf64 src/kernel/main.asm -o build/maina.o

# link everything
#clang++ -fuse-ld=lld -fPIC -shared \
#-o build/kernel.o -lc \
#build/mainc.o \
#build/maina.o

clang++ -v -fuse-ld=lld build/maina.o build/mainc.o -o build/kernel.bin

# mount floppy image
mkdir floppy

mount build/floppy.img floppy

cat build/kernel.bin >> floppy/kernel.bin

umount floppy

# boot from floppy image
qemu-system-x86_64 -fda build/floppy.img

#nasm -f elf64 datei.asm -o asm_teil.o
#gcc -c datei.c -o c_teil.o
#ld asm_teil.o c_teil.o -o ausgabe -lc