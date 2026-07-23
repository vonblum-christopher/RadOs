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
nasm src/bootloader/boot.asm -f bin -o build/BOOT.BIN

# c kernel parts
clang++ -c src/kernel/kernel.cpp -o build/kernel.o -fuse-ld=lld -masm=intel -Wl -fPIC -shared -nostartfiles -nostdlib -nodefaultlibs
objcopy -O binary build/kernel.o build/KERNEL.BIN

cd build

genisoimage -o RadOs.iso -b BOOT.BIN -no-emul-boot -boot-load-size 4 -boot-info-table .

cd ..

# boot from cdrom image
qemu-system-x86_64 -cdrom build/RadOs.iso