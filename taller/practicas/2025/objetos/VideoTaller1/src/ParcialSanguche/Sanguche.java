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
public class Sanguche {
    private String nombre;
    private Pan pan;
    private Ingrediente [] vIngredientes;
    private int dimF;
    private int dimL;

    public Sanguche(String nombre, Pan pan, int N) {
        this.nombre = nombre;
        this.pan = pan;
        this.dimL=0;
        this.dimF = N;
        this.vIngredientes= new Ingrediente[dimF];
    }
    
    public boolean hayLugar(){
        return (dimL<dimF); 
    }
    
    
    public boolean agregarIngrediente(Ingrediente ing){
        boolean aux=false;
        if(hayLugar()){
            vIngredientes[dimL]= ing;
            this.dimL++;
            aux=true;
        }
        return aux;
    }

    public double costoTotalIngredientes(){
        double total=0;
        for(int i=0; i<dimL; i++){
          total+= vIngredientes[i].getCosto();
        }
        return total;
    }
    
    public double costoFinal(){
        double costo;
        costo= pan.costoFinal()+ costoTotalIngredientes();
        return costo;
    }
    
    
    
    public String toString() {
        String aux="";
        for (int i=0; i<dimL; i++){
            aux+= "Ingrediente  "+ (i+1) + vIngredientes[i].toString();
        }
                
       return "Sanguche nombre " + nombre + "\n" + pan.toString() + "\n" +" cantidad de ingredientes: "+ this.dimL+
               aux +"\n "+ "Costo final del sanguche "+ costoFinal();
    }
    
    
    
}
