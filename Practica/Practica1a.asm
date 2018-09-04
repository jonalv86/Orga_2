%include "io.inc"

section .data
N1: db 7
N2: db 8

N3: dw 500
N4: dw 200

N5: dd 5000000
N6: dd 2000000

N7: dq 0xeffffffffffffffe
N8: dq 0x1000000000000001

F1: dw 2.5
F2: dd 2.5
T: db "Hola mundo",0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;write your code here
    
    ;a)
    mov eax, [N1]
    mov ebx, [N2]
    add al, bl
    PRINT_UDEC 1, al
    NEWLINE
    
    ;b)
    mov eax, [N3]
    mov ebx, [N4]
    sub ax, bx
    PRINT_DEC 2, ax
    NEWLINE
    
    ;c)
    mov eax, [N1]
    mov ebx, [N2]
    mul bl
    PRINT_UDEC 2, ax
    NEWLINE
    
    ;d) Cociente y resto de la división entera N3/N4
    mov edx, 0
    mov eax, [N3]
    mov ebx, [N4]
    div bx
    PRINT_STRING "El resultado es : "
    PRINT_DEC 2, ax
    PRINT_STRING " y el resto es:  "
    PRINT_DEC 2, dx
    NEWLINE
    
    ;e) N5 + N6
    mov eax, [N5]
    mov ebx, [N6]
    add eax, ebx
    PRINT_UDEC 4, eax
    NEWLINE
    
    ;f) N7 + N8 usando registros de 32 bits
    mov eax, [N7]
    mov ebx, [N8]    
    add eax, ebx
    mov ecx, [N7+4]
    mov edx, [N8+4]
    adc ecx, edx
    PRINT_UDEC 4, ecx
    PRINT_UDEC 4, eax
    NEWLINE
    
    ;g) Cociente y resto de la división N5/N6 usando registros de 32 bits
    mov edx, 0
    mov eax, [N5]
    mov ebx, [N6]
    div ebx
    PRINT_STRING "El resultado es : "
    PRINT_UDEC 4, eax
    PRINT_STRING " y el resto es:  "
    PRINT_UDEC 4, edx
    NEWLINE
    
    xor eax, eax
    ret
