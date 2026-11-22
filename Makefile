CC = gcc
CFLAGS = -Wall -Wextra -ffreestanding -nostdlib -nostartfiles 

iso: copy_grub_cfg
	grub-mkrescue -o monotimeos.iso isodir

copy_grub_cfg: copy_elf 
	cp -r bootloader/grub isodir/boot/

copy_elf: mkdir_boot
	cp -r kernel.elf isodir/boot/

mkdir_boot: mkdir 
	mkdir -p isodir/boot

mkdir: kernel.elf 
	mkdir -p isodir

kernel.elf: main.o boot.o
	$(CC) $(CFLAGS) -Wl,--build-id=none -no-pie -T linker.ld $^ -o kernel.elf

main.o: kernel/main.c
	$(CC) $(CFLAGS) -fno-pie -c $^ -o main.o

boot.o: arch/x86_64/boot.S
	$(CC) $(CFLAGS) -fno-pie -c $^ -o boot.o

clean:
	rm -rf *.o *.elf *.log *.iso isodir