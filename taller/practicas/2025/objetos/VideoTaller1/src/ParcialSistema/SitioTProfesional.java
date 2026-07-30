/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialSistema;

public class SitioTProfesional extends Sitio {
    private Torneo[]torneo;
    private int N;
    private int dimL;

    public SitioTProfesional(int N, String nombre, String direccionWeb) {
        super(nombre, direccionWeb);
        this.N = N;
        setTorneo(N);
        
    }
        
    public void setTorneo(int N){
        this.torneo= new Torneo[N];   
    }
    
    public boolean registrarTorneoProfesional(Torneo t){
        boolean aux=false;
        if(dimL<N){
            torneo[dimL]= t;
            dimL++;
            aux=true;
        }
        return aux;
    }
    
    public double cotizarSitio(){
        double valor=0;
        for(int i=0; i<dimL; i++){
            valor+= (1000+ torneo[i].getMontoRecaudadoPorTorneo());
        }
        return valor;
    }
    
    
    
}


