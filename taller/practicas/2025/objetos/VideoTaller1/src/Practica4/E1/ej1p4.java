/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E1;

/**
 *
 * @author Sofia C
 */
public class ej1p4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        
        
        Triangulo t= new Triangulo(5,5,5,"azul","negro");
        System.out.println(t.toString());
        t.despintar();
        System.out.println(t.toString());

        Circulo c= new Circulo(2,"Azul","Violeta");
        System.out.println(c.toString());
        c.despintar();
        System.out.println(c.toString());
    }
    
}
