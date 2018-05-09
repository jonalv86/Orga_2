#include <stdio.h>
#include <stdlib.h>

struct nodo_abb {
	int valor;
	int cantidad;
	struct nodo_abb *izq;
	struct nodo_abb *der;
};

extern struct nodo_abb * agregar_abb(struct nodo_abb *, int);
extern void mostrar_abb(struct nodo_abb *);
/*
void mostrar_abb(struct nodo_abb * a) {
	printf("{");
	if (a != NULL) {
		printf("%d:%d ", a -> valor, a -> cantidad);
		mostrar_abb(a -> izq);
		printf(" ");
		mostrar_abb(a -> der);
	}
	printf("}");
}
*/
void enOrden(struct nodo_abb * a)
{
	if (a != NULL)
	{
		enOrden(a->izq);
		printf("\n%d\n", a->valor);
		enOrden(a->der);
	}
}


int main(int argc, char *argv[]) {
	struct nodo_abb *inicial;
	inicial = agregar_abb(NULL, 8);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 7);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 9);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 8);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 8);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 8);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 9);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 9);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 9);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 6);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 5);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 4);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 3);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 2);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 1);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 11);
	mostrar_abb(inicial);
	getchar();
	return 0;
}
