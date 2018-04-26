;http://caswenson.com/2009_09_26_assembly_language_programming_under_os_x_with_nasm
%include "io.inc"
extern _malloc
;extern free

section .data   ;para testear
    puntero:    dd 0x0
    numero:     dw 8

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;push 12                ; push amount of bytes malloc should allocate, en nuestro caso int+int+posicionNodoIzquierdo+posicionNodoDerecho
    ;call _malloc           ; call malloc
    ;test eax, eax          ; check if the malloc failed
    ;jz   fail_exit         ; 
    ;add esp,4              ; undo push
    ;mov [eax], dword 0xD41 ; 'A\n'
    MOV     EBX, puntero
    MOV     ECX, numero
    PUSH    ECX
    PUSH    EBX
    CALL    agregar_abb
    xor eax, eax
    ret

agregar_abb:
    ;suponemos que las variables están en la pila
    ;Un puntero al arbol    [EBP+8]
    ;y un int de 2 bytes    [EBP+12]  
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EBX, [EBP+8]
    MOV     ECX, [EBP+12]
    MOV     EAX, [EBX]
    CMP     EAX, 0
    JNE     existe_arbol
    MOV     EAX, 12
    call    _malloc
    ;CALL    malloc
    ADD     ESP, 4
    TEST    EAX, EAX        ; check if the malloc failed
    jz   fail_exit
    
    
         
existe_arbol:
    JMP     SALIR
         
SALIR:
    POP     EBP
    RET
                  
fail_exit:
    mov  eax, 1
    pop  ebp
    ret