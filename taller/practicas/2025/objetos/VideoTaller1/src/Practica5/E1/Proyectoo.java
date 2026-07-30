
package Practica5.E1;

import Practica5.E1.Investigadorr;


public class Proyectoo {
    private String nombre;
    private int codigo;
    private String nombreCompleto;
    private int dimFInv=50;
    private int dimLInv=0;
    Investigadorr [] vecInv;
    
   public Proyectoo(String nombre,int codigo, String nombreCompleto){
    this.nombre=nombre;
    this.codigo=codigo;
    this.nombreCompleto=nombreCompleto;
    this.vecInv= new Investigadorr[dimFInv];
   }
 
   public void agregarInvestigador(Investigadorr unInvestigador){
       if(dimLInv<this.dimFInv){
            vecInv[dimLInv]=unInvestigador;
            dimLInv++;
       }
   }
   
    public double getMontoTotal(){
        double montoTotal=0;
        for(int i=0; i<dimLInv;i++){
            montoTotal = vecInv[i].getMontoInv();
        }
        return montoTotal;
    }
    
     public String toString() {
        String aux = "";
        for (int i = 0; i < dimLInv; i++) {
            aux += vecInv[i].toString() + " Total: " + vecInv[i].getMontoInv()+"\n";
        }
        return "---  "+nombre + " Codigo: "+codigo +" Nombre del Director: "+nombreCompleto+" ---"+ "\n" + aux;
    }

    

 }
