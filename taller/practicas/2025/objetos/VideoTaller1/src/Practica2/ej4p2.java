/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica2;

import PaqueteLectura.Lector;

/**
 *
 * @author Sofia C
 */
public class ej4p2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String fin = "zzz";
        int cupoMax = 40;
        int dias = 5;
        int diaSeleccionado;
        int turnos = 8;
        Persona p1;
        Persona[][] vector = new Persona[dias][turnos];

        int i = 0;
        int j;
        int dimL = 0;

        System.out.println("Ingrese un nombre");
        String nombre = Lector.leerString();

        boolean ocupado = false;

        while ((i < dias) && (!nombre.equals(fin)) && (dimL < cupoMax)) {
            j = 0;
            while ((j < turnos) && (!nombre.equals(fin)) && (dimL < cupoMax)) {

                System.out.println("Ingrese un dni");
                int DNI = Lector.leerInt();
                System.out.println("Ingrese una edad");
                int edad = Lector.leerInt();
                System.out.println("Ingrese un Dia");
                diaSeleccionado = (Lector.leerInt());
                p1 = new Persona(nombre, DNI, edad);
                if (vector[diaSeleccionado - 1][j] == null) {
                    vector[diaSeleccionado - 1][j] = p1;
                    ocupado = true;
                } else {
                    System.out.println("Esta ocupado");
                    
                }
                dimL++;
                p1 = new Persona();

                System.out.println("Ingrese un Dia");
                diaSeleccionado = (Lector.leerInt());
                System.out.println("cant personas:   " + dimL);
                i++;
            }
            j++;
        }

        for (i = 0; i < dias; i++) {
            for (j = 0; j < turnos; j++) {
                if (vector[i][j] != null) {
                    System.out.println("Dia " + j + "| persona " + vector[i][j].toString() + " | ");
                }
            }
        }

    }
}
