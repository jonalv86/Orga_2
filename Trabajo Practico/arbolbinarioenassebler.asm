;http://caswenson.com/2009_09_26_assembly_language_programming_under_os_x_with_nasm
%include "io.inc"
extern _malloc

section .text
global CMAIN
CMAIN:
    ;write your code here
    push 12                ; push amount of bytes malloc should allocate, en nuestro caso int+int+posicionNodoIzquierdo+posicionNodoDerecho
    call _malloc           ; call malloc
    test eax, eax          ; check if the malloc failed
    jz   fail_exit         ; 
    add esp,4              ; undo push
    mov [eax], dword 0xD41 ; 'A\n'
    xor eax, eax
    ret
    
fail_exit:
    mov  eax, 1
    pop  ebp
    ret