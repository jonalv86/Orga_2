%include "io.inc"
extern _malloc

global _agregar_abb
global _mostrar_abb
global _borrar_abb

section .text
_agregar_abb:
    ;Un puntero al arbol    [EBP+8]
    ;Un valor               [EBP+12]
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]    ;puntero
    CMP     EAX, 0          ;el puntero es nulo?
    JE iniciar_arbol
    MOV ebx, [EAX]
    cmp ebx, 0
    JNE     existe_arbol

iniciar_arbol:    
    ; malloc 32 bytes
    push  dword 32
    call  _malloc
    add  esp, 4

    ; check if the malloc failed
    test  eax, eax
    jz    fail_exit
    
    ;creo el arbol
    MOV     EBX, [EBP+12]   ;valor
    MOV     [EAX], EBX
    ADD     EAX, 4
    MOV     [EAX], dword 1
    ADD     EAX, 4
    MOV     [EAX], dword 0
    ADD     EAX, 4
    MOV     [EAX], dword 0
    SUB     EAX, 12
    JMP     SALIR
         
    ;me falta guardar los punteros anteriores, hay que usar la pila
existe_arbol:
    ;No implementado
    ;Mismo valor
    MOV     ECX, [EBP+12]   ;valor
    MOV     EBX, [EAX]      ;me paro a donde apunta el puntero del arbol
    MOV     EDX, [EBX]      ;pido el valor del arbol
    CMP     ECX, EDX        ;lo comparo
    JE      incrementar_nodo
    ;Menor valor
    JL      nodo_menor
    ;Mayor valor
    JA      nodo_mayor
    
incrementar_nodo:
    ADD     EBX, 4
    ADD     [EBX], dword 1
    JMP     SALIR
    
nodo_menor:
    ;Inicio add
    ADD     EBX, 8
    JMP     nuevo_nodo

nodo_mayor:
    ADD     EBX, 12
    
nuevo_nodo:    
    ;Inicio add
    push ebx
    PUSH    ECX     ;valor
    PUSH    EbX
    CALL    _agregar_abb
    ADD     ESP, 8
    ;EAX apunta el nuevo nodo
    pop edx
    mov ecx, [edx]
    cmp ecx, 0
    JNE SALIR
    mov [edx], eax
    ;Fin add
    JMP     SALIR
        
_mostrar_abb:
    ;implentado recursivo
    PUSH    EBP
    MOV	    EBP, ESP
    ;PRINT_STRING "{"
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      TERMINARMOSTRAR
    MOV     ECX, [EBX]      ;valor
    ADD     EBX, 4
    MOV     EDX, [EBX]      ;cantidad
    ;PRINT_UDEC 4, ECX
    ;PRINT_STRING ":"
    ;PRINT_UDEC 4, EDX
    ;PRINT_STRING " "
    ;mostrar nodo izquierdo
    ADD     EBX, 4
    push ebx
    PUSH    EBX
    CALL    _mostrar_abb
    ADD     ESP, 4
    pop ebx
    ;PRINT_STRING " "
    ;mostrar nodo derecho
    ADD     EBX, 4
    PUSH    EBX
    CALL    _mostrar_abb
    ADD     ESP, 4    
    JMP     TERMINARMOSTRAR
    
_borrar_abb:
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      SALIR
    ADD     EbX, 8
    push ebx
    push ebx
    call _borrar_abb
    add esp, 4
    pop ebx
    MOV     [EbX], dword 0
    ADD     EbX, 4
    push ebx
    push ebx
    call _borrar_abb
    add esp, 4
    pop ebx
    MOV     [EbX], dword 0
    JMP     SALIR
         
SALIR:
    POP     EBP
    RET
    
TERMINARMOSTRAR:
    ;PRINT_STRING "}"
    JMP     SALIR
    
fail_exit:
    mov  eax, 1
    pop  ebp
    ret