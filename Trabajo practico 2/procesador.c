#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void interpolar(unsigned char *img1, unsigned char *img2, unsigned char *resultado, float p, int cantidad);

char *crearNombre(char *nombre, int orden) {
	int digitos = snprintf( NULL, 0, "%d", orden );
	char* ordenEnLetras = malloc( digitos + 1 );
	snprintf(ordenEnLetras, digitos+1, "%d", orden);
	char* nombreArchivo;
	nombreArchivo = malloc(strlen(nombre)+1+digitos+4);
	strcpy(nombreArchivo, nombre);
	strcat(nombreArchivo, "_");
	strcat(nombreArchivo, ordenEnLetras);
	strcat(nombreArchivo, ".rgb");
	return nombreArchivo;
}

int leer_rgb(char *archivo, unsigned char *buffer, int filas, int columnas) {
	FILE *archivoRead;
	long tamanio = filas*columnas*3;
	archivoRead = fopen(archivo, "r+");
	buffer = (unsigned char *)malloc(tamanio);
	fread(buffer, sizeof(unsigned char), tamanio, archivoRead);
	fclose(archivoRead);
	printf("%s\n", buffer);
	return 0;
}

int escribir_rgb(char *archivo, unsigned char *buffer, int filas, int columnas) {
	FILE *archivoWrite;
	archivoWrite = fopen(archivo, "w+");
	fwrite(buffer, filas*columnas*3, 1, archivoWrite);
	fclose(archivoWrite);
	return(0);
}

int main(int argc, char *argv[]) {
	if(argc != 7) {
		printf("Faltan par%cmetros.\n", 160);
		return 1;
	}
	unsigned char *img1;
	unsigned char *img2;
	unsigned char *resultado;
	float p;
	int filas;
	sscanf(argv[3], "%d", &filas);
	int columnas;
	sscanf(argv[4], "%d", &columnas);
	long tamanio = filas * columnas * 3;
	int cantidad;
	sscanf(argv[5], "%d", &cantidad);
	leer_rgb(argv[1], img1, filas, columnas);
	leer_rgb(argv[2], img2, filas, columnas);
	resultado = (unsigned char *)malloc(tamanio);
	for (int i=0; i<cantidad; i++) {
		p = 1.0f / (cantidad+1) * (i+1);
		char *nombreArchivo = crearNombre(argv[6], (i+1));
		interpolar(img1, img2, resultado, p, tamanio);
		escribir_rgb(nombreArchivo, resultado, filas, columnas);
	}
	return 0;
}
