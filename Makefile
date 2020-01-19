

kernel: kernel.asm kernel.c link.ld
	nasm -f elf32 kernel.asm -o kasm.o
	gcc -m32 -c kernel.c -o kc.o
	ld -m elf_i386 -T link.ld -o kernel kasm.o kc.o

run: kernel
	qemu-system-i386 -kernel kernel

grub.img: kernel
	cp kernel iso/boot/kernel-701
	grub-mkrescue -o '$@' iso

run-grub: grub.img
	qemu-system-i386 -drive 'file=grub.img,format=raw'

clean:
	rm -f grub.img kernel kasm.o iso/boot/kernel-701 kc.o
