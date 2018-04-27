#include <stdio.h>
#include <stdlib.h>

struct nodo_abb {
	int valor;
	int cantidad;
	struct nodo_abb *izq;
	struct nodo_abb *der;
};

struct nodo_abb * agregar_abb(struct nodo_abb * arbol, int val) {
	if (arbol == NULL) {
		struct nodo_abb *nuevo = (struct nodo_abb *) malloc(sizeof(struct nodo_abb));
		nuevo -> valor = val;
		nuevo -> cantidad = 1;
		nuevo -> izq = NULL;
		nuevo->der = NULL;
		return nuevo;
	}
	int valorActual = arbol -> valor;
	if (valorActual == val) {
		arbol -> cantidad++;
	} else if (val < valorActual) {
		arbol->izq = agregar_abb(arbol->izq, val);
	} else {
		arbol->der = agregar_abb(arbol->der, val);
	}
	return arbol;
}

void borrar_abb(struct nodo_abb * a) {
	if (a == NULL) {
		return;
	}
	if (a->izq != NULL) {
		borrar_abb (a->izq);
		//free(a->izq);
		a->izq = NULL;
	}
	if (a->der != NULL) {
		borrar_abb (a->der);
		//free(a->der);
		a->der = NULL;
	}
	return;
}

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

main(int argc, char *argv[]) {
	struct nodo_abb *inicial;
	inicial = agregar_abb(NULL, 8);
	mostrar_abb(inicial);
	printf("\n");	
	agregar_abb(inicial, 54);
	agregar_abb(inicial, 17);
	agregar_abb(inicial, 5);
	agregar_abb(inicial, 8);
	agregar_abb(inicial, 5);
	agregar_abb(inicial, 70);
	agregar_abb(inicial, 75);
	agregar_abb(inicial, 2);
	mostrar_abb(inicial);
	printf("\n");
	borrar_abb(inicial);
	mostrar_abb(inicial);
	printf("\n");	
}
