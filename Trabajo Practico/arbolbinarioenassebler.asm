%include "io.inc"

section .data   ;para testear
   ; inicial:    DD 0x0
    inicial:    times 4 DD 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 8
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    ;Inicio print
    MOV     EAX, inicial
    PUSH    EAX
    CALL    mostrar_abb
    ADD     ESP, 4
    ;Fin print
    xor eax, eax
    ret

agregar_abb:
    ;Un puntero al arbol    [EBP+8]
    ;Un valor               [EBP+12]
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JNE     existe_arbol
    MOV     EBX, [EBP+12]
    MOV     [EAX], EBX
    ADD     EAX, 4
    MOV     [EAX], dword 1
    ADD     EAX, 4
    MOV     [EAX], dword 0
    ADD     EAX, 4
    MOV     [EAX], dword 0
    SUB     EAX, 12
    JMP     SALIR
         
existe_arbol:
    ;No implementado
    ;Mismo valor
    MOV
    CMP     EBX
    ;Mayor valor
    ;Menor valor
    JMP     SALIR
    
mostrar_abb:
    ;implentado recursivo
    PUSH    EBP
    MOV	    EBP, ESP
    PRINT_STRING "{"
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      TERMINARMOSTRAR
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    ADD     EAX, 4
    MOV     ECX, [EAX]
    PRINT_UDEC 4, EBX
    PRINT_STRING ":"
    PRINT_UDEC 4, ECX
    PRINT_STRING " "
    ;mostrar nodo izquierdo
    ADD     EAX, 4
    MOV     EBX, [EAX];Testear
    PUSH    EBX
    CALL    mostrar_abb
    ADD     ESP, 4
    PRINT_STRING " "
    ;mostrar nodo derecho
    ADD     EAX, 4
    MOV     EBX, [EAX];Testear
    PUSH    EBX
    CALL    mostrar_abb
    ADD     ESP, 4    
    JMP     TERMINARMOSTRAR
         
SALIR:
    POP     EBP
    RET
    
TERMINARMOSTRAR:
    PRINT_STRING "}"
    JMP     SALIR