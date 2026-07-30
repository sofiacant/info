/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E2;

/**
 *
 * @author Sofia C
 */
public class ej2p4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Entrenador e= new Entrenador(5,"Pablo",5000,25);
        Jugador j= new Jugador(115,81,"Juan",12000,13);
        
        System.out.println(e.toString());
        System.out.println(j.toString());
    }
    
}
