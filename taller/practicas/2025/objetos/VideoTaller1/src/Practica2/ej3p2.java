package Practica2;

import PaqueteLectura.Lector;

public class ej3p2 {

    public static void main(String[] args) {
        String fin = "ZZZ";
        int cupoMax = 40;
        int dias = 5;
        int turnos = 4;
        int dimL = 0;
        Persona p1;
        Persona[][] vector = new Persona[dias][turnos];

        int i = 0;
        int j;

        System.out.println("Ingrese un nombre");
        String nombre = Lector.leerString();
        int cant = 0;

        while ((i < dias) && (!nombre.equals(fin)) && (dimL < cupoMax)) {
            j = 0;
            while ((j < turnos) && (!nombre.equals(fin))) {

                System.out.println("Ingrese un dni");
                int DNI = Lector.leerInt();
                System.out.println("Ingrese una edad");
                int edad = Lector.leerInt();
                p1 = new Persona(nombre, DNI, edad);
                vector[i][j] = p1;
                System.out.println("Ingrese un nombre");
                nombre = Lector.leerString();
                j++;
                dimL++;
            }
            if (j == 4) {
                i++;
            } else {
                cant = j;
            }
        }
        //b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
        // int division = (dimL / turnos);
        // System.out.println(division);
        // int modul = (dimL % turnos);
        //System.out.println(modul);
        
        
        int cantC = 0;
        for (i = 0; i < dimL; i++) {

            System.out.println("Dia " + i + "| persona " + vector[i / turnos][i % turnos].toString() + " | ");
            cantC++;
            if (i == turnos) {
                   System.out.println(" ");
                   cantC=0;   
            }

        }
       
    }

}
