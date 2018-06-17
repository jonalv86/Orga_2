#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern void interpolar(unsigned char *img1, unsigned char *img2, unsigned char *resultado, float p, int cantidad);

int leer_rgb(char *archivo, unsigned char *buffer, int filas, int columnas);
int escribir_rgb(char *archivo, unsigned char *buffer, int filas, int columnas);

char *crearNombre(char *nombre, int orden) {
	int digitos = snprintf( NULL, 0, "%d", orden );
	char* ordenEnLetras = malloc( digitos + 1 );
	snprintf( ordenEnLetras, digitos + 1, "%d", orden );
	char* nombreArchivo;
	nombreArchivo = malloc(strlen(nombre)+1+digitos+4);
	strcpy(nombreArchivo, nombre);
	strcat(nombreArchivo, "_");
	strcat(nombreArchivo, ordenEnLetras);
	strcat(nombreArchivo, ".rgb");
	return nombreArchivo;
}

int main(int argc, char *argv[]) {
	//Testing
	//printf("Hay %d par%cmetros.\n", argc, 160);
	if(argc != 7) {
		printf("Faltan par%cmetros.\n", 160);
		return 1;
	}
	//Testing
    //int i;
    //for(i=0; i < argc; i=i+1) {
    //   printf("%s\n", argv[i]);
    //}
	unsigned char *img1;
	unsigned char *img2;
	unsigned char *resultado;
	float p;
	//argv[1]	img1.rgb
	//argv[2]	img2.rgb
	//argv[3]	filas
	//argv[4]	columnas
	//argv[5]	n
	//argv[6]	resultado
	int filas;
	sscanf(argv[3], "%d", &filas);
	int columnas;
	sscanf(argv[4], "%d", &columnas);
	int tamanio = filas * columnas;
	int cantidad;
	sscanf(argv[5], "%d", &cantidad);
	//leer_rgb(argv[1], img1, filas, columnas);
	//leer_rgb(argv[2], img2, filas, columnas);
	for (int i=0; i<cantidad; i++) {
		p = 1.0f / (cantidad+1) * (i+1);
		char *nombreArchivo = crearNombre(argv[6], (i+1));
		interpolar(img1, img2, resultado, p, tamanio);
		escribir_rgb(nombreArchivo, resultado, filas, columnas);
		//Testing
		//printf("%d\n", cantidad+1);
		//printf("%d\n", i+1);
		//printf("%f\n", p);
		//printf("%s\n", nombreArchivo);
	}
	return 0;
}
