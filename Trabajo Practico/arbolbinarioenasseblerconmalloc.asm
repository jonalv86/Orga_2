%include "io.inc"
;extern _puts, _printf, _malloc, _free
extern _malloc
section .data   ;para testear
    inicial:    times 4 DD 0
    test:       db "¡Hola mundo!", 0

section .text
global funcion_test
global CMAIN
CMAIN:
     mov ebp, esp; for correct debugging
    ;write your code here
    
    ;CALL    funcion_test

    ;Inicio add inicial
    MOV     EAX, 0x0    ;NULL
    MOV     EBX, 8
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    ;EAX tiene la posición de memoria de mi variable temporal
    MOV     EBX, inicial
    MOV     [EBX], EAX
    ;Fin add inicial
    
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
    
    ;Inicio print
    MOV     EAX, inicial
    PUSH    EAX
    CALL    mostrar_abb
    ADD     ESP, 4
    ;Fin print
    
    NEWLINE
    
    ;Inicio add
    MOV     EAX, inicial
    MOV     EBX, 17
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
    MOV     EBX, 5
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
    MOV     EAX, [EBP+8]    ;puntero
    ;MOV     EBX, [EAX]
    ;CMP     EBX, 0
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
    ;mov eax, [EbX]
    PUSH    ECX     ;valor
    PUSH    EbX
    CALL    agregar_abb
    ADD     ESP, 8
    ;EAX apunta el nuevo nodo
    pop edx
    mov ecx, [edx]
    cmp ecx, 0
    JNE SALIR
    mov [edx], eax
    ;Fin add
    JMP     SALIR
        
mostrar_abb:
    ;implentado recursivo
    PUSH    EBP
    MOV	    EBP, ESP
    PRINT_STRING "{"
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      TERMINARMOSTRAR
    ;MOV     EAX, [EBP+8]
    ;MOV     EBX, [EAX]
    ;ADD     EBX, 4
    MOV     ECX, [EBX]      ;valor
    ADD     EBX, 4
    MOV     EDX, [EBX]      ;cantidad
    PRINT_UDEC 4, ECX
    PRINT_STRING ":"
    PRINT_UDEC 4, EDX
    PRINT_STRING " "
    ;mostrar nodo izquierdo
    ADD     EBX, 4
    push ebx
    PUSH    EBX
    CALL    mostrar_abb
    ADD     ESP, 4
    pop ebx
    PRINT_STRING " "
    ;mostrar nodo derecho
    ;MOV     EBX, EAX    ;El ret siempre esta en EAX, deberiamos usar esta variable
    ADD     EBX, 4
    ;MOV     EBX, [EAX];Testear
    PUSH    EBX
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
    ADD     EbX, 8
    push ebx
    push ebx
    call borrar_abb
    add esp, 4
    pop ebx
    MOV     [EbX], dword 0
    ADD     EbX, 4
    push ebx
    push ebx
    call borrar_abb
    add esp, 4
    pop ebx
    MOV     [EbX], dword 0
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
    
fail_exit:
    mov  eax, 1
    pop  ebp
    ret