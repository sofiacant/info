
package ParcialObrateatro;

public abstract class Obra {
    private String nombre;
    private String nombreDirector;
    private int cantActores;
    private int capacidadMax;

    public Obra(String nombre, String nombreDirector, int cantActores, int capacidadMax) {
        this.nombre = nombre;
        this.nombreDirector = nombreDirector;
        this.cantActores = cantActores;
        this.capacidadMax = capacidadMax;
    }
    
    public abstract void vaciarObra();
    
    public abstract double calcularRecaudacion();

    @Override
    public String toString() {
        return "Nombre de la obra " + nombre + "...Director " +
                nombreDirector + "... cantidad de actores en escena " + cantActores + "...total recaudado $"+
                this.calcularRecaudacion();
    }
    
    
    
}
