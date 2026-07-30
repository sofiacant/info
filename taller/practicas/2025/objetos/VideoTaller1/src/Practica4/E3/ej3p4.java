/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E3;

public class ej3p4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       Persona p= new Persona("Sofia",1243,26);
       Trabajador t= new Trabajador("Jardinero","Juan",4234,39);
       
       
        System.out.println(p.toString());
        System.out.println(t.toString());
    }
    
}
