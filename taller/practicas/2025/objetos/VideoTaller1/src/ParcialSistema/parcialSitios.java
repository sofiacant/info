/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialSistema;


public class parcialSitios {

    public static void main(String[] args) {
        SitioTProfesional sp= new SitioTProfesional(3,"Alfil","sofia@sofia");
        SitioTAmateur sa= new SitioTAmateur("Rey","Juan@juan");
       
        Torneo t= new Torneo("SAA",23,456,77);
        Torneo t2= new Torneo("SAA",23,457,75);
        Torneo t3= new Torneo("SAA",23,477,77);
        Torneo t4= new Torneo("SAA",23,423,7);
        Torneo t5= new Torneo("SAA",23,126,1);
        
        System.out.println(sp.registrarTorneoProfesional(t));
        sp.registrarTorneoProfesional(t2);
        sp.registrarTorneoProfesional(t3);
        sp.registrarTorneoProfesional(t4);
        System.out.println(sp.registrarTorneoProfesional(t5));
    
    
        sa.registrarTorneoAmateur(11);
   
        
        
        
        System.out.println("La cotizacion de sp: "+ sp.cotizarSitio());
        System.out.println("La cotizacion de sa: "+ sa.cotizarSitio());
        
        System.out.println(sp.toString());
        System.out.println(sa.toString());
    }
    
}
