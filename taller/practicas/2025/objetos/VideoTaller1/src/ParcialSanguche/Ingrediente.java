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
public class Ingrediente {
    private String nombre;
    private double costo;
    private String grupo;

    public Ingrediente(String nombre, double costo, String grupo) {
        this.nombre = nombre;
        this.costo = costo;
        this.grupo = grupo;
    }

    public double getCosto() {
        return costo;
    }

    public String getGrupo() {
        return grupo;
    }
    
    public double incremento() {
        return  (costo+ (costo*0.1));
    }
    
    
    
    
    public double costoFinal(){
        double costoF= getCosto();
        if(getGrupo().equals("B")){
            costoF= incremento();
        }
        return costoF;
    }

  
    public String toString() {
        return " -Un ingrediente  " + nombre + "- costo  " + costo  + "- grupo " + grupo  + "\n";
    }
    
    
    
    
}
