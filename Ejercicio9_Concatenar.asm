%include "io.inc"
section .data
testa:  db "Hola ", 0
testb:  db "mundo", 0
buffer: times 50 db 0   ;Reservar un espacio en memoria.


section .text
global CMAIN
CMAIN:
    mov     ebp, esp; for correct debugging
    ;write your code here
    MOV     EAX, buffer
    MOV     EBX, testa
    MOV     ECX, testb
    PUSH    ECX
    PUSH    EBX
    PUSH    EAX
    CALL    CONCATENAR
    PRINT_STRING buffer
    ADD     ESP, 12
    XOR     EAX, EAX
    RET

CONCATENAR:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, 0          ;String 0
    MOV     EDX, [EBP+8]    ;buffer
    MOV     ECX, [EBP+12]   ;testa
    JMP     CICLOCONCATENAR

CICLOCONCATENAR:
    MOV     BL, [ECX]
    CMP     BL, 0
    JE      SGUIENTESTRING
    MOV     [EDX], BL
    ADD     EDX, 1
    ADD     ECX, 1
    JMP     CICLOCONCATENAR

SGUIENTESTRING:
    CMP     EAX, 1              ;Podría usarse para un array de strings
    JE      SALIR
    ADD     EAX, 1              ;String 1 en la primera vuelta
    MOV     ECX, [EBP+12+EAX*4] ;testb en la primera vuelta
    JMP     CICLOCONCATENAR
    
SALIR:
    MOV     BL, 0
    MOV     [EDX], BL
    POP     EBP
    RET