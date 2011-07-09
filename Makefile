all: hello_world find_max

hello_world.o: hello_world.s

hello_world: hello_world.o
	ld hello_world.o -o hello_world

find_max.o: find_max.s

find_max: find_max.o
	ld find_max.o -o find_max

clean:
	@rm -f *.o hello_world find_max

