all: hello_world

hello_world.o: hello_world.s

hello_world: hello_world.o
	ld hello_world.o -o hello_world

clean:
	@rm -f *.o hello_world

