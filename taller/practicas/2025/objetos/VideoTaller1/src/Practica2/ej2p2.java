package Practica2;

import PaqueteLectura.GeneradorAleatorio;

public class ej2p2 {

    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        Persona per;
        int cant = 0;
        int personas = 15;
        int dniMin = 9999 ;
        Persona perMin;
        int dimL=0;

        Persona[] vector = new Persona[personas];
        //per = new Persona();
        perMin=new Persona();
        
        //per.setEdad(GeneradorAleatorio.generarInt(99));
        int edad = GeneradorAleatorio.generarInt(99);
        while((dimL<personas)&&(edad>0)){
          
            //per.setNombre();
            //per.setDNI();
            String nombre = GeneradorAleatorio.generarString(20);
            int DNI = GeneradorAleatorio.generarInt(9999);
            
            per = new Persona(nombre, DNI, edad);
            vector[dimL] = per;
            // vector[i] = new Persona (nombre, DNI, edad);
            edad = GeneradorAleatorio.generarInt(99);
            dimL++;

        }
        
        for (int i = 0; i < dimL; i++) {
            System.out.println(vector[i].toString());
        }

        for (int i = 0; i < dimL; i++) {
            if (vector[i].getEdad() > 65) {
                cant += 1;
            }
        }

        for (int i = 0; i < dimL; i++) {
            if (vector[i].getDNI() < dniMin) {
                dniMin = vector[i].getDNI();
                perMin = vector[i];
            }
        }
         System.out.println("--------------");
         System.out.println("Cantidad de personas mayores de 65 años "+cant);
         System.out.println("---- Persona con menor DNI ----");
         System.out.println(perMin.toString());
    }

}
