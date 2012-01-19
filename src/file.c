#include <stdlib.h>
#include <stdio.h>
#include "file.h"
#include "opcodes.h"
#include "debug.h"

void program_new(struct Program * program, int size) {
	program->instructions = (struct Instruction *)malloc(sizeof(struct Instruction) * size);
	program->size = size;
}

int program_size(FILE * code_file) {
	int pointer = 0, opcode = -1;
    while(!feof(code_file)) {
        opcode = fgetc(code_file);
        switch(opcode) {
            case HALT:
                fgetc(code_file);
                break;
            case DATA:
            case STORE:
            case LD_INT:
            case LD_VAR:
            case JMP_FALSE:
            case GOTO:
                read_int(code_file);
                break;
        };
        pointer++;
    }
	return pointer;
}

int read_program(FILE * code_file, struct Program * program) {
	int pointer = 0, opcode = -1, argument = 0;
	struct Instruction * instruction;
	
    debug(" * reading programm code");
    while(!feof(code_file)) {
        opcode = fgetc(code_file); 
		instruction = &program->instructions[pointer];
		instruction->opcode = opcode;
        instruction->argument = -1;
        switch(opcode) {
            case HALT:
                argument = fgetc(code_file);
                instruction->argument = argument;
                break;
            case DATA:
            case STORE:
            case LD_INT:
            case LD_VAR:
            case JMP_FALSE:
            case GOTO:
                argument = read_int(code_file);
                instruction->argument = argument;
                break;
        };
#ifdef DEBUG
        if (opcode != -1)
            printf("%s %d\n", opcode_to_str(opcode), argument);
#endif
        pointer++;
    }
    debug(" * file read and closed");
    return (program->size = pointer);
}

// read a 4 byte integer in network byte order
int read_int(FILE* code_file) {
  char buffer_32bit[4];
  int argument;

  fread(&buffer_32bit, 1, 4, code_file);
  argument = (buffer_32bit[0] << 24) | (buffer_32bit[1] << 16) | (buffer_32bit[2] << 8) | buffer_32bit[3];
  return argument;
}
