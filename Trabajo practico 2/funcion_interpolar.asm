;%include "io.inc"
section .data

;testing general
;vector: dd 30, 60, 90, 120
;vector2: dd 0.5, 0.5, 0.5, 0.5
;radio:  dd 1.7
;constante: dd 1,1,1,1
;vector3: dd 0, 0, 0, 0
;variable: dd 0.4

;testing funcion
;img1:       dd  32, 16, 8, 4, 32;, 16, 8
;img2:       dd  4, 4, 4, 4, 4;, 4, 4
;resultado:  dd  0,0,0,0,0;,0,0
;p:          dd  0.5
;cantidad:   dd  5


;Constantes usadas en la cuenta
constanteuno: dd 1.0
multvuno: dd 0, 0, 0, 0
multvdos: dd 0, 0, 0, 0

;void interpolar(unsigned char *img1, 
;                unsigned char *img2,
;                unsigned char *resultado,
;                float p,
;                int cantidad);

global _interpolar

section .text
;global CMAIN
;CMAIN:
;    mov ebp, esp; for correct debugging
    ;write your code here
    ;r = p × v1 + (1 - p) × v2
    
    ;testing 1
    ;mov eax, vector
    ;mov ebx, vector2
    ;movups xmm0, [eax]
    ;movups xmm1, [ebx]
    ;mulps xmm0, xmm1
    ;cvttps2dq xmm1, xmm1
    
    ;testing 2
    ;fld dword [radio]
    ;mov ecx, vector3
    ;fst dword [ecx]
    ;add ecx, 4
    ;fst dword [ecx]
    ;add ecx, 4
    ;fst dword [ecx]
    ;add ecx, 4
    ;fst dword [ecx]
    ;mov ecx, vector3
    ;movups xmm0, [ecx]
    ;fld dword [variable]
    ;fld dword [constanteuno]
    ;fsub st0, st1
    
    ;testing 5
    ;mov eax, img1
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    ;add eax, 4
    ;mov ebx, [eax]
    
    ;testing 4 (funcion)
    ;mov eax, [cantidad]
    ;push eax
    ;mov eax, [p]
    ;push eax
    ;mov eax, resultado
    ;push eax
    ;mov eax, img2
    ;push eax
    ;mov eax, img1
    ;push eax
    ;call _interpolar
    ;add esp, 20

    ;que hay en resultado
    ;mov eax, resultado
    ;movups xmm0, [eax]
    ;movq mm0, [eax]
    ;testing 6
    ;add eax, 16
    ;movups xmm1, [eax]
    ;mov eax, [cantidad]
    ;mov ebx, [p]

    ;xor eax, eax
    ;ret
    
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
    MOV         EAX,    [EBP+8]    ;Desde C siempre tiene que venir múltiplo de 4
    MOV         EBX,    [EBP+12]
    MOV         EDX,    [EBP+16]
    ;MOV         ECX,    [EBP+20]
    ;Hacer un vector con la constante y alojar en XMM3
    FLD         dword   [EBP+20]
    MOV         ECX,    multvuno
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    MOV         ECX,    multvuno
    MOVUPS      XMM2,   [ECX]
    ;En XMM4 guardar 1,1,1,1 y restarle XMM3
    FLD         dword   [constanteuno]
    FSUB        ST0,    ST1
    ;TODO: Falta restarlos y alojarlo en XMM4
    MOV         ECX,    multvdos
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    ADD         ECX,    4
    FST         dword   [ECX]
    MOV         ECX,    multvdos
    MOVUPS      XMM3,   [ECX]
    
    XOR         ECX,    ECX
    MOV         ECX,     [EBP+24]
CICLOINTERPOLAR:
    CMP         ECX,     0
    JE          FINALIZARCICLO
    ;interpolar de a uno no hace falta, no pincha
    CMP         ECX,     3
    JBE         ACOMODAR
    ;r = v1 x p + (1 - p) × v2
    ;r = xmm0 x xmm2 + xmm3 x xmm1
    MOVUPS      XMM0,   [EAX]
    MOVUPS      XMM1,   [EBX]
    MULPS       XMM0,   XMM2
    MULPS       XMM1,   XMM3
    ADDPS       XMM0,   XMM1
    ;pasar los floats a enteros para guardar en [EDX]
    ;cvtps2dq    XMM0,   XMM0
    ;cvttps2dq   xmm0, xmm0
    cvtps2dq    XMM4,   XMM0
    cvttps2dq   xmm5, xmm0
    ;Puede tirar segmentation fail
    movups      [EDX],  XMM0
    SUB         ECX,    4
    ADD         EAX,    16
    ADD         EBX,    16
    ADD         EDX,    16
    JMP         CICLOINTERPOLAR

ACOMODAR:
    ;mejorar
    PUSH        EAX
    MOV         EAX,    4
    SUB         EAX,    ECX
    MOV         ECX,    EAX
    ADD         ECX,    EAX
    ADD         ECX,    EAX
    ADD         ECX,    EAX
    POP         EAX
    SUB         EAX,    ECX
    SUB         EBX,    ECX
    SUB         EDX,    ECX
    MOV         ECX,    4
    JMP         CICLOINTERPOLAR
    
;Fin de la función.
FINALIZARCICLO:
    POP         EBP
    RET