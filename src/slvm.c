#include <stdlib.h>
#include <stdio.h>
#include <math.h>

// VM OP-Codes
#define DATA        0
#define HALT        1
#define READ_INT   20
#define WRITE_INT  21
#define ADD       100
#define SUB       101
#define MULT      102
#define DIV       103
#define PWR       104
#define STORE     150
#define LD_INT    151
#define LD_VAR    152
#define JMP_FALSE 200
#define GOTO      201
#define LT        210
#define GT        211
#define EQ        212

#define STACK_SIZE 10

// read a 4 byte integer in network byte order
int read_int(FILE* code_file) {
  char buffer_32bit[4];
  int argument;

  fread(&buffer_32bit, 1, 4, code_file);
  argument = (buffer_32bit[0] << 24) | (buffer_32bit[1] << 16) | (buffer_32bit[2] << 8) | buffer_32bit[3];
  return argument;
}

struct Instruction {
  int opcode;
  int argument;
};

struct Stack {
  int stack[STACK_SIZE];
  int stack_pointer;
};

void stack_new(struct Stack * stack) {
  int i;
  for (i = 0; i < STACK_SIZE; i++) 
    stack->stack[i] = -1;
  stack->stack_pointer = 0;
}

void stack_push(struct Stack * stack, int value) {
  //printf("Stack(%i): push %i\n", stack->stack_pointer, value);
  stack->stack[stack->stack_pointer] = value;
  stack->stack_pointer++;
}

int stack_pop(struct Stack * stack) {
  int ret_val = stack->stack[stack->stack_pointer - 1];
  //printf("Stack(%i): pop %i\n", stack->stack_pointer, ret_val);
  stack->stack[stack->stack_pointer - 1] = -1; // clear current item
  stack->stack_pointer--;
  return ret_val;
}

int main(int argc, char* argv[]) {
  FILE* code_file = NULL;
  int opcode;
  int argument;
  int halt = -1;
  struct Instruction program[30];
  int program_pointer = 0, new_program_pointer;
  int program_size = 0;
  int* variables;
  int r1, r2;
  struct Stack stack;
  stack_new(&stack);

  if (argc > 1) {
    /* ==== read program code ==== */
    code_file = fopen(argv[1], "r");
    while(!feof(code_file)) {
      opcode = fgetc(code_file);
    
      program[program_pointer].opcode = opcode;
      program[program_pointer].argument = -1;
      switch(opcode) {
        case DATA:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
        case HALT:
          argument = fgetc(code_file);
          program[program_pointer].argument = argument;
          break;
        case STORE:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
        case LD_INT:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
        case LD_VAR:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
        case JMP_FALSE:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
        case GOTO:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
      };
      program_pointer++;
    }
    fclose(code_file);
    program_size = program_pointer;

    /* ==== act as vm ==== */
    program_pointer = 0; // start from 0
    while ( program_pointer < program_size - 1 && halt == -1) {
      new_program_pointer = -1;

      switch(program[program_pointer].opcode) {
        case DATA:
          variables = (int*)malloc(sizeof(int) * program[program_pointer].argument + 1);
          break;
        case HALT:
          halt = program[program_pointer].argument;
          //free(variables);
          break;
        case READ_INT:
          scanf("%i", &argument);
          stack_push(&stack, argument);
          break;
        case WRITE_INT:
          printf("%i\n", stack_pop(&stack));
          break;
        case ADD:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, r1 + r2);
          break;
        case SUB:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, r1 - r2);
          break;
        case MULT:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, r1 * r2);
          break;
        case DIV:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, r1 / r2);
          break;
        case PWR:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, (int)pow(r1, r2));
          break;
        case STORE:
          variables[program[program_pointer].argument] = stack_pop(&stack);
          break;
        case LD_INT:
          stack_push(&stack, program[program_pointer].argument);
          break;
        case LD_VAR:
          stack_push(&stack, variables[program[program_pointer].argument]);
          break;
        case JMP_FALSE:
          if (stack_pop(&stack) == 0)
            new_program_pointer = program[program_pointer].argument;
          break;
        case GOTO:
          new_program_pointer = program[program_pointer].argument;
          break;
        case LT:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, (r1 < r2) ? 1 : 0);
          break;
        case GT:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, (r1 > r2) ? 1 : 0);
          break;
        case EQ:
          r2 = stack_pop(&stack);
          r1 = stack_pop(&stack);
          stack_push(&stack, (r1 == r2) ? 1 : 0);
          break;
      };

      if (new_program_pointer == -1) 
        program_pointer++;
      else
        program_pointer = new_program_pointer;
    }
  } else {
    printf("usage: %s <simple-language.slc>", argv[0]);
  }

  return halt;
}