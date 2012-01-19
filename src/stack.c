#include <stdio.h>
#include <stdlib.h>
#include "stack.h"

void stack_new(struct Stack * stack, int size) {
  stack->stack = (int *)malloc(size * sizeof(int));
  stack->size = size;
  int i;
  for (i = 0; i < size; i++) 
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
