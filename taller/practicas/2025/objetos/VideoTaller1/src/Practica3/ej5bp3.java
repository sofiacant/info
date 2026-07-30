/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica3;

import PaqueteLectura.Lector;

public class ej5bp3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Circulo circulo;

        System.out.println("Ingrese un radio");
        double radio = (Lector.leerDouble());
        System.out.println("Ingrese un color de relleno");
        String colorRelleno = (Lector.leerString());
        System.out.println("Ingrese un color de linea");
        String colorLinea = (Lector.leerString());
        circulo= new Circulo(radio,colorRelleno,colorLinea);
       

        System.out.println("El perimetro es:  " + circulo.calcularPerimetro());
        System.out.println("El area es:  " + circulo.calcularArea());
    }

}
