/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica2;

import PaqueteLectura.Lector;

public class ej1p2 {

    public static void main(String[] args) {
        Persona p1;
        p1= new Persona();
        System.out.println("Ingrese un nombre");
        p1.setNombre(Lector.leerString());
        System.out.println("Ingrese un dni");
        p1.setDNI(Lector.leerInt());
        System.out.println("Ingrese una edad");
        p1.setEdad(Lector.leerInt());

        System.out.println(p1.toString());
        
        
    }
}
