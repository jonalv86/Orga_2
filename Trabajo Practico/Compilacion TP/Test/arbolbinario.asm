section .data
debug: db "Llega a incrementar_nodo",0
debug_valor: db "El valor almacenado es en ebx es: %d y en ecx es: %d",0

extern _malloc
extern _printf

global _agregar_abb

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
    ;Mismo valor
    MOV     ECX, [EBP+12]   ;valor
    MOV     EBX, [EAX]      ;me paro a donde apunta el puntero del arbol
    ;MOV     EDX, [EBX]      ;pido el valor del arbol
    ;CMP     ECX, EDX        ;lo comparo
	CMP     ECX, EBX        ;lo comparo
    JE      incrementar_nodo
    ;Menor valor
    JL      nodo_menor
    ;Mayor valor
    JA      nodo_mayor
    
incrementar_nodo:
push debug
call _printf
ADD ESP, 4
	MOV     EBX, [EBP+8]
    ADD     EBX, 4
    ADD     [EBX], dword 1
    JMP     SALIR
    
nodo_menor:
    ;Inicio add
	MOV     EBX, [EBP+8]
    ADD     EBX, 8
    JMP     nuevo_nodo

nodo_mayor:
	MOV     EBX, [EBP+8]
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
        
SALIR:
    POP     EBP
    RET
    
fail_exit:
    mov  eax, 1
    pop  ebp
    ret
