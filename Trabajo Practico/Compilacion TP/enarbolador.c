#include <stdio.h>
#include <stdlib.h>

struct nodo_abb {
	int valor;
	int cantidad;
	struct nodo_abb *izq;
	struct nodo_abb *der;
};

extern struct nodo_abb * agregar_abb(struct nodo_abb *, int);
extern void borrar_abb(struct nodo_abb *);
extern void mostrar_abb(struct nodo_abb *);

void enOrden(struct nodo_abb * a)
{
	if (a != NULL)
	{
		enOrden(a->izq);
		printf("%d\n", a->valor);
		enOrden(a->der);
	}
}


int main(int argc, char *argv[]) {
	struct nodo_abb *inicial;
	inicial = agregar_abb(NULL, 8);
	int valor;
	char Seguir = 'S';
	
	mostrar_abb(inicial);
	printf("\n");	
	
	while (Seguir == 'S' || Seguir == 'S')
	{
		printf("Introducir un numero entero");
		scanf("%d", &valor);
		agregar_abb(inicial, valor);
		printf("Si desea continuar ingresar S");
		Seguir = getchar();
	}
	mostrar_abb(inicial);
	printf("\n");
	enOrden(inicial);
	borrar_abb(inicial);
	mostrar_abb(inicial);
	printf("\n");	
	getchar();
	return 0;
}
