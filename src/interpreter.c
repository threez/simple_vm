#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "interpreter.h"
#include "opcodes.h"
#include "debug.h"

int interprete(struct Stack * stack, struct Program * program) {
    int program_pointer = 0,
        new_program_pointer,
        argument,
        halt = -1,
        num_of_variables,
        r1,
        r2;
    struct Instruction * instruction;
    int* variables = 0;
    
    // first instruction (DATA hold count of variables)
    num_of_variables = program->instructions[program_pointer].argument;
    while (program_pointer < program->size - 1 && halt == -1) {
        instruction = &program->instructions[program_pointer];
    new_program_pointer = -1;

#ifdef DEBUG
    printf(" %05d: %s %d\n", program_pointer, 
           opcode_to_str( instruction->opcode), instruction->argument);
#endif

    switch( instruction->opcode) {
      case DATA:
        variables = (int*)malloc(sizeof(int) * num_of_variables);
        break;
      case HALT:
        halt =  instruction->argument;
        free(variables);
        break;
      case READ_INT:
        scanf("%i", &argument);
        stack_push(stack, argument);
        break;
      case WRITE_INT:
        printf("%i\n", stack_pop(stack));
        break;
      case ADD:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, r1 + r2);
        break;
      case SUB:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, r1 - r2);
        break;
      case MULT:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, r1 * r2);
        break;
      case DIV:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, r1 / r2);
        break;
      case PWR:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, (int)pow(r1, r2));
        break;
      case STORE:
        variables[instruction->argument] = stack_pop(stack);
        break;
      case LD_INT:
        stack_push(stack, instruction->argument);
        break;
      case LD_VAR:
        stack_push(stack, variables[instruction->argument]);
        break;
      case JMP_FALSE:
        if (stack_pop(stack) == 0)
          new_program_pointer =  instruction->argument;
        break;
      case GOTO:
        new_program_pointer = instruction->argument;
        break;
      case LT:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, (r1 < r2) ? 1 : 0);
        break;
      case GT:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, (r1 > r2) ? 1 : 0);
        break;
      case EQ:
        r2 = stack_pop(stack);
        r1 = stack_pop(stack);
        stack_push(stack, (r1 == r2) ? 1 : 0);
        break;
    };

    if (new_program_pointer == -1) 
      program_pointer++;
    else
      program_pointer = new_program_pointer;
  }
    
    return halt;
}