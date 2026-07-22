#!/bin/bash -v
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
clang++ -fuse-ld=lld -c src/kernel/kernel.cpp -o build/kernel.bin -e cppmain -masm=intel -Wl -fPIC -shared -nostartfiles -nostdlib -nodefaultlibs

# clean mountpoint for floppy image
if [ -d "floppy" ]; then
   rm -R floppy
fi

# mount floppy image
mkdir floppy

mount build/floppy.img floppy

# add kernel.bin
cat build/kernel.bin >> floppy/kernel.bin

umount floppy

# boot from floppy image
qemu-system-x86_64 -fda build/floppy.img