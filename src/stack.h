#ifndef _STACK_H_
#define _STACK_H_

struct Stack {
	int * stack;
	int size;
	int stack_pointer;
};

void stack_new(struct Stack *, int);

void stack_push(struct Stack *, int);

int stack_pop(struct Stack *);

void stack_print(struct Stack *);

#endif
