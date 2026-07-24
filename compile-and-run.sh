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

cd build

mkdir files

objcopy -O binary kernel.o kernel.bin

nasm -f bin ./../src/kernel/boot.asm -o boot.bin

cp boot.bin files

genisoimage -o RadOs.iso -b boot.bin -no-emul-boot -boot-load-size 4 -boot-info-table ./files

cd ..

# boot from cdrom image
qemu-system-x86_64 -cdrom build/RadOs.iso