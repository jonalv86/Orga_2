#include <stdio.h>
 
/* prototype for asm function */
int funcion_test(int a, int b);
 
int
main() {
 
/* call the asm function */
int a = 5;
int b = 5;
int resultado = funcion_test(a, b);
printf("El resultado es %d \n ", resultado); 
return 0;
}
