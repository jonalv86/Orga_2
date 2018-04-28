%include "io.inc"

section .data   ;para testear
   ; inicial:    DD 0x0
    inicial:    times 400000 DD 0
    test:       db "¡Hola mundo!", 0

section .text
global CMAIN
CMAIN:
     mov ebp, esp; for correct debugging
    ;write your code here
    
    CALL    funcion_test

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
    
    NEWLINE
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 54
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 17
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 5
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 8
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 5
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 70
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 75
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 2
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 4
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
    
    NEWLINE
    
    ;Inicio borrar
    MOV     EAX, inicial
    PUSH    EAX
    CALL    borrar_abb
    ADD     ESP, 4
    ;Fin borrar
    
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
    MOV     ECX, [EBP+12]
    MOV     EDX, [EAX]
    CMP     ECX, EDX
    JE      incrementar_nodo
    ;Menor valor
    JL      nodo_menor
    ;Mayor valor
    JA      nodo_mayor
    
incrementar_nodo:
    ADD     EAX, 4
    ADD     [EAX], dword 1
    JMP     SALIR
    
nodo_menor:
    ;Inicio add
    ADD     EAX, 8
    JMP     nuevo_nodo

nodo_mayor:
    ADD     EAX, 12
    
nuevo_nodo:    
    ;Inicio add
    ;MOV     EBX, [EAX]
    PUSH    ECX ;valor
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;Fin add
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
    ;MOV     EBX, [EAX];Testear
    PUSH    EAX
    CALL    mostrar_abb
    ADD     ESP, 4
    PRINT_STRING " "
    ;mostrar nodo derecho
    ADD     EAX, 4
    ;MOV     EBX, [EAX];Testear
    PUSH    EAX
    CALL    mostrar_abb
    ADD     ESP, 4    
    JMP     TERMINARMOSTRAR
    
borrar_abb:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      SALIR
    ADD     EAX, 8
    MOV     [EAX], dword 0
    ADD     EAX, 4
    MOV     [EAX], dword 0
    JMP     SALIR
         
SALIR:
    POP     EBP
    RET
    
TERMINARMOSTRAR:
    PRINT_STRING "}"
    JMP     SALIR
    
funcion_test:
    PUSH    EBP
    MOV	    EBP, ESP
    PRINT_STRING test
    NEWLINE
    JMP     SALIR