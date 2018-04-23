%include "io.inc"
section .data
test: Db "hola mundo", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    MOV     EAX, test
    PUSH    EAX
    CALL    LONGITUD
    ADD     ESP, 4
    PRINT_DEC 4, EAX
    XOR     EAX, EAX
    RET

LONGITUD:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, 0
    MOV     ECX, [EBP+8]
    JMP     CICLOLONGITUD

CICLOLONGITUD:
    MOV     BL, [ECX]
    CMP     BL, 0
    JE      SALIR
    INC     EAX
    ADD     ECX, 1
    JMP     CICLOLONGITUD

SALIR:
    POP	    EBP
    RET