/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica3;
import PaqueteLectura.GeneradorAleatorio;
/**
 *
 * @author Sofia C
 */
public class Habitacion {
     
    private double costo;
    private boolean ocupada;
    private Persona c;
   
    
    public Habitacion() {
       costo=2000+ GeneradorAleatorio.generarDouble(6000);
       ocupada=false;
    }
    
    public void setCliente(Persona c){
      this.c=c;
    }
    public void setOcupada(boolean ocupada){
        this.ocupada=ocupada;
    }
    
    public void aumentarPrecio(double precio){
        costo+=precio;
    }

    @Override
    public String toString() {
        return "Habitacion{" + "costo=" + costo + ", ocupada=" + ocupada + ", c=" + c + '}';
    }
    
}
