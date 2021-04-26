# Resaltador de sintaxis

### Como ejecutar el programa

1. Descarga los archivos de este folder (Act3.4) en tu computador
2. Abre el archivo de Racket (Act3.4.rkt) en una aplicación que lo pueda compilar como DrRacket 
3. Ejecute el archivo

Al correr el archivo, el programa le pedirá que escriba el lenguaje en el que está escrito el programa en el que desea utilizar el resaltador de sintaxis. Solo funciona con programas en los lenguajes de C++ y Python.
De ser un archivo Python a correr deberá escribir `py`, de ser en C++ deberá escribir `cpp`

Posteriormente se le pregunta que escriba la dirección del archivo a leer, si el archivo del código que desea leer se encuentra en un directorio fuera del fólder donde se encuentra este programa (Act3.4.rkt) deberá escribir la dirección como `D:\\Descargas\\Codigos\\codigo.cpp`. En el caso en el que el archivo a leer sí se encuentre dentro de la misma carpeta que todo el programa, puede simplemente escribir el nombre del archivo completo como `codigo.cpp`.

Finalmente, y una vez que haya hecho todo esto correctamente, podrá ejecutar todo el programa con el siguiente comando:

`(run programa code headHTML)`


Una vez terminada la ejecución del programa podrá visualizar el resaltador de texto en el archivo HTML que se creó con el nombre "index.html".



**Nota:** Asegúrase de descargar todos los archivos dentro del folder de este repositorio, incluyendo el CSS, de esta manera podrá resaltar las categorías léxicas correctamente. Adicionalmente, en este folder se encuentran 2 archivos tanto en C++ como en Python en el caso de que quiera probar la ejecución del programa con estos archivos sin necesidad de poner la ruta o nombre de otro. 
