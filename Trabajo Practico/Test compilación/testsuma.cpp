#include <stdio.h>
int sumar(int a, int b);

main(int argc, char *argv[]) {
	int a = 5;
	int b = 5;
	int resultado = sumar(a, b);
	printf("%d mas %d es igual a %d", a, b, resultado);
}
