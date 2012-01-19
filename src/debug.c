#include <stdio.h>
#include "opcodes.h"
#include "debug.h"

// function, that helps debugging the virtual machine
const char * opcode_to_str(int opcode) {
	char * str = "UNKNOWN";
	
	switch(opcode) {
		case DATA:
			str = "DATA";
			break;
		case HALT:
			str = "HALT";
			break;
		case READ_INT:
			str = "READ_INT";
			break;
		case WRITE_INT:
			str = "WRITE_INT";
			break;
		case ADD:
			str = "ADD";
			break;
		case SUB:
			str = "SUB";
			break;
		case MULT:
			str = "MULT";
			break;
		case DIV:
			str = "DIV";
			break;
		case PWR:
			str = "PWR";
			break;
		case STORE:
			str = "STORE";
			break;
		case LD_INT:
			str = "LD_INT";
			break;
		case LD_VAR:
			str = "LD_VAR";
			break;
		case JMP_FALSE:
			str = "JMP_FALSE";
			break;
		case GOTO:
			str = "GOTO";
			break;
		case LT:
			str = "LT";
			break;
		case GT:
			str = "GT";
			break;
		case EQ:
			str = "EQ";
			break;
	}
	
	return str;
}

void debug(const char * str) {
#ifdef DEBUG
    puts(str);
#endif
}
