
package ParcialObrateatro;

import PaqueteLectura.GeneradorAleatorio;

public class Butaca {
    private double precio;
    private boolean ocupada;

    public Butaca(double precio) {
        this.precio = precio;
        this.ocupada = false;
    }

    public boolean isOcupada() {
        return ocupada;
    }
        
    public void setOcupada() {
        this.ocupada = true;
    }
    
    public void desocupar(){
        this.ocupada=false;
    }
    
    public void setPrecio() {
        this.precio = GeneradorAleatorio.generarDouble(1000);
    }

    public double getPrecio() {
        return precio;
    }
    
    
}
