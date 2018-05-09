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
//á: 160 é: 130 í: 161 ó: 162 ú: 163 Á: 181 É: 144 Í: 214 Ó: 224 Ú: 23 ñ: 164 Ñ: 165
int main(int argc, char *argv[]) {
	int inicioArbol = 0;
	int valor;
	struct nodo_abb *inicial;

	printf("Bienvenido al ordenador de n%cmeros.\nIngrese a continuaci%cn los n%cmeros que desea ordenar uno por l%cnea y luego cualquier otro caracter para finalizar:\n\n",163,162,163,161);
	int esNumero = scanf("%d", &valor);
	while(getchar() != '\n');		//Consumir el buffer.
		
	while (esNumero == 1) {
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
		printf("No se han ingresado valores y por lo tanto no se ha harmado el %crbol.\n",160);
	} else {
		printf("\n\nN%cmeros ordenados:\n",163);
		enOrden(inicial);
	}
	printf("\nPresione enter para salir.\n");
	getchar();
	return 0;
}
