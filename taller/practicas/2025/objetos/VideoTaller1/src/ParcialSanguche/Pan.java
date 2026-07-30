/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialSanguche;

/**
 *
 * @author Sofia C
 */
public class Pan {

    private String nombre;
    private double costo;
    private String calidad;

    public Pan(String nombre, double costo, String calidad) {
        this.nombre = nombre;
        this.costo = costo;
        this.calidad = calidad;
    }

    public double getCosto() {
        return costo;
    }

    public String getCalidad() {
        return calidad;
    }

    public double Incremento() {
        double aux = costo+ (costo*0.2);
        return aux;
    }
   
    
    public double costoFinal(){
        double costoF=getCosto();
        if(getCalidad().equals("Premium")){
            costoF= Incremento();
        }
        return costoF;
    }

    
    public String toString() {
        return "Un Pan:" + " nombre " + nombre + "- costo " + costo + "- calidad " + calidad ;
    }
    
}
