#Karl Chavez

all: part1 part2 part3

part1: part1.o
	gcc part1.o -g -o $@

part2: part2.o
	gcc part2.o -g -o $@

part3: part3.o
	gcc part3.o -g -o $@

%.o: %.s
	gcc -g -c $< -o $@

zip:
	zip lab6.zip makefile *.s readme

clean:
	rm -rf *.o
