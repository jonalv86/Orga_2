#include <stdio.h>
extern int sumar(int, int);

int main(int argc, char *argv[]) {
	int a = 5;
	int b = 5;
	int resultado = sumar(a, b);
	printf("%d mas %d es igual a %d\n", a, b, resultado);
	printf("Presione cualquier tecla para continuar.\n");  
	getchar(); 
	return 0;
}
