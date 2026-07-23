#!/bin/bash -v
# error cancels script
set -e

# clean the build direcotry
if [ -d "build" ]; then
   rm -R build
fi

# create or recreate the build directory
mkdir build

# c kernel parts
clang++ -c src/kernel/kernel.cpp -o build/kernel.o -fuse-ld=lld -masm=intel -Wl -fPIC -shared -nostartfiles -nostdlib -nodefaultlibs
objcopy -O binary build/kernel.o build/kernel.bin

cd build

mkdir boot

# compile the bootloader
nasm -f bin ./../src/bootloader/boot.asm -o ./boot/boot.bin

cp ./boot/boot.bin boot.bin

genisoimage -o RadOs.iso -b boot.bin -no-emul-boot -boot-load-size 4 -boot-info-table ./boot

cd ..

# boot from cdrom image
qemu-system-x86_64 -cdrom build/RadOs.iso