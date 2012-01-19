CC = llvm-gcc
CFLAGS = -Wall -O2

slvm: stack.o file.o interpreter.o debug.o slvm.c
	$(CC) -o slvm stack.o file.o interpreter.o debug.o slvm.c

stack.o: stack.c stack.h
	$(CC) $(CFLAGS) -c stack.c

debug.o: debug.c debug.h
	$(CC) $(CFLAGS) -c debug.c

interpreter.o: interpreter.c interpreter.h
	$(CC) $(CFLAGS) -c interpreter.c

file.o: file.c file.h
	$(CC) $(CFLAGS) -c file.c

clean:
	rm -f *.o slvm

prepare_test:
	../bin/slc ../spec/*.sl

test: slvm prepare_test
	./slvm fib.slc sample.slc math.slc