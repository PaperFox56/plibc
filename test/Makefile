all:
	@gcc -c main.c -I include -fno-stack-protector -o bin/main.o
	@gcc -nostdlib -nostartfiles -static bin/main.o ../zig-out/obj/crt.o -L ../zig-out/lib -lplibc -o bin/main
	@bin/main