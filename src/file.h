#ifndef _FILE_H_
#define _FILE_H_

struct Instruction {
	int opcode;
	int argument;
};

struct Program {
	struct Instruction * instructions;
	int size;
};

int read_program(FILE *, struct Program *);

int program_size(FILE *);

void program_new(struct Program *, int);

int read_int(FILE *);

#endif
