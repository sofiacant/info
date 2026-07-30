/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E4;

/**
 *
 * @author Sofia C
 */
public class Estacion {
    private String nombre;
    private double latitud;
    private double longitud;
    
    public Estacion(String nombre,double latitud, double longitud){
        this.nombre= nombre;
        this.latitud=latitud;
        this.longitud=longitud;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public String getNombre() {
        return nombre;
    }

    public double getLatitud() {
        return latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public String toString() {
        return  nombre +" ( "+this.latitud + " S - "+ this.longitud + " O ): "; 
    
    }
    
    
    
}
