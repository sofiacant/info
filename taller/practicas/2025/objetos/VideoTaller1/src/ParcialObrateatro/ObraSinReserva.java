
package ParcialObrateatro;

public class ObraSinReserva extends Obra {
    private int cantEntradas;
    private double precio;

    public ObraSinReserva(int cantEntradas, double precio, String nombre, String nombreDirector, int cantActores, int capacidadMax) {
        super(nombre, nombreDirector, cantActores, capacidadMax);
        this.cantEntradas = cantEntradas;
        this.precio = precio;
                
    }

    public void setCantEntradas() {
        this.cantEntradas = 0;
    }
    
    public void vaciarObra(){
         setCantEntradas();
    }

    public int getCantEntradas() {
        return cantEntradas;
    }

    public double getPrecio() {
        return precio;
    }
    
    
    public double calcularRecaudacion(){
        double total= (getCantEntradas() * getPrecio());
        return total;
    }
    
}
    

