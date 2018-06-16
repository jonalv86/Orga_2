%include "io.inc"
section .data

vector: dd 2, 4, 6, 8
vector2: dd 1.3, 1.4, 1.5, 1.6
radio:  dd 1.7
constante: dd 1,1,1,1
vector3: dd 0, 0, 0, 0

;Constantes usadas en la cuanta
constanteuno: dd 1,1,1,1
multvdos: dd 0, 0, 0, 0

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
    cvttps2dq xmm1, xmm1

    fld dword [radio]
    mov ecx, vector3
    fst dword [ecx]
    add ecx, 4
    fst dword [ecx]
    add ecx, 4
    fst dword [ecx]
    add ecx, 4
    fst dword [ecx]
    mov ecx, vector3
    movups xmm0, [ecx]
    
    xor eax, eax
    ret
    
_interpolar:
    PUSH        EBP
    MOV	        EBP,    ESP
;Lo anterior es obligatorio.
;[EBP+8]    Puntero a img1          v1
;[EBP+12]   Puntero a img2          v2
;[EBP+16]   Puntero al resultado
;[EBP+20]   Valor de p              p
;[EBP+24]   Tamaño del buffer
;Inicio de la función.
    MOV         EAX,    [EBP+8]
    MOV         EBX,    [EBP+12]
    MOV         EDX,    [EBP+16]
    ;MOV     ST0,    [EBP+20]
    ;Hacer un vector con la constante y alojar en XMM3
    MOV         ECX,    multvdos
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    MOV         ECX,    multvdos
    MOVUPS      XMM3,   [ecx]
    ;En XMM4 guardar 1,1,1,1 y restarle XMM3
    MOV         ECX,    constanteuno
    MOVUPS      XMM4,   [ecx]
    ;TODO: Falta restarlos y alojarlo en XMM4
    
    XOR         ECX,    ECX
    MOV         CL,     [EBP+24]
CICLOINTERPOLAR:
    CMP         AL,     0
    JE          SALIR
    ;r = v1 x p + (1 - p) × v2
    MOVUPS      XMM0,   [EAX]
    MOVUPS      XMM1,   [EBX]
    MULPS       XMM0,   XMM3
    MULPS       XMM1,   XMM4
    ADDPS       XMM0,   XMM1
    ;pasar los floats a enteros para guardar en [EDX]
    CVTTPS2DQ   XMM0,   XMM0
    MOVAPS      [EDX],  XMM0
    SUB         CL,     8
    ADD         EAX,    8
    ADD         EBX,    8
    ADD         ECX,    8
    JMP         CICLOINTERPOLAR
;Fin de la función.
SALIR:
    POP         EBP
    RET