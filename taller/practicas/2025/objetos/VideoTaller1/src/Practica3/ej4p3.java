/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica3;

/**
 *
 * @author Sofia C
 */
public class ej4p3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       Hotel h =new Hotel(10);
       int dimL=0;
      
       Persona c= new Persona("Sofi", 12312,26);
       h.guardarClientes(c,4);
        
       h.toString();
       
       h.aumentarPrecios(150);
       
       System.out.println(h.toString());
    }
    
}
