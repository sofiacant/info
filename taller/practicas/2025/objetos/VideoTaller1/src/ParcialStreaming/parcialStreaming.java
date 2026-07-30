/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialStreaming;

/**
 *
 * @author Sofia C
 */
public class parcialStreaming {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Plataforma p = new Plataforma("Twitch",15,3);
        
        
        Estreno e1= new Estreno("AAA","Serie",5434,120);
        Estreno e2= new Estreno("BBB","Serie",5132,18);
        Estreno e3= new Estreno("CCC","Pelicula",12312,128);
        Estreno e4= new Estreno("DDD","Serie",7564,143);
        Estreno e5= new Estreno("EEE","Pelicula",5123,745);
        Estreno e6= new Estreno("FFF","Serie",6764,112);
        Estreno e7= new Estreno("GGG","Pelicula",9865,123);
        
        
       p.registrarEstreno(e1,2);
       p.registrarEstreno(e2,1);
       p.registrarEstreno(e3,3);
       p.registrarEstreno(e4,1);
       p.registrarEstreno(e5,2);
       p.registrarEstreno(e6,3);
       p.registrarEstreno(e7,3);
       
       
       
        System.out.println(p.listarEstrenos(1));
       
        System.out.println(p.gananciaTotal());
        
        p.toString();
        
        System.out.println(p);
    }
    
}
