;http://caswenson.com/2009_09_26_assembly_language_programming_under_os_x_with_nasm
%include "io.inc"

section .data   ;para testear
  ;  inicial:    DD 0x0
    inicial:    times 5000 DD 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    MOV     EAX, inicial
    MOV     EBX, 8
    PUSH    EBX
    PUSH    EAX
    CALL    agregar_abb
    ADD     ESP, 8
    MOV     EAX, inicial
    MOV     EBX, [EAX]
;    PRINT_UDEC 4, EBX
    PUSH    EAX
    CALL    mostrar_abb
    ADD     ESP, 4
    xor eax, eax
    ret

agregar_abb:
    ;Un puntero al arbol    [EBP+12]
    ;Un valor               [EBP+8]
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JNE     existe_arbol
    MOV     EBX, [EBP+12]
    MOV     [EAX], EBX
    ;PRINT_UDEC 4, EBX
    ADD     EAX, 1
    MOV     [EAX], dword 1
    ADD     EAX, 1
    MOV     [EAX], dword 0
    ADD     EAX, 1
    MOV     [EAX], dword 0
    SUB     EAX, 3
    JMP     SALIR
         
existe_arbol:
    ;No implementado
    JMP     SALIR
    
mostrar_abb:
    ;implentado para un solo nodo
    PUSH    EBP
    MOV	    EBP, ESP
    PRINT_STRING "{"
    MOV     EBX, [EAX]
    CMP     EBX, 0
    JE      TERMINARMOSTRAR
    MOV     EAX, [EBP+8]
    MOV     EBX, [EAX]
    ADD     EAX, 1
    MOV     ECX, [EAX]
    PRINT_UDEC 4, EBX
    PRINT_STRING ":"
    PRINT_UDEC 4, ECX
;printf("%d:%d ", a -> valor, a -> cantidad);
    JMP     TERMINARMOSTRAR
         
SALIR:
    POP     EBP
    RET
    
TERMINARMOSTRAR:
    PRINT_STRING "}"
    JMP     SALIR