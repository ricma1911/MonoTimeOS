CC = gcc
CFLAGS = -Wall -Wextra -ffreestanding -nostdlib -nostartfiles 

kernel.elf: main.o boot.o
	$(CC) $(CFLAGS) -no-pie -T linker.ld $^ -o kernel.elf

main.o: kernel/main.c
	$(CC) $(CFLAGS) -fno-pie -c $^ -o main.o

boot.o: arch/x86_64/boot.S
	$(CC) $(CFLAGS) -fno-pie -c $^ -o boot.o

clean:
	rm -rf *.o *.elf