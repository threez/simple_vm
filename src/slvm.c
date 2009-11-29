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

#define STACK_SIZE 100

// function, that helps debugging the virtual machine
const char * opcode_to_str(int opcode) {
  char * opcode_str = NULL;
  
  switch(opcode) {
    case DATA:
      opcode_str = "DATA";
      break;
    case HALT:
      opcode_str = "HALT";
      break;
    case READ_INT:
      opcode_str = "READ_INT";
      break;
    case WRITE_INT:
      opcode_str = "WRITE_INT";
      break;
    case ADD:
      opcode_str = "ADD";
      break;
    case SUB:
      opcode_str = "SUB";
      break;
    case MULT:
      opcode_str = "MULT";
      break;
    case DIV:
      opcode_str = "DIV";
      break;
    case PWR:
      opcode_str = "PWR";
      break;
    case STORE:
      opcode_str = "STORE";
      break;
    case LD_INT:
      opcode_str = "LD_INT";
      break;
    case LD_VAR:
      opcode_str = "LD_VAR";
      break;
    case JMP_FALSE:
      opcode_str = "JMP_FALSE";
      break;
    case GOTO:
      opcode_str = "GOTO";
      break;
    case LT:
      opcode_str = "LT";
      break;
    case GT:
      opcode_str = "GT";
      break;
    case EQ:
      opcode_str = "EQ";
      break;
  }
  
  return opcode_str;
}

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
#ifdef DEBUG
  printf(" stack push <- %i (pointer %i + 1)\n", value, stack->stack_pointer);
#endif
  stack->stack[stack->stack_pointer] = value;
  stack->stack_pointer++;
#ifdef DEBUG
  stack_print(stack);
#endif
}

int stack_pop(struct Stack * stack) {
  int ret_val = stack->stack[stack->stack_pointer - 1];
#ifdef DEBUG
  printf(" stack pop -> %i (pointer %i - 1)\n", ret_val, stack->stack_pointer);
#endif
  stack->stack[stack->stack_pointer - 1] = -1; // clear current item
  stack->stack_pointer--;
#ifdef DEBUG
  stack_print(stack);
#endif
  return ret_val;
}

void stack_print(struct Stack * stack) {
  int i;
  if (stack->stack_pointer > 0) {
    puts(" stack frame: ");
    for (i = stack->stack_pointer - 1 ; i >= 0; i--)
      printf("   %i: %i\n", i, stack->stack[i]);
  } else {
      puts(" stack is empty");
  }
}

int main(int argc, char* argv[]) {
#ifdef DEBUG
  puts("Simple VM v0.2 starting");
#endif
  FILE* code_file = NULL;
  int opcode, argument;
  int halt = -1;
  struct Instruction program[30];
  int program_pointer = 0, new_program_pointer;
  int program_size = 0, num_of_variables;
  int* variables = NULL;
  int r1, r2;
  struct Stack stack;
  stack_new(&stack);

  if (argc > 1) {
    /* ==== read program code ==== */
#ifdef DEBUG
    puts(" * reading programm code");
#endif
    code_file = fopen(argv[1], "r");
#ifdef DEBUG
    printf(" * open file '%s'\n", argv[1]);
#endif
    while(!feof(code_file)) {
      opcode = fgetc(code_file);    
      program[program_pointer].opcode = opcode;
      program[program_pointer].argument = -1;
      switch(opcode) {
        case HALT:
          argument = fgetc(code_file);
          program[program_pointer].argument = argument;
          break;
        case DATA:
        case STORE:
        case LD_INT:
        case LD_VAR:
        case JMP_FALSE:
        case GOTO:
          argument = read_int(code_file);
          program[program_pointer].argument = argument;
          break;
      };    
#ifdef DEBUG
      if (opcode != -1)
        printf("%s %d\n", opcode_to_str(opcode), argument);
#endif
      program_pointer++;
    }
    fclose(code_file);
#ifdef DEBUG
    puts(" * file read and closed");
#endif
    program_size = program_pointer;

    /* ==== act as vm ==== */
    program_pointer = 0; // start from 0
#ifdef DEBUG
    puts(" * start programm");
#endif
    // first instruction (DATA hold cound of variables)
    num_of_variables = program[program_pointer].argument;
    while (program_pointer < program_size - 1 && halt == -1) {
      new_program_pointer = -1;

#ifdef DEBUG
      printf(" %05d: %s %d\n", program_pointer, 
                           opcode_to_str(program[program_pointer].opcode),
                           program[program_pointer].argument);
#endif

      switch(program[program_pointer].opcode) {
        case DATA:
          variables = (int*)malloc(sizeof(int) * num_of_variables);
          break;
        case HALT:
          halt = program[program_pointer].argument;
          free(variables);
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
#ifdef DEBUG  
    puts(" ! no programm specified, vm will end");
#endif
    printf("usage: %s <simple-language.slc>\n", argv[0]);
  }

  return halt;
}
