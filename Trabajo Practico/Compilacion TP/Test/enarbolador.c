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
extern void borrar_abb(struct nodo_abb *);

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
	agregar_abb(inicial, 9);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 5);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 3);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 82);
	mostrar_abb(inicial);
	getchar();
	borrar_abb(inicial);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 94);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 65);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 53);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 32);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 21);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 72);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 81);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 99);
	mostrar_abb(inicial);
	getchar();
	agregar_abb(inicial, 100);
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
