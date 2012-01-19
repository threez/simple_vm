#include <stdio.h>
#include "stack.h"
#include "file.h"
#include "debug.h"
#include "interpreter.h"

int main(int argc, char* argv[]) {
    struct Stack stack;
    struct Program program;
    int exit_code = 1, file_nr, size;
    FILE * code_file;
    
    stack_new(&stack, 100);
    debug(" * created stack of 100");
    
    if (argc > 1) {
        for (file_nr = 1; file_nr < argc; file_nr++) {
#ifdef DEBUG
            printf(" * open file '%s'\n", argv[file_nr]);
#endif
            code_file = fopen(argv[file_nr], "r");
            debug(" * start programm");
            size = program_size(code_file);
            fseek(code_file, 0, SEEK_SET);
            program_new(&program, size);
            debug(" * created programm, start reading...");
            read_program(code_file, &program);
            exit_code = interprete(&stack, &program);
            fclose(code_file);
        }
    } else {
        debug(" ! no programm specified, vm will end");
        printf("usage: %s {simple-language.slc}\n", argv[0]);
    }
    
    return exit_code;
}
