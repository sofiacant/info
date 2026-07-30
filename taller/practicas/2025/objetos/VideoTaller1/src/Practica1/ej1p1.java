package Practica1;


import PaqueteLectura.GeneradorAleatorio;

public class ej1p1 {

    public static void main(String[] args) {
        int DF = 11;
        int[] tabla2 = new int[DF]; // indices de 0 a 10
        int i;

        GeneradorAleatorio.iniciar();

        for (i = 0; i < DF; i++) {
            tabla2[i] = 2 * i;
            System.out.println("2x" + i + "=" + tabla2[i]);
        }
        //generar aleatorios hasta que salga el 11
        int numero = GeneradorAleatorio.generarInt(12); //valores de 0 a 11
        while (numero != 11) {
            System.out.println("El resultado de multiplicar " + numero + " por 2 es: " + tabla2[numero]);
            numero = GeneradorAleatorio.generarInt(12);
        }
        System.out.println("Salio el 11, fin del programa");

    }
}
