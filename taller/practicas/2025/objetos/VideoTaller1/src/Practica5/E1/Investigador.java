/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica5.E1;

/**
 *
 * @author valen
 */
public class Investigador {
    private String nombreCompleto;
    private int categ;
    private String especialidad;
    private int dimFinv=5;
    private int dimLinv=0;
    Subsidio [] vecSubsidios;
    
    public Investigador (String unNombreCompleto, int unaCateg, String unaEspecialidad){
        this.nombreCompleto=unNombreCompleto;
        setCateg(unaCateg);
        this.especialidad=unaEspecialidad;
        vecSubsidios= new Subsidio [dimFinv];
    }    
    public void setCateg(int categ) {
        if ((categ >= 1) && (categ <=5))
            this.categ = categ; 
    }

    public void agregarSubsidio (Subsidio unSubsidio){
        if (dimLinv<dimFinv){
            vecSubsidios[dimLinv]=unSubsidio;
            vecSubsidios[dimLinv].setOtorgado(true);
            dimLinv++;
        }
    }
    
    public int getDimL (){
        return dimLinv;
    }
    
    public double getTotalSubsidios (){
        int suma=0;
        for (int i=0;i<dimLinv; i++){
            suma+=vecSubsidios[i].getMonto();
        }
        return suma;
    }

    public String toString() {
        return "Investigador " + nombreCompleto + "| categ " + categ + "| especialidad " + especialidad+" | " ;
    }
    
    
    public  void otorgarTodos(String nombreCompleto){
        String str="";
        for (int i=0; i<dimLinv; i++){
            if (vecSubsidios[i].isOtorgado())
                str+=" "+vecSubsidios[i].toString()+" \n";
        }
        System.out.println(this.toString()+" \n"+str);
    }

    
}
