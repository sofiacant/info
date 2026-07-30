package Practica1;

import PaqueteLectura.Lector;

/*
 * @author Sofia C
 */
public class ej5p1 {

    public static void main(String[] args) {
        int clientes = 5;
        int aspectos = 4;
        int[][] matriz = new int[clientes][aspectos];
        int i;
        int j;
        String[] nombresAspectos = {"Atención al cliente", "Calidad de la comida", "Precio", "Ambiente"};
        int puntaje;

        for (i = 0; i < 5; i++) {
            for (j = 0; j < 4; j++) {
                System.out.println("Ingrese una calificacion del 1 al 10 para " + nombresAspectos[j] + ":");
                puntaje = Lector.leerInt();
                matriz[i][j] = puntaje;
            }
        }
        for (i = 0; i < 5; i++) {
            for (j = 0; j < 4; j++) {
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }

        double promedio = 0;

        for (j = 0; j < aspectos; j++) {
            double sumat = 0;
            for (i = 0; i < clientes; i++) {
                sumat = sumat + matriz[i][j];
            }
            promedio = sumat / clientes;
            System.out.println("El promedio del aspecto " + nombresAspectos[j] + " es  " + promedio);
        }

    }

}
