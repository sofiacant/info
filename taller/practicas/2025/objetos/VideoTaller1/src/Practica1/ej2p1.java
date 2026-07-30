package Practica1;

import PaqueteLectura.Lector;

public class ej2p1 {

    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        int df = 15;
        double[] vectorj = new double[df];
        //Paso 3: Crear el vector para 15 double 

        //Paso 4: Declarar indice y variables auxiliares a usar
        double altura;
        double promedio;
        double atotal = 0;
        int cant = 0;

        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        for (int i = 0; i < 15; i++) {
            System.out.println("Ingrese una altura: ");
            altura = Lector.leerDouble();
            vectorj[i] = altura;
            atotal = atotal + altura;
        }//Paso 7: Calcular el promedio de alturas, informarlo
        promedio = atotal / df;
        System.out.println("El promedio de alturas es: " + promedio);
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        for (int i = 0; i < 15; i++) {
            if (vectorj[i] > promedio) {
                cant = cant + 1;
            }
        }//Paso 9: Informar la cantidad.
        System.out.println("La cantidad de jugadores con altura superior es " + cant);
    }
}
