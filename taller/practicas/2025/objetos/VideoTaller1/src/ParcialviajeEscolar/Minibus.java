/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialviajeEscolar;

/**
 *
 * @author Sofia C
 */
public class Minibus {
    private String patente;
    private int capacidad;
    private Alumno [] vAlumnos;
    private int dimL;

    public Minibus(String patente, int capacidad) {
        this.patente = patente;
        this.capacidad = capacidad;
        this.vAlumnos = new Alumno[capacidad];
        this.dimL = 0;
        
    }

    public String getPatente() {
        return patente;
    }

    public boolean agregarAlumno(Alumno a) {
        boolean aux=false;
        if (dimL < capacidad) {
            vAlumnos[dimL] = a;
            dimL++;
            aux=true;
        
    }
    return aux;
    }
    
    public int getCantAlumnos() {
        return dimL;
    }
    
}
