extern void interpolar(unsigned char *img1, unsigned char *img2, unsigned char *resultado, float p, int cantidad);

int leer_rgb(char *archivo, unsigned char *buffer, int filas, int columnas);
int escribir_rgb(char *archivo, unsigned char *buffer, int filas, int columnas);

int main(int argc, char *argv[]) {
   if(argc != 6) {
      printf("Faltan par%cmetros.\n", 160);
	  return 1;
   }
   int i;
   for(i=0; i < argc; i=i+1) {
      printf("%s\n", argv[i]);
   }
	   
   return 0;
}
