package Practica1;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

/*
 @author Sofia C
 */
public class ej4p1 {

    public static void main(String[] args) {
        int filas = 8; //pisos
        int columnas = 4;  //oficinas
        int[][] matriz = new int[filas][columnas];

        int piso;
        int oficina;

        System.out.println("Ingrese un piso:  ");
        piso = Lector.leerInt();
        while (piso != 9) {
            System.out.println("Ingrese una oficina:  ");
            oficina = Lector.leerInt();
            matriz[piso - 1][oficina - 1]++;

            System.out.println("Ingrese un piso:  ");
            piso = Lector.leerInt();
        }

        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 4; j++) {
                System.out.println("La cantidad de personas que concurrieron a cada oficina " + (j + 1) + " del  piso  " + (i + 1) + " es: " + matriz[i][j]);
            }
        }

    }
}
