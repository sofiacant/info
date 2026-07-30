/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica4.E3;

/**
 *
 * @author Sofia C
 */
public class Trabajador extends Persona{
    
    private String tarea;
    
    public Trabajador(String unaTarea, String unNombre, int unDni, int edad){
        super(unNombre,unDni,edad);
        setTarea(unaTarea);
    } 
    
    public void setTarea(String unaTarea){
        this.tarea= unaTarea;
    }

    public String getTarea() {
        return tarea;
    }
    
   public String toString(){
       String aux= super.toString() + " Soy "+ getTarea() + ".";
       return aux; 
   } 
    
  }

