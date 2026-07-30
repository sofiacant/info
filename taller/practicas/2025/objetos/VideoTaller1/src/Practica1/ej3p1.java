package Practica1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class ej3p1 {

    public static void main(String[] args) {  //Paso 2. iniciar el generador aleatorio     
        GeneradorAleatorio.iniciar();
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int filas = 5;
        int columnas = 5;
        int[][] matriz = new int[filas][columnas];
        int suma = 0;
        int fila = 0;
        int sumaj = 0;
        int valor;
        boolean encontre = false;

        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                matriz[i][j] = GeneradorAleatorio.generarInt(30);
            }
        }
        //Paso 4. mostrar el contenido de la matriz en consola
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }

        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        for (int j = 0; j < 5; j++) {
            suma = suma + matriz[fila][j];
        }
        System.out.println("La suma de los elementos de la fila  " + fila + " es:  " + suma);

        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int[] vector = new int[5];
        for (int j = 0; j < 5; j++) {
            sumaj = 0;

            for (int i = 0; i < 5; i++) {
                sumaj = sumaj + matriz[i][j];
            }
            vector[j] = sumaj;
        }
        System.out.println("vector:");
        for (int j = 0; j < 5; j++) {
            System.out.println(vector[j]);
        }
        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento".

        System.out.println("Ingrese un valor a buscar en la matriz");
        valor = Lector.leerInt();
        int j;
        int i = 0;
        while ((i < 5) && (!encontre)) {
            j = 0;
            while ((j < 5) && (!encontre)) {
                if (valor == matriz[i][j]) {
                    System.out.println("Esta ubicada en la fila " + i + " y columna  " + j);
                    encontre = true;
                }
                j++;
            }

            i++;
        }
        if (!encontre) {
            System.out.println("No se encontro el elemento");
        }

    }
}
