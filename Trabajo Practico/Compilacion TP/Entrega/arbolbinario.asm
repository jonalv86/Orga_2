section .data
debug: db "Llega aca",0
debug_mayor: db "Rama Mayor",0
debug_menor: db "Rama Menor",0
debug_igual: db "Rama Iual",0
debug_valor: db "El valor almacenado es en ebx es: %d",0
fallo_malloc: db "Fallo malloc!!!",0
p_abrir: db "{",0
p_cerrar: db "}",0
p_valor: db "%d:%d ",0
p_espacio: db " ",0

extern _malloc
extern _printf
extern _free

global _agregar_abb
global _mostrar_abb
global _borrar_abb

section .text
_agregar_abb:
    ;Un puntero al arbol    [EBP+8]
    ;Un valor               [EBP+12]
    PUSH    EBP
    MOV	    EBP, ESP
    MOV     EAX, [EBP+8]    ;puntero
    CMP     EAX, 0          ;el puntero es nulo?
    JE 		iniciar_arbol
    ;MOV 	EBX, [EAX]
    ;CMP 	EBX, 0
    ;JNE     existe_arbol
	jmp existe_arbol

iniciar_arbol:   			;creo el arbol
    ;malloc 32 bytes
    PUSH	dword 32
    CALL	_malloc
    ADD	  	ESP, 4

    ;check if the malloc failed
    TEST	EAX, EAX
    JZ    	fail_exit
    
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
	
existe_arbol:
	MOV     EAX, [EBP+8]    ;puntero
    MOV     ECX, [EBP+12]   ;valor
    MOV     EBX, [EAX]      ;me paro a donde apunta el puntero del arbol
	CMP     ECX, EBX        ;lo comparo
    JE      incrementar_nodo
    JL      nodo_menor		;Menor valor
    JG      nodo_mayor		;Mayor valor
    
incrementar_nodo:
	MOV     EAX, [EBP+8]
    ADD     EAX, 4
    ADD     [EAX], dword 1
    JMP     SALIR
    
nodo_menor:
    MOV     EAX, [EBP+8]
    ADD     EAX, 8
    JMP     nuevo_nodo

nodo_mayor:
	MOV     EAX, [EBP+8]
    ADD     EAX, 12
    
nuevo_nodo:    				;Inicio add
    PUSH 	EAX
	MOV     ECX, [EBP+12]	;valor
    MOV		EBX, [EAX]
	PUSH    ECX
		;recursion
		PUSH    EBX
		CALL    _agregar_abb
		ADD     ESP, 8
    POP		EDX
    MOV 	ECX, [EDX]
	CMP		ECX, 0
    JNE 	SALIR
    MOV 	[EDX], EAX		;EAX apunta el nuevo nodo
    JMP     SALIR			;Fin add
        
SALIR:
    POP     EBP
    RET
	
_mostrar_abb:    			;implentado recursivo
    PUSH    EBP
    MOV	    EBP, ESP
	
		PUSH	p_abrir
		CALL	_printf
		ADD		ESP, 4
	
    MOV     EBX, [EBP+8]
    CMP     EBX, 0
    JE      TERMINARMOSTRAR
    MOV     ECX, [EBX]      ;valor
    ADD     EBX, 4
    MOV     EDX, [EBX]      ;cantidad
	
		PUSH 	EDX
		PUSH	ECX
		PUSH 	p_valor
		CALL 	_printf
		ADD 	ESP, 12
	
	MOV 	EAX, [EBP+8]	;mostrar nodo izquierdo
	ADD 	EAX, 8
	MOV 	EBX, [EAX]
    PUSH 	EAX
		;recursion
		PUSH    EBX
		CALL    _mostrar_abb
		ADD     ESP, 4
	
		PUSH 	p_espacio
		CALL 	_printf
		ADD 	ESP, 4
	
    POP 	EAX				;mostrar nodo derecho
    ADD     EAX, 4
	MOV 	EBX, [EAX]
		;recursion
		PUSH    EBX
		CALL    _mostrar_abb
		ADD     ESP, 4    
    JMP     TERMINARMOSTRAR

TERMINARMOSTRAR:
		PUSH 	p_cerrar
		CALL 	_printf
		ADD		ESP,4
    JMP     SALIR
	
_borrar_abb:
    PUSH    EBP
    MOV	    EBP, ESP
	MOV     EBX, [EBP+8]
    CMP     EBX, 0
    JE      SALIR
    ADD     EbX, 8
    PUSH 	EBX
	MOV 	EAX, [EBX]
		;recursion
		PUSH 	EAX
		CALL	_borrar_abb
		ADD 	ESP, 4
	POP		EBX
		PUSH 	EBX
		PUSH 	EBX
		CALL 	_free
		ADD 	ESP, 4
		POP 	EBX
    MOV     [EBX], dword 0
    ADD     EBX, 4
	PUSH	EBX
	MOV 	EAX, [EBX]
		;recursion
		PUSH 	EAX
		CALL 	_borrar_abb
		ADD 	ESP, 4
    POP		EBX
		PUSH 	EBX
		PUSH 	EBX
		CALL 	_free
		ADD 	ESP, 4
		POP 	EBX
    MOV     [EBX], dword 0
    JMP     SALIR
    
fail_exit:
	PUSH 	fallo_malloc
	CALL 	_printf
	ADD 	ESP, 4
    MOV  	EAX, 1
    POP  	EBP
    RET
