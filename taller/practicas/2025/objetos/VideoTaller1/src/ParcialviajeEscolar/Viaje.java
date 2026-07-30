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
public class Viaje {
    private String nombreColegio;
    private int fecha;
    private String destino;
    private Minibus  minibus1;
    private Minibus  minibus2;  
    private int dimF1;
    private int dimF2;
    private int diml1;
    private int diml2;

    public Viaje(String nombreColegio, int fecha, String destino,Minibus m1,Minibus m2) {
        this.nombreColegio = nombreColegio;
        this.fecha = fecha;
        this.destino = destino;
        this.minibus1= m1;
        this.minibus2= m2;
        this.diml1=0;
        this.diml2=0;
    }

    public int getDimF1() {
        return dimF1;
    }

    public int getDimF2() {
        return dimF2;
    }

    public int getDiml1() {
        return diml1;
    }

    public int getDiml2() {
        return diml2;
    }
    
    
    
    public String agregarAlumno(Alumno a){
        String aux="";
        int cant1=(dimF1-diml1);
        int cant2=(dimF2-diml2);
        if( cant1>cant2){
            aux+= this.minibus1.getPatente();
        
            diml1++;
            
        }else{
            aux+=minibus2.getPatente();
        
            diml2++;
        }
        return aux;
    }
    
    
    
 
    
    
    
    
     
            
}
