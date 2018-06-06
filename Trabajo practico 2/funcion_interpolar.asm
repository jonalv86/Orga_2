%include "io.inc"
section .data

vector: dd 256, 4, 6, 8
vector2: dd 0.5, 0.5, 0.5, 0.5

;void interpolar(unsigned char *img1, 
;                unsigned char *img2,
;                unsigned char *resultado,
;                float p,
;                int cantidad);

global _interpolar

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;r = p × v1 + (1 - p) × v2
    mov eax, vector
    mov ebx, vector2
    movups xmm0, [eax]
    movups xmm1, [ebx]
    mulps xmm0, xmm1
    
    xor eax, eax
    ret
    
_interpolar:
    PUSH    EBP
    MOV	    EBP,    ESP
;Lo anterior es bligatorio.
;[EBP+8]    Puntero a img1          v1
;[EBP+12]   Puntero a img2          v2
;[EBP+16]   Puntero al resultado
;[EBP+20]   Valor de p              p
;[EBP+24]   Tamaño del buffer
;Inicio de la función.
    MOV     EAX,    [EBP+8]
    MOV     EBX,    [EBP+12]
    MOV     EDX,    [EBP+16]
    ;MOV     ST0,    [EBP+20]
    ;Hacer un vector con la constante y alojar en XMM3
    ;En XMM4 guardar 1,1,1,1 y restarle XMM3
    XOR     ECX,    ECX
    MOV     CL,     [EBP+24]
CICLOINTERPOLAR:
    CMP     AL,     0
    JE      SALIR
    ;r = v1 x p + (1 - p) × v2
    MOVUPS  XMM0,   [EAX]
    MOVUPS  XMM1,   [EBX]
    MULPS   XMM0,   XMM3
    MULPS   XMM1,   XMM4
    ADDPS   XMM0,   XMM1
    MOVAPS  [EDX],  XMM0
    ;pasar los floats a enteros para guardar en [EDX]
    SUB     CL,     8
    ADD     EAX,    8
    ADD     EBX,    8
    ADD     ECX,    8
    JMP     CICLOINTERPOLAR
;Fin de la función.
SALIR:
    POP     EBP
    RET