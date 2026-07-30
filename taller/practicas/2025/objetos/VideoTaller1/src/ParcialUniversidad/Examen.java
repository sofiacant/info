/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialUniversidad;

/**
 *
 * @author Sofia C
 */
public class Examen {
    private int mes;
    private int año;
    private double calificacion;
    private String modalidad;

    public Examen(int mes, int año, double calificacion, String modalidad) {
        this.mes = mes;
        this.año = año;
        this.calificacion = calificacion;
        this.modalidad = modalidad;
    }

    public int getMes() {
        return mes;
    }

    public int getAño() {
        return año;
    }

    public String getModalidad() {
        return modalidad;
    }
    
    public double getCalificacion(){
        return calificacion;
    }
    
    
    
    
}
