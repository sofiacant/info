/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica5.E1;

import PaqueteLectura.GeneradorAleatorio;

/**
 *
 * @author valen
 */
public class Ejercicio1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        GeneradorAleatorio.iniciar();
        Proyecto p = new Proyecto("Proyectito tito", 777, "Valentin Fiaccola");
      
            Investigador inv1 = new Investigador("valen", 3, "nosee");
            Investigador inv2 = new Investigador("sofi",2,"ni idea");
            Investigador inv3 = new Investigador("orne",4,"qsy");
           
                Subsidio sinv1 = new Subsidio(543, GeneradorAleatorio.generarString(10));
                Subsidio sinv2 = new Subsidio(5563, GeneradorAleatorio.generarString(10));
                inv1.agregarSubsidio(sinv1);
                inv1.agregarSubsidio(sinv2);
                Subsidio s2 = new Subsidio(546, GeneradorAleatorio.generarString(10));
                inv2.agregarSubsidio(s2);
                Subsidio s3 = new Subsidio(435, GeneradorAleatorio.generarString(10));
                inv3.agregarSubsidio(s3);
                
            
           
            p.agregarInvestigador(inv1);
            p.agregarInvestigador(inv2);
            p.agregarInvestigador(inv3);
        
  inv1.otorgarTodos("valen"); 
  System.out.println(p.toString());
  
    }
}
