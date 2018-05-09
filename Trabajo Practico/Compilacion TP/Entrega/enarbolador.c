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
		printf("%d\n", a->valor);
		enOrden(a->der);
	}
}

int main(int argc, char *argv[]) {
	int inicioArbol = 0;
	int valor;
	struct nodo_abb *inicial;

	int esNumero = scanf("%d", &valor);
	while(getchar() != '\n');		//Consumir el buffer.
		
	while (esNumero == 1)
	{
		if (inicioArbol == 0) {
			inicial = agregar_abb(NULL, valor);
			inicioArbol = 1;
		} else {
			agregar_abb(inicial, valor);
		}
		esNumero = scanf("%d", &valor);
		while(getchar() != '\n'); 
	}
	if (inicioArbol == 0) {
		printf("No se han ingresado valores y por lo tanto no se ha harmado el arbol.\n");
	} else {
		enOrden(inicial);
	}
	printf("\nPresione enter para salir.\n");
	getchar();
	return 0;
}
