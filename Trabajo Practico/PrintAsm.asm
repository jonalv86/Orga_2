%include "io.inc"

section .text
global funcion_test

funcion_test:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EBP+16]
    ADD     EAX, EBX
    JMP     SALIR
	
SALIR:
    POP     EBP
    RET