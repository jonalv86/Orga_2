global _sumar

section .text
_sumar:
    PUSH    EBP
    MOV     EBP, ESP
    MOV     EAX, [EBP+8]
    MOV     EBX, [EBP+12]
    ADD     EAX, EBX
    POP     EBP
    RET
