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
public class Alumno {

    private String nombre;
    private String apellido;
    private String legajo;
    private Examen[] vExamenes;
    private int dimL;
    private int dimF;

    public Alumno(String nombre, String apellido, String legajo, int M) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.legajo = legajo;
        this.dimL = 0;
        this.dimF = M;
        this.vExamenes = new Examen[dimF];
    }

    public String getLegajo() {
        return legajo;
    }

    public void setExamen(Examen e) {
        vExamenes[dimL] = e;
        dimL++;

    }

    public int getExamenesRequeridos(int mes, int año, String modalidad) {
        int cant = 0;
        for (int i = 0; i < dimL; i++) {
            if ((vExamenes[i].getMes() == mes) && (vExamenes[i].getAño() == año)
                    && (vExamenes[i].getModalidad().equals(modalidad))) {
                cant++;

            }
        }
        return cant;

    }
    
    public double calcularPromedio(){
        double promedio=0;
        double total=0;
        for(int i=0; i<dimL; i++){
            total+= vExamenes[dimL].getCalificacion();
        }
        promedio= ((double)(total/dimL));
        return promedio;
    }
    
    public String toString (){
        return "Nombre: "+this.nombre+" Apellido: "+this.apellido;
    }
    
}
