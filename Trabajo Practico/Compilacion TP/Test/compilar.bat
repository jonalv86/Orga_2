del arbolbinario.obj
del test.exe
nasm -f win32 arbolbinario.asm
C:\MinGW\bin\gcc enarbolador.c arbolbinario.obj -o test.exe
pause