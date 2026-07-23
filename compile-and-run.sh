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

if [ -d "release" ]; then
   rm -R release
fi

mkdir release

# create bootable iso image
#mkisofs -o release/RadOs.iso -no-emul-boot -boot-load-size 4 -b build/BOOT.BIN ./build
mkisofs -o bootable.iso -b build/BOOT.BIN -no-emul-boot -boot-load-size 4 -boot-info-table -R -J src
# boot from floppy image
qemu-system-x86_64 -cdrom release/RadOs.iso