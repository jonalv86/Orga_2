%include "io.inc"
;int subcadena (char *buffer, char * texto, int desde, int longitud)
;Copia una subcadena de texto a buffer, devuelve la cantidad de caracteres copiados.
section .data
texto:  db "Copia una subcadena de texto a buffer", 0
desde:  dd 10d
hasta:  dd 18d
buffer: times 50 db 0   ;Reservar un espacio en memoria.

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    MOV     EAX, buffer ;[EBP+8]    402028
    MOV     EBX, texto  ;[EBP+12]   402000
    MOV     ECX, desde  ;[EBP+16]   402026
    MOV     EDX, hasta  ;[EBP+20]   402027
    PUSH    EDX
    PUSH    ECX
    PUSH    EBX
    PUSH    EAX
    CALL    SUBSTRING
    PRINT_DEC 4, EAX
    NEWLINE
    PRINT_STRING buffer
    ADD     ESP, 16
    XOR     EAX, EAX
    RET
    
SUBSTRING:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     ECX, [EBP+12]   
    MOV     EAX, [EBP+16]
    ADD     ECX, [EAX]      ;Me paro en el primer char del desde (mp)
    MOV     EAX, [EBP+20]
    ADD     EBX, [EAX]      ;Inicializo el hasta (mp)
    MOV     EAX, 0          ;Inicializo el contador
    MOV     EDX, [EBP+8]    ;Inicializo buffer (mp)
    
CICLOSUBSTRING:
    PUSH    EBX
    PUSH    EAX
    POP     EBX
    MOV     AL, [ECX]
    MOV     [EDX], AL
    MOV     EAX, EBX
    POP     EBX
    ADD     EAX, 1
    CMP     ECX, EBX
    JE      SALIR           ;Si es la misma poscición de memoria SALIR
    ADD     EDX, 1          ;Si no, avanzo a la siguiente posición de memoria del texto y del buffer
    ADD     ECX, 1
    JMP     CICLOSUBSTRING
    
SALIR:
    MOV     BL, 0
    MOV     [EDX], BL
    POP     EBP
    RET