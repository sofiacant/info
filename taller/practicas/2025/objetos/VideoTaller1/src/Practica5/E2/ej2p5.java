
package Practica5.E2;

import Practica5.E2.Estacionamiento;
import Practica5.E2.Auto;

public class ej2p5 {

  
    public static void main(String[] args) {
        
        Estacionamiento e= new Estacionamiento("La plata","Alzaga 1100",7,22,3,3);
        
        Auto a1= new Auto("Juan","asd456sa");   
        Auto a2= new Auto("Sofia","gsd7gds8");   
        Auto a3= new Auto("Orne","6fds67fds");   
        Auto a4= new Auto("Valen","7fgsd7d");   
        Auto a5= new Auto("Maria","2d3as24");   
        Auto a6= new Auto("Lorena","231sa23");  
        
        e.estacionarAuto(a1,1,2);
        e.estacionarAuto(a2,1,1);
        e.estacionarAuto(a3,2,1);
        e.estacionarAuto(a4,3,2);
        e.estacionarAuto(a5,3,1);
        e.estacionarAuto(a6,2,3);
        
        System.out.println(e.toString());
        
        System.out.println("La cantidad de autos en la plaza 1: "+ e.cantAutosPlaza(1));
        
         System.out.println (e.buscarAuto("6fds67fds"));
        
        }
    }
    

